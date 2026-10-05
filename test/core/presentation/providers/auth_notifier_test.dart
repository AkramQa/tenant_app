import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/presentation/providers/auth/auth_notifier.dart';
import 'package:tenant_app/features/auth/domain/repositories/auth_repository.dart';

import '../../../helpers/fakers.dart';
import '../../../helpers/mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late ProviderContainer container;

  setUp(() {
    authRepository = MockAuthRepository();
    container = ProviderContainer(overrides: [authRepositoryProvider.overrideWithValue(authRepository)]);
  });

  tearDown(() => container.dispose());

  AuthNotifier notifier() => container.read(authProvider.notifier);

  group('AuthNotifier — checkAuthenticationStatus', () {
    test('restores a persisted session', () async {
      final tenant = fakeTenantInfoModel();
      when(() => authRepository.getSignedInUserInfo()).thenAnswer((_) async => Right(tenant));

      await notifier().checkAuthenticationStatus();

      expect(container.read(authProvider), isA<Authenticated>());
      expect(notifier().currentUser, tenant);
    });

    test('is Unauthenticated when nothing is stored', () async {
      when(() => authRepository.getSignedInUserInfo()).thenAnswer((_) async => const Right(null));

      await notifier().checkAuthenticationStatus();

      expect(container.read(authProvider), isA<Unauthenticated>());
    });
  });

  group('AuthNotifier — logout', () {
    setUp(() => notifier().setAuthenticated(fakeTenantInfoModel()));

    test('signs out when the stored session is cleared', () async {
      when(() => authRepository.clearCache()).thenAnswer((_) async => const Right(unit));

      final failure = await notifier().logout();

      expect(failure, isNull);
      expect(container.read(authProvider), isA<Unauthenticated>());
    });

    test('keeps the session and returns the failure when clearing fails', () async {
      final cacheFailure = CacheFailure();
      when(() => authRepository.clearCache()).thenAnswer((_) async => Left(cacheFailure));

      final failure = await notifier().logout();

      expect(failure, cacheFailure);
      expect(container.read(authProvider), isA<Authenticated>());
    });
  });
}
