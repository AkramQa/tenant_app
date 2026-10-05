import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tenant_app/features/auth/presentation/screens/sign_in_screen.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(overrides: [authRepositoryProvider.overrideWithValue(MockAuthRepository())]);
  });

  tearDown(() => container.dispose());

  testWidgets('shows required-field errors when submitting an empty form', (tester) async {
    await tester.pumpApp(const SignInScreen(), container: container);

    final signInButton = find.widgetWithText(ElevatedButton, 'Sign in');
    await tester.ensureVisible(signInButton);
    await tester.tap(signInButton);
    await tester.pump();

    expect(find.text('This field is required'), findsNWidgets(2));
  });

  testWidgets('fills the demo credentials when tapping "Use demo account"', (tester) async {
    await tester.pumpApp(const SignInScreen(), container: container);

    final useDemo = find.text('Use demo account');
    await tester.ensureVisible(useDemo);
    await tester.tap(useDemo);
    await tester.pump();

    expect(find.widgetWithText(TextField, kDemoEmail), findsOneWidget);
    expect(find.text('This field is required'), findsNothing);
  });
}
