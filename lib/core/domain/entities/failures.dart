import 'package:tenant_app/core/domain/utils/constants.dart';

sealed class Failure {
  const Failure();
}

class ServerFailure extends Failure {
  final ServerErrorCode errorCode;
  final String message;

  const ServerFailure({required this.errorCode, this.message = ''});

  @override
  bool operator ==(Object other) =>
      other is ServerFailure && other.errorCode == errorCode && other.message == message;

  @override
  int get hashCode => Object.hash(errorCode, message);
}

class CacheFailure extends Failure {
  const CacheFailure();
}

class LogicFailure extends Failure {
  final String message;

  const LogicFailure(this.message);
}
