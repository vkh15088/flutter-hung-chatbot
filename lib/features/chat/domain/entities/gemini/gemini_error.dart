class GeminiError {
  final ErrorEntity error;

  GeminiError({required this.error});
}

class ErrorEntity {
  final int code;
  final String message;
  final String status;
  final List<Detail> details;

  const ErrorEntity({required this.code, required this.message, required this.status, required this.details});
}

class Detail {
  final String type;
  final String reason;
  final String domain;
  final Metadata metadata;
  final String locale;
  final String message;

  const Detail({
    required this.type,
    required this.reason,
    required this.domain,
    required this.metadata,
    required this.locale,
    required this.message,
  });
}

class Metadata {
  final String service;

  const Metadata({required this.service});
}
