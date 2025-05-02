// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeminiRequest _$GeminiRequestFromJson(Map<String, dynamic> json) =>
    GeminiRequest(
      contents: (json['contents'] as List<dynamic>?)
              ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GeminiRequestToJson(GeminiRequest instance) =>
    <String, dynamic>{
      'contents': instance.contents,
    };
