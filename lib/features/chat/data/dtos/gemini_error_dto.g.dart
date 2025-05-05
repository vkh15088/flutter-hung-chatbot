// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_error_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeminiErrorDto _$GeminiErrorDtoFromJson(Map<String, dynamic> json) =>
    GeminiErrorDto(
      error: json['error'] == null
          ? const ErrorDto()
          : ErrorDto.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeminiErrorDtoToJson(GeminiErrorDto instance) =>
    <String, dynamic>{
      'error': instance.error,
    };

ErrorDto _$ErrorDtoFromJson(Map<String, dynamic> json) => ErrorDto(
      code: (json['code'] as num?)?.toInt() ?? 0,
      message: json['message'] as String? ?? '',
      status: json['status'] as String? ?? '',
      details: (json['details'] as List<dynamic>?)
              ?.map((e) => DetailDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ErrorDtoToJson(ErrorDto instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'details': instance.details,
    };

DetailDto _$DetailDtoFromJson(Map<String, dynamic> json) => DetailDto(
      type: json['@type'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
      domain: json['domain'] as String? ?? '',
      metadata: json['metadata'] == null
          ? const MetadataDto()
          : MetadataDto.fromJson(json['metadata'] as Map<String, dynamic>),
      locale: json['locale'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$DetailDtoToJson(DetailDto instance) => <String, dynamic>{
      '@type': instance.type,
      'reason': instance.reason,
      'domain': instance.domain,
      'metadata': instance.metadata,
      'locale': instance.locale,
      'message': instance.message,
    };

MetadataDto _$MetadataDtoFromJson(Map<String, dynamic> json) => MetadataDto(
      service: json['service'] as String? ?? '',
    );

Map<String, dynamic> _$MetadataDtoToJson(MetadataDto instance) =>
    <String, dynamic>{
      'service': instance.service,
    };
