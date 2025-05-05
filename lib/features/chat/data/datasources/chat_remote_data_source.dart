import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_hung_chatbot/core/error/exceptions.dart';
import 'package:flutter_hung_chatbot/features/chat/data/dtos/gemini_base_dto.dart';
import 'package:flutter_hung_chatbot/features/chat/data/dtos/gemini_request_dto.dart';
import 'package:flutter_hung_chatbot/features/chat/data/dtos/gemini_response_dto.dart';
import 'package:flutter_hung_chatbot/flavors.dart';

abstract class ChatRemoteDataSource {
  /// Calls the Gemini API to get a response for the given message
  ///
  /// Throws a [ServerException] for all error codes
  Future<GeminiResponseDto> sendMessage(String message);

  /// Streams the Gemini API response for the given message
  ///
  /// Throws a [ServerException] for all error codes
  Stream<GeminiResponseDto> getMessageStream(String message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;
  final String apiKey;
  final String baseUrl = F.getGoogleApi;

  ChatRemoteDataSourceImpl({required this.dio, required this.apiKey});

  @override
  Future<GeminiResponseDto> sendMessage(String message) async {
    try {
      final response = await dio.post(
        '$baseUrl:generateContent',
        queryParameters: {'key': apiKey},
        data:
            GeminiRequestDto(
              contents: [
                ContentDto(parts: [PartDto(text: message)]),
              ],
            ).toJson(),
      );

      return GeminiResponseDto.fromJson(response.data);
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Stream<GeminiResponseDto> getMessageStream(String message) async* {
    try {
      final response = await dio.post(
        '$baseUrl:streamGenerateContent',
        queryParameters: {'alt': 'sse', 'key': apiKey},
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
          throw ServerException();
        }
      }
    } catch (_) {
      throw ServerException();
    }
  }
}
