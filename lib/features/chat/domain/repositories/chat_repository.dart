import 'package:dartz/dartz.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/entities/chat_message/chat_message.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/entities/gemini/gemini_error.dart';

abstract class ChatRepository {
  /// Get all chat messages from local storage
  Future<Either<List<ChatMessage>, List<ChatMessage>>> getChatHistory();

  /// Send a message to the AI and get a response
  Future<Either<GeminiError, ChatMessage>> sendMessage(String message, String model);

  /// Get stream of AI responses for streaming mode
  Stream<Either<GeminiError, String>> getMessageStream(String message, String model);
}
