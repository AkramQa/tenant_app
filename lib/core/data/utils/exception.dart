/// Thrown by local data sources (Hive, shared preferences, file system).
class CacheException implements Exception {
  final String? message;

  const CacheException([this.message]);

  @override
  String toString() => 'CacheException($message)';
}
