import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hung_chatbot/model/gemini_model.dart';
import 'package:flutter_hung_chatbot/repository/constants.dart';
import 'package:flutter_hung_chatbot/request/gemini_request.dart';
import 'package:flutter_hung_chatbot/response/gemini_response.dart';
import 'package:flutter_hung_chatbot/service/dio_instance.dart';

class ChatRepository {
  static Future<Either<GeminiResponse, GeminiResponse>> postGemini(String apiKey, String content) async {
    try {
      final response = await DioInstance().dio.post(
        '${Constants.model}:generateContent',
        queryParameters: {'key': apiKey},
        data:
            GeminiRequest(
              contents: [
                Content(parts: [Part(text: content)]),
              ],
            ).toJson(),
      );
      return Right(GeminiResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(GeminiResponse());
    }
  }

  static Stream<Either<GeminiResponse, GeminiResponse>> postGeminiStream(String apiKey, String content) async* {
    try {
      final response = await DioInstance().dio.post(
        '${Constants.model}:streamGenerateContent',
        queryParameters: {'alt': 'sse', 'key': apiKey},
        options: Options(responseType: ResponseType.stream),
        data:
            GeminiRequest(
              contents: [
                Content(parts: [Part(text: content)]),
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
          yield Right(GeminiResponse.fromJson(parsed)); // Yield per chunk
        } catch (e) {
          yield Left(GeminiResponse());
        }
      }
    } on DioException catch (e) {
      yield Left(GeminiResponse());
    }
  }
}
