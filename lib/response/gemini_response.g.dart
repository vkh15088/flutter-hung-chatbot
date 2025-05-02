// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeminiResponse _$GeminiResponseFromJson(Map<String, dynamic> json) =>
    GeminiResponse(
      candidates: (json['candidates'] as List<dynamic>?)
              ?.map((e) => Candidate.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      usageMetadata: json['usageMetadata'] == null
          ? const UsageMetadata()
          : UsageMetadata.fromJson(
              json['usageMetadata'] as Map<String, dynamic>),
      modelVersion: json['modelVersion'] as String? ?? '',
    );

Map<String, dynamic> _$GeminiResponseToJson(GeminiResponse instance) =>
    <String, dynamic>{
      'candidates': instance.candidates,
      'usageMetadata': instance.usageMetadata,
      'modelVersion': instance.modelVersion,
    };
