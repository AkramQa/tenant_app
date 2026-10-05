/// A 2xx response arrived without the `data` the endpoint promises.
class EmptyResponseException implements Exception {
  const EmptyResponseException();

  @override
  String toString() => 'EmptyResponseException';
}

/// Thrown by local data sources (Hive, shared preferences, file system).
class CacheException implements Exception {
  final String? message;

  const CacheException([this.message]);

  @override
  String toString() => 'CacheException($message)';
}
