// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeminiRequestDto _$GeminiRequestDtoFromJson(Map<String, dynamic> json) =>
    GeminiRequestDto(
      contents: (json['contents'] as List<dynamic>?)
              ?.map((e) => ContentDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GeminiRequestDtoToJson(GeminiRequestDto instance) =>
    <String, dynamic>{
      'contents': instance.contents,
    };
