// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeminiError _$GeminiErrorFromJson(Map<String, dynamic> json) => GeminiError(
      error: json['error'] == null
          ? const Error()
          : Error.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeminiErrorToJson(GeminiError instance) =>
    <String, dynamic>{
      'error': instance.error,
    };

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
      code: (json['code'] as num?)?.toInt() ?? 0,
      message: json['message'] as String? ?? '',
      status: json['status'] as String? ?? '',
      details: (json['details'] as List<dynamic>?)
              ?.map((e) => Detail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'details': instance.details,
    };

Detail _$DetailFromJson(Map<String, dynamic> json) => Detail(
      type: json['@type'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
      domain: json['domain'] as String? ?? '',
      metadata: json['metadata'] == null
          ? const Metadata()
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      locale: json['locale'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      '@type': instance.type,
      'reason': instance.reason,
      'domain': instance.domain,
      'metadata': instance.metadata,
      'locale': instance.locale,
      'message': instance.message,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      service: json['service'] as String? ?? '',
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'service': instance.service,
    };
