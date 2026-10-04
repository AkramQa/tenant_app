import 'package:dartz/dartz.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';

typedef FutureEitherFailureOrData<T> = Future<Either<Failure, T>> Function();

abstract class BaseRepository {
  Future<Either<Failure, T>> request<T>(FutureEitherFailureOrData<T> body);

  Future<Either<Failure, T>> localRequest<T>(FutureEitherFailureOrData<T> body);
}
