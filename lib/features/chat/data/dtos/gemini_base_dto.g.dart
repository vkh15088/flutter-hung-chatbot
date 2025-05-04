// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_base_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CandidateDto _$CandidateDtoFromJson(Map<String, dynamic> json) => CandidateDto(
      content: json['content'] == null
          ? const ContentDto()
          : ContentDto.fromJson(json['content'] as Map<String, dynamic>),
      finishReason: json['finishReason'] as String? ?? '',
      citationMetadata: json['citationMetadata'] == null
          ? const CitationMetadataDto()
          : CitationMetadataDto.fromJson(
              json['citationMetadata'] as Map<String, dynamic>),
      avgLogprobs: (json['avgLogprobs'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$CandidateDtoToJson(CandidateDto instance) =>
    <String, dynamic>{
      'content': instance.content,
      'finishReason': instance.finishReason,
      'citationMetadata': instance.citationMetadata,
      'avgLogprobs': instance.avgLogprobs,
    };

CitationMetadataDto _$CitationMetadataDtoFromJson(Map<String, dynamic> json) =>
    CitationMetadataDto(
      citationSources: (json['citationSources'] as List<dynamic>?)
              ?.map(
                  (e) => CitationSourceDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CitationMetadataDtoToJson(
        CitationMetadataDto instance) =>
    <String, dynamic>{
      'citationSources': instance.citationSources,
    };

CitationSourceDto _$CitationSourceDtoFromJson(Map<String, dynamic> json) =>
    CitationSourceDto(
      startIndex: (json['startIndex'] as num?)?.toInt() ?? 0,
      endIndex: (json['endIndex'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CitationSourceDtoToJson(CitationSourceDto instance) =>
    <String, dynamic>{
      'startIndex': instance.startIndex,
      'endIndex': instance.endIndex,
    };

ContentDto _$ContentDtoFromJson(Map<String, dynamic> json) => ContentDto(
      parts: (json['parts'] as List<dynamic>?)
              ?.map((e) => PartDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      role: json['role'] as String? ?? '',
    );

Map<String, dynamic> _$ContentDtoToJson(ContentDto instance) =>
    <String, dynamic>{
      'parts': instance.parts,
      'role': instance.role,
    };

PartDto _$PartDtoFromJson(Map<String, dynamic> json) => PartDto(
      text: json['text'] as String? ?? '',
    );

Map<String, dynamic> _$PartDtoToJson(PartDto instance) => <String, dynamic>{
      'text': instance.text,
    };

UsageMetadataDto _$UsageMetadataDtoFromJson(Map<String, dynamic> json) =>
    UsageMetadataDto(
      promptTokenCount: (json['promptTokenCount'] as num?)?.toInt() ?? 0,
      candidatesTokenCount:
          (json['candidatesTokenCount'] as num?)?.toInt() ?? 0,
      totalTokenCount: (json['totalTokenCount'] as num?)?.toInt() ?? 0,
      promptTokensDetails: (json['promptTokensDetails'] as List<dynamic>?)
              ?.map((e) => TokensDetailDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      candidatesTokensDetails: (json['candidatesTokensDetails']
                  as List<dynamic>?)
              ?.map((e) => TokensDetailDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UsageMetadataDtoToJson(UsageMetadataDto instance) =>
    <String, dynamic>{
      'promptTokenCount': instance.promptTokenCount,
      'candidatesTokenCount': instance.candidatesTokenCount,
      'totalTokenCount': instance.totalTokenCount,
      'promptTokensDetails': instance.promptTokensDetails,
      'candidatesTokensDetails': instance.candidatesTokensDetails,
    };

TokensDetailDto _$TokensDetailDtoFromJson(Map<String, dynamic> json) =>
    TokensDetailDto(
      modality: json['modality'] as String? ?? '',
      tokenCount: (json['tokenCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TokensDetailDtoToJson(TokensDetailDto instance) =>
    <String, dynamic>{
      'modality': instance.modality,
      'tokenCount': instance.tokenCount,
    };
