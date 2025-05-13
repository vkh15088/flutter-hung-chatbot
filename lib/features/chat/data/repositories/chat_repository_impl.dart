import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hung_chatbot/core/error/exceptions.dart';
import 'package:flutter_hung_chatbot/core/network/network_info.dart';
import 'package:flutter_hung_chatbot/features/chat/data/datasources/chat_local_data_source.dart';
import 'package:flutter_hung_chatbot/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:flutter_hung_chatbot/features/chat/data/models/chat_message_model.dart';
import 'package:flutter_hung_chatbot/features/chat/data/utils/gemini_error_factory.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/entities/chat_message/chat_message.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/entities/gemini/gemini_error.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final ChatLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});

  /// Helper method to create an AI message from an error and save it to the local data source
  Future<void> _createAndSaveErrorMessage(GeminiError error) async {
    final aiMessage = ChatMessageModel.gemini(error.error.message);
    try {
      await localDataSource.addChatMessage(aiMessage);
    } on CacheException {
      // Silently handle cache exceptions when saving error messages
      // to avoid cascading errors
    }
  }

  /// Helper method to handle common error cases and return a Left with the appropriate error
  Future<Left<GeminiError, T>> _handleError<T>(GeminiError error) async {
    final aiMessage = ChatMessageModel.gemini(error.error.message);
    try {
      await localDataSource.addChatMessage(aiMessage);
    } on CacheException {
      // Silently handle cache exceptions when saving error messages
      // to avoid cascading errors
    }
    return Left(error);
  }

  /// Helper method to check network connectivity
  Future<bool> _checkNetworkConnectivity() async {
    return await networkInfo.isConnected;
  }

  @override
  Future<Either<List<ChatMessage>, List<ChatMessage>>> getChatHistory() async {
    try {
      final localMessages = await localDataSource.getChatHistory();
      return Right(localMessages.map((model) => model.toEntity()).toList());
    } on CacheException {
      // Return empty list on cache exception
      return const Left([]);
    } catch (e) {
      // Return empty list on any other exception
      return const Left([]);
    }
  }

  @override
  Future<Either<GeminiError, ChatMessage>> sendMessage(String message, String model) async {
    // Add user message to cache
    final userMessage = ChatMessageModel.user(message);
    await localDataSource.addChatMessage(userMessage);

    if (!await _checkNetworkConnectivity()) {
      return await _handleError(GeminiErrorFactory.createNetworkError());
    }

    try {
      // Get AI response
      final response = await remoteDataSource.sendMessage(message, model);
      final aiMessage = ChatMessageModel.gemini(response.candidates.first.content.parts.first.text);

      // Add AI response to cache
      await localDataSource.addChatMessage(aiMessage);

      return Right(aiMessage.toEntity());
    } on ServerException catch (e) {
      return await _handleError(GeminiErrorFactory.createServerError(customMessage: e.message));
    } on CacheException {
      return await _handleError(GeminiErrorFactory.createCacheError());
    } on UnexpectedDataException catch (e) {
      return await _handleError(GeminiErrorFactory.createUnexpectedDataError(e.message));
    } on DioException catch (e) {
      return await _handleError(GeminiErrorFactory.createDioError(e));
    } catch (e) {
      return await _handleError(GeminiErrorFactory.createUnexpectedError());
    }
  }

  @override
  Stream<Either<GeminiError, String>> getMessageStream(String message, String model) async* {
    // Add user message to cache
    final userMessage = ChatMessageModel.user(message);
    await localDataSource.addChatMessage(userMessage);

    if (!await _checkNetworkConnectivity()) {
      final networkError = GeminiErrorFactory.createNetworkError();
      await _createAndSaveErrorMessage(networkError);
      yield Left(networkError);
      return;
    }

    try {
      // Add empty AI message to cache that will be updated with stream chunks
      final emptyAiMessage = ChatMessageModel.gemini('');
      try {
        await localDataSource.addChatMessage(emptyAiMessage);
      } on CacheException {
        final cacheError = GeminiErrorFactory.createCacheError();
        await _createAndSaveErrorMessage(cacheError);
        yield Left(cacheError);
        return;
      }

      // Get the current chat history to update the last message
      List<ChatMessageModel> chatHistory;
      try {
        chatHistory = await localDataSource.getChatHistory();
      } on CacheException {
        final retrieveError = GeminiErrorFactory.createRetrieveCacheError();
        await _createAndSaveErrorMessage(retrieveError);
        yield Left(retrieveError);
        return;
      }

      // Process the stream
      try {
        await for (final response in remoteDataSource.getMessageStream(message, model)) {
          try {
            for (final candidate in response.candidates) {
              for (final part in candidate.content.parts) {
                // Update the last message in the chat history
                if (chatHistory.isNotEmpty) {
                  // Create a new message with updated content since message is final
                  final lastMessage = chatHistory.last;
                  final updatedMessage = ChatMessageModel(
                    sender: lastMessage.sender,
                    message: lastMessage.message + part.text,
                  );

                  // Replace the last message in the list
                  chatHistory[chatHistory.length - 1] = updatedMessage;
                  try {
                    await localDataSource.cacheChatMessages(chatHistory);
                  } on CacheException {
                    final cacheError = GeminiErrorFactory.createCacheError();
                    await _createAndSaveErrorMessage(cacheError);
                    yield Left(cacheError);
                    return;
                  }
                }

                yield Right(part.text);
              }
            }
          } on UnexpectedDataException catch (e) {
            final dataError = GeminiErrorFactory.createUnexpectedDataError(e.message);
            await _createAndSaveErrorMessage(dataError);
            yield Left(dataError);
          } catch (e) {
            final processingError = GeminiErrorFactory.createProcessingError();
            await _createAndSaveErrorMessage(processingError);
            yield Left(processingError);
          }
        }
      } on ServerException catch (e) {
        final serverError = GeminiErrorFactory.createServerError(customMessage: e.message);
        await _createAndSaveErrorMessage(serverError);
        yield Left(serverError);
      } on NetworkException {
        final networkError = GeminiErrorFactory.createNetworkError(customMessage: 'Network error during streaming');
        await _createAndSaveErrorMessage(networkError);
        yield Left(networkError);
      } on DioException catch (e) {
        final dioError = GeminiErrorFactory.createDioError(e);
        await _createAndSaveErrorMessage(dioError);
        yield Left(dioError);
      }
    } on Exception {
      final unexpectedError = GeminiErrorFactory.createUnexpectedError();
      await _createAndSaveErrorMessage(unexpectedError);
      yield Left(unexpectedError);
    }
  }
}
