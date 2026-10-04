import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/features/auth/data/models/tenant_info_model.dart';
import 'package:tenant_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tenant_app/features/auth/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

/// App-wide session state — the counterpart of Ulearna's `@Singleton() AuthBloc`.
final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {
  AuthRepository get _repository => ref.read(authRepositoryProvider);

  @override
  AuthState build() => AuthInitial();

  Future<void> checkAuthenticationStatus() async {
    state = AuthLoading();
    final result = await _repository.getSignedInUserInfo();
    state = result.fold<AuthState>(
      (failure) => AuthFailure(failure),
      (tenant) => tenant == null ? Unauthenticated() : Authenticated(user: tenant),
    );
  }

  void setAuthenticated(TenantInfoModel tenant) => state = Authenticated(user: tenant);

  Future<void> logout() async {
    final result = await _repository.clearCache();
    state = result.fold<AuthState>((failure) => AuthFailure(failure), (_) => Unauthenticated());
  }

  bool get isUserAuthenticated => state is Authenticated;

  TenantInfoModel? get currentUser => switch (state) {
        Authenticated(:final user) => user,
        _ => null,
      };
}
