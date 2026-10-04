import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
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
  // API client performs the connectivity check itself.
  BaseRepositoryImpl(NetworkInfo networkInfo, this._logger);

  @override
  Future<Either<Failure, T>> request<T>(FutureEitherFailureOrData<T> body) async {
    try {
      return await body();
    } catch (e, stackTrace) {
      if (e is ServerException) {
        _logger.w(e.toString());
        return left(ServerFailure(errorCode: e.errorCode, message: e.message));
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
}
