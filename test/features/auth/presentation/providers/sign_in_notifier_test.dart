import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/features/auth/data/models/sign_in_response_model.dart';
import 'package:tenant_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tenant_app/features/auth/presentation/providers/sign_in/sign_in_notifier.dart';
import 'package:tenant_app/features/auth/presentation/ui_models/sign_in_input.dart';

import '../../../../helpers/fakers.dart';
import '../../../../helpers/mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late ProviderContainer container;
  late List<SignInState> states;

  setUp(() {
    authRepository = MockAuthRepository();
    container = ProviderContainer(overrides: [authRepositoryProvider.overrideWithValue(authRepository)]);
    states = [];
    // Keeps the autoDispose provider alive and records every emission.
    container.listen<SignInState>(signInProvider, (_, state) => states.add(state));
  });

  tearDown(() => container.dispose());

  void arrangeSignIn(Either<Failure, SignInResponseModel> result) {
    when(() => authRepository.signIn(identifier: any(named: 'identifier'), password: any(named: 'password')))
        .thenAnswer((_) async => result);
  }

  group('SignInNotifier — signIn', () {
    test('emits [Loading, Successful] when credentials are valid', () async {
      arrangeSignIn(Right(fakeSignInResponseModel()));

      await container
          .read(signInProvider.notifier)
          .signIn(SignInInput(identifier: 'tenant@demo.com', password: 'Tenant@123'));

      expect(states, [isA<SignInLoading>(), isA<SignInSuccessful>()]);
    });

    test('emits [Loading, Failure] when credentials are wrong', () async {
      arrangeSignIn(const Left(ServerFailure(errorCode: ServerErrorCode.wrongInput)));

      await container.read(signInProvider.notifier).signIn(SignInInput(identifier: 'x@y.com', password: 'wrong-pass'));

      expect(states, [isA<SignInLoading>(), isA<SignInFailure>()]);
      final failure = (states.last as SignInFailure).failure;
      expect(failure, const ServerFailure(errorCode: ServerErrorCode.wrongInput));
    });

    test('trims the identifier before calling the repository', () async {
      arrangeSignIn(Right(fakeSignInResponseModel()));

      await container
          .read(signInProvider.notifier)
          .signIn(SignInInput(identifier: '  tenant@demo.com  ', password: 'Tenant@123'));

      verify(() => authRepository.signIn(identifier: 'tenant@demo.com', password: 'Tenant@123')).called(1);
    });
  });
}
