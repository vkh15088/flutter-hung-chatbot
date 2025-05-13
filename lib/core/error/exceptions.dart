class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class CacheException implements Exception {}

class NetworkException implements Exception {}

class UnexpectedDataException implements Exception {
  final String message;

  UnexpectedDataException(this.message);
}
