import 'package:flutter_hung_chatbot/model/gemini_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gemini_response.g.dart';

@JsonSerializable()
class GeminiResponse {
  @JsonKey(name: "candidates")
  final List<Candidate> candidates;
  @JsonKey(name: "usageMetadata")
  final UsageMetadata usageMetadata;
  @JsonKey(name: "modelVersion")
  final String modelVersion;

  GeminiResponse({this.candidates = const [], this.usageMetadata = const UsageMetadata(), this.modelVersion = ''});

  GeminiResponse copyWith({List<Candidate>? candidates, UsageMetadata? usageMetadata, String? modelVersion}) =>
      GeminiResponse(
        candidates: candidates ?? this.candidates,
        usageMetadata: usageMetadata ?? this.usageMetadata,
        modelVersion: modelVersion ?? this.modelVersion,
      );

  factory GeminiResponse.fromJson(Map<String, dynamic> json) => _$GeminiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeminiResponseToJson(this);
}
