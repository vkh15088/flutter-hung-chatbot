class ServerException implements Exception {}

class CacheException implements Exception {}

class NetworkException implements Exception {}

class UnexpectedDataException implements Exception {
  final String message;
  
  UnexpectedDataException(this.message);
}
