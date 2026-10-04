part of 'sign_in_notifier.dart';

sealed class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccessful extends SignInState {
  final SignInResponseModel signInResponse;

  SignInSuccessful({required this.signInResponse});
}

class SignInFailure extends SignInState {
  final Failure failure;

  SignInFailure(this.failure);
}
