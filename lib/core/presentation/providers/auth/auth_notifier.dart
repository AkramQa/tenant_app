import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/features/auth/data/models/tenant_info_model.dart';
import 'package:tenant_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tenant_app/features/service_requests/domain/repositories/service_requests_repository.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/service_requests_list/service_requests_list_notifier.dart';

part 'auth_state.dart';

/// App-wide session state.
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

  /// Returns the failure and keeps the session when the stored credentials
  /// could not be cleared, so the tenant is never half signed out.
  Future<Failure?> logout() async {
    final result = await _repository.clearCache();
    return result.fold((failure) => failure, (_) {
      _clearUserData();
      state = Unauthenticated();
      return null;
    });
  }

  /// Drops the previous tenant's cached requests so the next account never sees them.
  void _clearUserData() {
    unawaited(ref.read(serviceRequestsRepositoryProvider).clearCachedServiceRequests());
    ref.invalidate(serviceRequestsListProvider);
  }

  bool get isUserAuthenticated => state is Authenticated;

  TenantInfoModel? get currentUser => switch (state) {
        Authenticated(:final user) => user,
        _ => null,
      };
}
