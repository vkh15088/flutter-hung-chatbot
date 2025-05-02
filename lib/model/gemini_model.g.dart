// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Candidate _$CandidateFromJson(Map<String, dynamic> json) => Candidate(
      content: json['content'] == null
          ? const Content()
          : Content.fromJson(json['content'] as Map<String, dynamic>),
      finishReason: json['finishReason'] as String? ?? '',
      citationMetadata: json['citationMetadata'] == null
          ? const CitationMetadata()
          : CitationMetadata.fromJson(
              json['citationMetadata'] as Map<String, dynamic>),
      avgLogprobs: (json['avgLogprobs'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$CandidateToJson(Candidate instance) => <String, dynamic>{
      'content': instance.content,
      'finishReason': instance.finishReason,
      'citationMetadata': instance.citationMetadata,
      'avgLogprobs': instance.avgLogprobs,
    };

CitationMetadata _$CitationMetadataFromJson(Map<String, dynamic> json) =>
    CitationMetadata(
      citationSources: (json['citationSources'] as List<dynamic>?)
              ?.map((e) => CitationSource.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CitationMetadataToJson(CitationMetadata instance) =>
    <String, dynamic>{
      'citationSources': instance.citationSources,
    };

CitationSource _$CitationSourceFromJson(Map<String, dynamic> json) =>
    CitationSource(
      startIndex: (json['startIndex'] as num?)?.toInt() ?? 0,
      endIndex: (json['endIndex'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CitationSourceToJson(CitationSource instance) =>
    <String, dynamic>{
      'startIndex': instance.startIndex,
      'endIndex': instance.endIndex,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      parts: (json['parts'] as List<dynamic>?)
              ?.map((e) => Part.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      role: json['role'] as String? ?? '',
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'parts': instance.parts,
      'role': instance.role,
    };

Part _$PartFromJson(Map<String, dynamic> json) => Part(
      text: json['text'] as String? ?? '',
    );

Map<String, dynamic> _$PartToJson(Part instance) => <String, dynamic>{
      'text': instance.text,
    };

UsageMetadata _$UsageMetadataFromJson(Map<String, dynamic> json) =>
    UsageMetadata(
      promptTokenCount: (json['promptTokenCount'] as num?)?.toInt() ?? 0,
      candidatesTokenCount:
          (json['candidatesTokenCount'] as num?)?.toInt() ?? 0,
      totalTokenCount: (json['totalTokenCount'] as num?)?.toInt() ?? 0,
      promptTokensDetails: (json['promptTokensDetails'] as List<dynamic>?)
              ?.map((e) => TokensDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      candidatesTokensDetails:
          (json['candidatesTokensDetails'] as List<dynamic>?)
                  ?.map((e) => TokensDetail.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const [],
    );

Map<String, dynamic> _$UsageMetadataToJson(UsageMetadata instance) =>
    <String, dynamic>{
      'promptTokenCount': instance.promptTokenCount,
      'candidatesTokenCount': instance.candidatesTokenCount,
      'totalTokenCount': instance.totalTokenCount,
      'promptTokensDetails': instance.promptTokensDetails,
      'candidatesTokensDetails': instance.candidatesTokensDetails,
    };

TokensDetail _$TokensDetailFromJson(Map<String, dynamic> json) => TokensDetail(
      modality: json['modality'] as String? ?? '',
      tokenCount: (json['tokenCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TokensDetailToJson(TokensDetail instance) =>
    <String, dynamic>{
      'modality': instance.modality,
      'tokenCount': instance.tokenCount,
    };
