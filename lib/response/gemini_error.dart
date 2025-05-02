import 'package:json_annotation/json_annotation.dart';

part 'gemini_error.g.dart';

@JsonSerializable()
class GeminiError {
  @JsonKey(name: "error")
  final Error error;

  GeminiError({this.error = const Error()});

  GeminiError copyWith({Error? error}) => GeminiError(error: error ?? this.error);

  factory GeminiError.fromJson(Map<String, dynamic> json) => _$GeminiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$GeminiErrorToJson(this);
}

@JsonSerializable()
class Error {
  @JsonKey(name: "code")
  final int code;
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "details")
  final List<Detail> details;

  const Error({this.code = 0, this.message = '', this.status = '', this.details = const []});

  Error copyWith({int? code, String? message, String? status, List<Detail>? details}) => Error(
    code: code ?? this.code,
    message: message ?? this.message,
    status: status ?? this.status,
    details: details ?? this.details,
  );

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}

@JsonSerializable()
class Detail {
  @JsonKey(name: "@type")
  final String type;
  @JsonKey(name: "reason")
  final String reason;
  @JsonKey(name: "domain")
  final String domain;
  @JsonKey(name: "metadata")
  final Metadata metadata;
  @JsonKey(name: "locale")
  final String locale;
  @JsonKey(name: "message")
  final String message;

  Detail({
    this.type = '',
    this.reason = '',
    this.domain = '',
    this.metadata = const Metadata(),
    this.locale = '',
    this.message = '',
  });

  Detail copyWith({
    String? type,
    String? reason,
    String? domain,
    Metadata? metadata,
    String? locale,
    String? message,
  }) => Detail(
    type: type ?? this.type,
    reason: reason ?? this.reason,
    domain: domain ?? this.domain,
    metadata: metadata ?? this.metadata,
    locale: locale ?? this.locale,
    message: message ?? this.message,
  );

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);

  Map<String, dynamic> toJson() => _$DetailToJson(this);
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "service")
  final String service;

  const Metadata({this.service = ''});

  Metadata copyWith({String? service}) => Metadata(service: service ?? this.service);

  factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
