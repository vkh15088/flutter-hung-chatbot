import 'package:dio/dio.dart';
import 'package:flutter_hung_chatbot/features/chat/data/dtos/gemini_error_dto.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/entities/gemini/gemini_error.dart';

/// Factory class for creating standardized GeminiError objects
class GeminiErrorFactory {
  /// Creates a cache-related error
  static GeminiError createCacheError() => GeminiError(
    error: const ErrorEntity(code: 0, message: 'Failed to save message to cache', status: 'Cache Error', details: []),
  );

  /// Creates an error for chat history retrieval issues
  static GeminiError createRetrieveCacheError() => GeminiError(
    error: const ErrorEntity(code: 0, message: 'Failed to retrieve chat history', status: 'Cache Error', details: []),
  );

  /// Creates a server-related error
  static GeminiError createServerError({String? customMessage}) => GeminiError(
    error: ErrorEntity(
      code: 500,
      message: customMessage ?? 'Server error occurred',
      status: 'Server Error',
      details: const [],
    ),
  );

  /// Creates a network connectivity error with optional custom message
  static GeminiError createNetworkError({String? customMessage}) => GeminiError(
    error: ErrorEntity(code: 0, message: customMessage ?? 'Network error', status: 'Network Error', details: const []),
  );

  /// Creates a general unexpected error
  static GeminiError createUnexpectedError() => GeminiError(
    error: const ErrorEntity(code: 0, message: 'Unexpected error occurred', status: 'Error', details: []),
  );

  /// Creates an error for unexpected data format issues
  static GeminiError createUnexpectedDataError(String message) =>
      GeminiError(error: ErrorEntity(code: 0, message: message, status: 'Unexpected Data Error', details: const []));

  /// Creates an error for response processing issues
  static GeminiError createProcessingError() => GeminiError(
    error: const ErrorEntity(code: 0, message: 'Unable to process response', status: 'Processing Error', details: []),
  );

  /// Creates an error from a DioException
  static GeminiError createDioError(DioException e) =>
      GeminiError(error: ErrorDto.fromJson(e.response?.data ?? {}).toEntity());
}
