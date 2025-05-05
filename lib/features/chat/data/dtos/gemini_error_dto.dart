import 'package:flutter_hung_chatbot/features/chat/domain/entities/gemini/gemini_error.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gemini_error_dto.g.dart';

@JsonSerializable()
class GeminiErrorDto {
  @JsonKey(name: "error")
  final ErrorDto error;

  GeminiErrorDto({this.error = const ErrorDto()});

  GeminiErrorDto copyWith({ErrorDto? error}) => GeminiErrorDto(error: error ?? this.error);

  factory GeminiErrorDto.fromJson(Map<String, dynamic> json) => _$GeminiErrorDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GeminiErrorDtoToJson(this);

  GeminiError toEntity() {
    return GeminiError(error: error.toEntity());
  }

  static GeminiErrorDto fromEntity(GeminiError error) {
    return GeminiErrorDto(error: ErrorDto.fromEntity(error.error));
  }
}

@JsonSerializable()
class ErrorDto {
  @JsonKey(name: "code")
  final int code;
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "details")
  final List<DetailDto> details;

  const ErrorDto({this.code = 0, this.message = '', this.status = '', this.details = const []});

  ErrorDto copyWith({int? code, String? message, String? status, List<DetailDto>? details}) => ErrorDto(
    code: code ?? this.code,
    message: message ?? this.message,
    status: status ?? this.status,
    details: details ?? this.details,
  );

  factory ErrorDto.fromJson(Map<String, dynamic> json) => _$ErrorDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDtoToJson(this);

  ErrorEntity toEntity() {
    return ErrorEntity(
      code: code,
      message: message,
      status: status,
      details: details.map((detail) => detail.toEntity()).toList(),
    );
  }

  static ErrorDto fromEntity(ErrorEntity error) {
    return ErrorDto(
      code: error.code,
      message: error.message,
      status: error.status,
      details: error.details.map((detail) => DetailDto.fromEntity(detail)).toList(),
    );
  }
}

@JsonSerializable()
class DetailDto {
  @JsonKey(name: "@type")
  final String type;
  @JsonKey(name: "reason")
  final String reason;
  @JsonKey(name: "domain")
  final String domain;
  @JsonKey(name: "metadata")
  final MetadataDto metadata;
  @JsonKey(name: "locale")
  final String locale;
  @JsonKey(name: "message")
  final String message;

  DetailDto({
    this.type = '',
    this.reason = '',
    this.domain = '',
    this.metadata = const MetadataDto(),
    this.locale = '',
    this.message = '',
  });

  DetailDto copyWith({
    String? type,
    String? reason,
    String? domain,
    MetadataDto? metadata,
    String? locale,
    String? message,
  }) => DetailDto(
    type: type ?? this.type,
    reason: reason ?? this.reason,
    domain: domain ?? this.domain,
    metadata: metadata ?? this.metadata,
    locale: locale ?? this.locale,
    message: message ?? this.message,
  );

  factory DetailDto.fromJson(Map<String, dynamic> json) => _$DetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DetailDtoToJson(this);

  Detail toEntity() {
    return Detail(
      type: type,
      reason: reason,
      domain: domain,
      metadata: metadata.toEntity(),
      locale: locale,
      message: message,
    );
  }

  static DetailDto fromEntity(Detail detail) {
    return DetailDto(
      type: detail.type,
      reason: detail.reason,
      domain: detail.domain,
      metadata: MetadataDto.fromEntity(detail.metadata),
      locale: detail.locale,
      message: detail.message,
    );
  }
}

@JsonSerializable()
class MetadataDto {
  @JsonKey(name: "service")
  final String service;

  const MetadataDto({this.service = ''});

  MetadataDto copyWith({String? service}) => MetadataDto(service: service ?? this.service);

  factory MetadataDto.fromJson(Map<String, dynamic> json) => _$MetadataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataDtoToJson(this);

  Metadata toEntity() {
    return Metadata(service: service);
  }

  static MetadataDto fromEntity(Metadata metadata) {
    return MetadataDto(service: metadata.service);
  }
}
