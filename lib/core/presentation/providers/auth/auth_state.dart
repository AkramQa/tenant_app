part of 'auth_notifier.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final TenantInfoModel user;

  Authenticated({required this.user});
}

class Unauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final Failure failure;

  AuthFailure(this.failure);
}
