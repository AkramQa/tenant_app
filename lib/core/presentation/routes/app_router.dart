import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/core/presentation/routes/guards/auth_guard.dart';
import 'package:tenant_app/features/auth/presentation/screens/launcher_screen.dart';
import 'package:tenant_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:tenant_app/features/home/presentation/screens/dashboard_home_screen.dart';
import 'package:tenant_app/features/home/presentation/screens/home_screen.dart';
import 'package:tenant_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/create_service_request_screen.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/service_request_details_screen.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/service_requests_screen.dart';

part 'app_router.gr.dart';

/// `@LazySingleton()`
final appRouterProvider = Provider<AppRouter>((ref) => AppRouter(ref));

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter(this._ref);

  final Ref _ref;

  /// Platform-aware transitions: Cupertino (with swipe-back) on iOS,
  /// Material on Android.
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LauncherRoute.page,
          path: LauncherScreen.routePath,
          initial: true,
        ),
        createCustomRoute(
          page: SignInRoute.page,
          path: SignInScreen.routePath,
        ),
        AutoRoute(
          page: DashboardHomeRoute.page,
          path: DashboardHomeScreen.routePath,
          guards: [AuthGuard(_ref)],
          children: [
            AutoRoute(
              page: HomeRoute.page,
              path: HomeScreen.routePath,
              initial: true,
            ),
            AutoRoute(
              page: ServiceRequestsRoute.page,
              path: ServiceRequestsScreen.routePath,
            ),
            AutoRoute(
              page: ProfileRoute.page,
              path: ProfileScreen.routePath,
            ),
          ],
        ),
        // Must be declared before the details route so `/new` isn't parsed as an id.
        createSlideUpRoute(
          page: CreateServiceRequestRoute.page,
          path: CreateServiceRequestScreen.routePath,
          guards: [AuthGuard(_ref)],
        ),
        createCustomRoute(
          page: ServiceRequestDetailsRoute.page,
          path: ServiceRequestDetailsScreen.routePath,
          guards: [AuthGuard(_ref)],
        ),
      ];

  AutoRoute createCustomRoute({
    required PageInfo page,
    String? path,
    List<AutoRouteGuard> guards = const [],
  }) =>
      AutoRoute(page: page, path: path, guards: guards);

  CustomRoute createSlideUpRoute({
    required PageInfo page,
    String? path,
    List<AutoRouteGuard> guards = const [],
  }) =>
      CustomRoute(
        page: page,
        path: path,
        guards: guards,
        fullscreenDialog: true,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero)
              .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
          final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
          );
          return FadeTransition(opacity: fade, child: SlideTransition(position: slide, child: child));
        },
        durationInMilliseconds: 220,
        reverseDurationInMilliseconds: 180,
      );
}
