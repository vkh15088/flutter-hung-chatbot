import 'package:flutter_hung_chatbot/features/chat/domain/entities/gemini/gemini_base.dart';

class GeminiResponse {
  final List<Candidate> candidates;
  final UsageMetadata usageMetadata;
  final String modelVersion;

  GeminiResponse({required this.candidates, required this.usageMetadata, required this.modelVersion});
}
