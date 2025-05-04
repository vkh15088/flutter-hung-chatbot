import 'package:flutter_hung_chatbot/features/chat/data/dtos/gemini_base_dto.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/entities/gemini/gemini_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gemini_response_dto.g.dart';

@JsonSerializable()
class GeminiResponseDto {
  @JsonKey(name: "candidates")
  final List<CandidateDto> candidates;
  @JsonKey(name: "usageMetadata")
  final UsageMetadataDto usageMetadata;
  @JsonKey(name: "modelVersion")
  final String modelVersion;

  GeminiResponseDto({
    this.candidates = const [],
    this.usageMetadata = const UsageMetadataDto(),
    this.modelVersion = '',
  });

  GeminiResponseDto copyWith({List<CandidateDto>? candidates, UsageMetadataDto? usageMetadata, String? modelVersion}) =>
      GeminiResponseDto(
        candidates: candidates ?? this.candidates,
        usageMetadata: usageMetadata ?? this.usageMetadata,
        modelVersion: modelVersion ?? this.modelVersion,
      );

  factory GeminiResponseDto.fromJson(Map<String, dynamic> json) => _$GeminiResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GeminiResponseDtoToJson(this);

  GeminiResponse toEntity() {
    return GeminiResponse(
      candidates: candidates.map((candidate) => candidate.toEntity()).toList(),
      usageMetadata: usageMetadata.toEntity(),
      modelVersion: modelVersion,
    );
  }

  static GeminiResponseDto fromEntity(GeminiResponse geminiResponse) {
    return GeminiResponseDto(
      candidates: geminiResponse.candidates.map((candidate) => CandidateDto.fromEntity(candidate)).toList(),
      usageMetadata: UsageMetadataDto.fromEntity(geminiResponse.usageMetadata),
      modelVersion: geminiResponse.modelVersion,
    );
  }
}
