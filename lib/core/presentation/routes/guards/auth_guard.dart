import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/core/presentation/providers/auth/auth_notifier.dart';
import 'package:tenant_app/core/presentation/routes/app_router.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this._ref);

  final Ref _ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_ref.read(authProvider.notifier).isUserAuthenticated) {
      resolver.next(true);
    } else {
      resolver.redirect(const SignInRoute());
    }
  }
}
