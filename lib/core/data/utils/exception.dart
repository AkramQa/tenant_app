import 'package:tenant_app/core/domain/utils/constants.dart';

/// Thrown by remote data sources (the mock API client plays the role Dio's
/// `DioException` plays in a real backend integration). Mapped to
/// [ServerFailure] centrally in `BaseRepositoryImpl.request`.
class ServerException implements Exception {
  final ServerErrorCode errorCode;
  final String message;

  const ServerException({required this.errorCode, this.message = ''});

  @override
  String toString() => 'ServerException($errorCode, $message)';
}

/// Thrown by local data sources (Hive, shared preferences, file system).
class CacheException implements Exception {
  final String? message;

  const CacheException([this.message]);

  @override
  String toString() => 'CacheException($message)';
}
