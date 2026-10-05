import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:tenant_app/core/data/models/base_response.dart';
import 'package:tenant_app/core/data/utils/exception.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/domain/repositories/base_repository.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/core/domain/utils/network/network_info.dart';

/// Every repository extends this and only describes the happy path inside
/// [request] / [localRequest]. All try/catch, logging and exception →
/// [Failure] mapping lives here, in one place.
class BaseRepositoryImpl implements BaseRepository {
  final Logger _logger;

  // Kept for constructor-signature parity with the network layer; the mock
  // backend (MockBackendInterceptor) performs the connectivity check itself.
  BaseRepositoryImpl(NetworkInfo networkInfo, this._logger);

  @override
  Future<Either<Failure, T>> request<T>(FutureEitherFailureOrData<T> body) async {
    try {
      return await body();
    } catch (e, stackTrace) {
      if (e is DioException) {
        _logger.w(e.message ?? e.toString());
        return left(_mapDioException(e));
      }
      if (e is EmptyResponseException) {
        _logger.w(e.toString());
        return left(const ServerFailure(errorCode: ServerErrorCode.serverError));
      }
      if (e is CacheException) {
        _logger.w(e.toString());
        return left(CacheFailure());
      }
      if (e is TimeoutException) {
        _logger.w(e.toString());
        return left(const ServerFailure(errorCode: ServerErrorCode.noInternetConnection));
      }
      _logger.e(e.toString(), error: e, stackTrace: stackTrace);
      return left(LogicFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, T>> localRequest<T>(FutureEitherFailureOrData<T> body) async {
    try {
      return await body();
    } catch (e, stackTrace) {
      _logger.e(e.toString(), error: e, stackTrace: stackTrace);
      return left(CacheFailure());
    }
  }

  ServerFailure _mapDioException(DioException e) {
    final Response<dynamic>? response = e.response;
    if (response == null) {
      final bool isConnectivity = e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout;
      return ServerFailure(
        errorCode: isConnectivity ? ServerErrorCode.noInternetConnection : ServerErrorCode.serverError,
      );
    }
    String message = '';
    try {
      message = BaseResponse<dynamic>.fromJson(response.data as Map<String, dynamic>, (_) => null).message ?? '';
    } catch (_) {
      // Non-envelope error body: fall back to the localized default message.
    }
    return ServerFailure(errorCode: _getErrorCode(response.statusCode ?? 500), message: message);
  }

  ServerErrorCode _getErrorCode(int statusCode) => switch (statusCode) {
        401 => ServerErrorCode.unauthenticated,
        403 => ServerErrorCode.forbidden,
        404 => ServerErrorCode.notFound,
        400 => ServerErrorCode.invalidData,
        422 => ServerErrorCode.wrongInput,
        406 => ServerErrorCode.customError,
        _ => ServerErrorCode.serverError,
      };
}
