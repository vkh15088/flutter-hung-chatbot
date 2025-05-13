class ApiConstants {
  const ApiConstants._();

  static const String geminiBaseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/';
  static const String generateContentEndpoint = ':generateContent';
  static const String streamGenerateContentEndpoint = ':streamGenerateContent';
  static const String sseParameter = 'sse';
  static const String apiKeyParam = 'key';
  static const String altParam = 'alt';
}
