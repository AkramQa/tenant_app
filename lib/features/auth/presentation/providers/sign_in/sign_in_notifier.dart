import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/features/auth/data/models/sign_in_response_model.dart';
import 'package:tenant_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tenant_app/features/auth/presentation/ui_models/sign_in_input.dart';

part 'sign_in_state.dart';

/// Screen-scoped: disposed when the sign-in screen closes.
final signInProvider = NotifierProvider.autoDispose<SignInNotifier, SignInState>(SignInNotifier.new);

class SignInNotifier extends Notifier<SignInState> {
  @override
  SignInState build() => SignInInitial();

  Future<void> signIn(SignInInput input) async {
    if (state is SignInLoading) return;
    state = SignInLoading();

    final result = await ref.read(authRepositoryProvider).signIn(
          identifier: input.identifier.trim(),
          password: input.password,
        );
    if (!ref.mounted) return;

    state = result.fold<SignInState>(
      (failure) => SignInFailure(failure),
      (signInResponse) => SignInSuccessful(signInResponse: signInResponse),
    );
  }
}
