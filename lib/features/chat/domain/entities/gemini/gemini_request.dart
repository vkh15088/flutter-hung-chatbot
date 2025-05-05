import 'package:flutter_hung_chatbot/features/chat/domain/entities/gemini/gemini_base.dart';

class GeminiRequest {
  final List<Content> contents;
  GeminiRequest({required this.contents});
}
