// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeminiResponseDto _$GeminiResponseDtoFromJson(Map<String, dynamic> json) =>
    GeminiResponseDto(
      candidates: (json['candidates'] as List<dynamic>?)
              ?.map((e) => CandidateDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      usageMetadata: json['usageMetadata'] == null
          ? const UsageMetadataDto()
          : UsageMetadataDto.fromJson(
              json['usageMetadata'] as Map<String, dynamic>),
      modelVersion: json['modelVersion'] as String? ?? '',
    );

Map<String, dynamic> _$GeminiResponseDtoToJson(GeminiResponseDto instance) =>
    <String, dynamic>{
      'candidates': instance.candidates,
      'usageMetadata': instance.usageMetadata,
      'modelVersion': instance.modelVersion,
    };
