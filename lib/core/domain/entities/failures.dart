import 'package:equatable/equatable.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';

abstract class Failure {}

class ServerFailure extends Equatable implements Failure {
  final ServerErrorCode errorCode;
  final String message;

  const ServerFailure({required this.errorCode, this.message = ''});

  @override
  List<Object> get props => [errorCode, message];
}

class CacheFailure implements Failure {}

class LogicFailure implements Failure {
  final String message;

  LogicFailure(this.message);
}
