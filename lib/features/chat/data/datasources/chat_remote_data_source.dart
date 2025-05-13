import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_hung_chatbot/core/error/exceptions.dart';
import 'package:flutter_hung_chatbot/features/chat/data/constants/api_constants.dart';
import 'package:flutter_hung_chatbot/features/chat/data/dtos/gemini_base_dto.dart';
import 'package:flutter_hung_chatbot/features/chat/data/dtos/gemini_request_dto.dart';
import 'package:flutter_hung_chatbot/features/chat/data/dtos/gemini_response_dto.dart';

abstract class ChatRemoteDataSource {
  /// Calls the Gemini API to get a response for the given message
  ///
  /// Throws a [ServerException] for all error codes
  Future<GeminiResponseDto> sendMessage(String message, String model);

  /// Streams the Gemini API response for the given message
  ///
  /// Throws a [ServerException] for all error codes
  Stream<GeminiResponseDto> getMessageStream(String message, String model);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;
  final String apiKey;

  ChatRemoteDataSourceImpl({required this.dio, required this.apiKey});

  @override
  Future<GeminiResponseDto> sendMessage(String message, String model) async {
    try {
      final response = await dio.post(
        '${ApiConstants.geminiBaseUrl}$model${ApiConstants.generateContentEndpoint}',
        queryParameters: {ApiConstants.apiKeyParam: apiKey},
        data:
            GeminiRequestDto(
              contents: [
                ContentDto(parts: [PartDto(text: message)]),
              ],
            ).toJson(),
      );

      return GeminiResponseDto.fromJson(response.data);
    } on DioException catch (e) {
      // Handle different types of DioExceptions with appropriate error messages
      if (e.type == DioExceptionType.badResponse) {
        // Extract error message from response if available
        String errorMessage = 'Unknown server error';
        if (e.response != null && e.response!.data is Map) {
          final errorData = e.response!.data as Map;
          if (errorData.containsKey('error') && errorData['error'] is Map) {
            final errorMap = errorData['error'] as Map;
            if (errorMap.containsKey('message') && errorMap['message'] is String) {
              errorMessage = errorMap['message'] as String;
            }
          }
        } else {
          errorMessage = 'Server returned an invalid response';
        }
        throw ServerException(errorMessage);
      } else if (e.type == DioExceptionType.connectionTimeout || 
                e.type == DioExceptionType.receiveTimeout || 
                e.type == DioExceptionType.sendTimeout) {
        throw ServerException('Connection timeout. Please try again later.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw ServerException('Connection error. Please check your internet connection.');
      } else if (e.type == DioExceptionType.cancel) {
        throw ServerException('Request was cancelled');
      } else {
        throw ServerException(e.message ?? 'Unknown network error occurred');
      }
    }
  }

  @override
  Stream<GeminiResponseDto> getMessageStream(String message, String model) async* {
    try {
      final response = await dio.post(
        '${ApiConstants.geminiBaseUrl}$model${ApiConstants.streamGenerateContentEndpoint}',
        queryParameters: {ApiConstants.altParam: ApiConstants.sseParameter, ApiConstants.apiKeyParam: apiKey},
        options: Options(responseType: ResponseType.stream),
        data:
            GeminiRequestDto(
              contents: [
                ContentDto(parts: [PartDto(text: message)]),
              ],
            ).toJson(),
      );

      final lineStream = response.data!.stream;

      await for (final line in lineStream) {
        String text = String.fromCharCodes(line);

        if (text.trim().isEmpty) continue;

        try {
          text = text.substring(6); // Remove the "data: " prefix
          final parsed = json.decode(text);
          yield GeminiResponseDto.fromJson(parsed);
        } catch (_) {
          throw ServerException('');
        }
      }
    } on DioException catch (e) {
      // Handle different types of DioExceptions with appropriate error messages
      if (e.type == DioExceptionType.badResponse) {
        // Extract error message from response if available
        String errorMessage = 'Unknown server error';
        if (e.response != null && e.response!.data is Map) {
          final errorData = e.response!.data as Map;
          if (errorData.containsKey('error') && errorData['error'] is Map) {
            final errorMap = errorData['error'] as Map;
            if (errorMap.containsKey('message') && errorMap['message'] is String) {
              errorMessage = errorMap['message'] as String;
            }
          }
        } else {
          errorMessage = 'Server returned an invalid response';
        }
        throw ServerException(errorMessage);
      } else if (e.type == DioExceptionType.connectionTimeout || 
                e.type == DioExceptionType.receiveTimeout || 
                e.type == DioExceptionType.sendTimeout) {
        throw ServerException('Connection timeout. Please try again later.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw ServerException('Connection error. Please check your internet connection.');
      } else if (e.type == DioExceptionType.cancel) {
        throw ServerException('Request was cancelled');
      } else {
        throw ServerException(e.message ?? 'Unknown network error occurred');
      }
    }
  }
}
