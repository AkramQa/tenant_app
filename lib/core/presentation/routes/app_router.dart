import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tenant_app/core/presentation/providers/auth/auth_notifier.dart';
import 'package:tenant_app/features/auth/presentation/screens/launcher_screen.dart';
import 'package:tenant_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:tenant_app/features/home/presentation/screens/dashboard_home_screen.dart';
import 'package:tenant_app/features/home/presentation/screens/home_screen.dart';
import 'package:tenant_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/create_service_request_screen.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/service_request_details_screen.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/service_request_submitted_screen.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/service_requests_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Routes that don't require a session.
const Set<String> _publicRoutes = {LauncherScreen.routePath, SignInScreen.routePath};

/// `@LazySingleton() AppRouter`. Each screen owns its `routePath` constant.
///
/// The `redirect` plays the role of an `AuthGuard`: any protected route
/// opened without a session lands on sign-in.
final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: LauncherScreen.routePath,
    redirect: (context, state) {
      final bool isAuthenticated = ref.read(authProvider.notifier).isUserAuthenticated;
      if (!isAuthenticated && !_publicRoutes.contains(state.matchedLocation)) {
        return SignInScreen.routePath;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: LauncherScreen.routePath,
        builder: (context, state) => const LauncherScreen(),
      ),
      GoRoute(
        path: SignInScreen.routePath,
        builder: (context, state) => const SignInScreen(),
      ),
      // Dashboard tabs — each branch keeps its own navigation stack & state.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => DashboardHomeScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: HomeScreen.routePath, builder: (context, state) => const HomeScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ServiceRequestsScreen.routePath,
                builder: (context, state) => const ServiceRequestsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: ProfileScreen.routePath, builder: (context, state) => const ProfileScreen()),
            ],
          ),
        ],
      ),
      // Full-screen pages above the tab bar.
      GoRoute(
        path: CreateServiceRequestScreen.routePath,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          fullscreenDialog: true,
          child: CreateServiceRequestScreen(initialServiceType: state.extra as ServiceType?),
        ),
      ),
      GoRoute(
        path: ServiceRequestSubmittedScreen.routePath,
        builder: (context, state) =>
            ServiceRequestSubmittedScreen(serviceRequest: state.extra! as ServiceRequestModel),
      ),
      GoRoute(
        path: ServiceRequestDetailsScreen.routePath,
        builder: (context, state) => ServiceRequestDetailsScreen(requestId: state.pathParameters['id']!),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
