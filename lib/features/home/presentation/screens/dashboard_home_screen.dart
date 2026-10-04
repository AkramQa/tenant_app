import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/core/presentation/routes/app_router.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/service_requests_list/service_requests_list_notifier.dart';

/// Tab shell: bottom navigation on phones, navigation rail on tablets /
/// landscape.
@RoutePage()
class DashboardHomeScreen extends ConsumerStatefulWidget {
  const DashboardHomeScreen({super.key});

  static const String routePath = '/dashboard-home';

  @override
  ConsumerState<DashboardHomeScreen> createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends ConsumerState<DashboardHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Eagerly load the shared requests list (like a `lazy: false` provider).
    Future.microtask(() => ref.read(serviceRequestsListProvider.notifier).fetchServiceRequests());
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        ServiceRequestsRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final destinations = _destinations(context);

        if (context.isWideLayout) {
          return Scaffold(
            body: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  NavigationRail(
                    selectedIndex: tabsRouter.activeIndex,
                    onDestinationSelected: tabsRouter.setActiveIndex,
                    labelType: NavigationRailLabelType.all,
                    destinations: [
                      for (final destination in destinations)
                        NavigationRailDestination(
                          icon: Icon(destination.icon),
                          selectedIcon: Icon(destination.selectedIcon),
                          label: Text(destination.label),
                        ),
                    ],
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(child: child),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            destinations: [
              for (final destination in destinations)
                NavigationDestination(
                  icon: Icon(destination.icon),
                  selectedIcon: Icon(destination.selectedIcon),
                  label: destination.label,
                ),
            ],
          ),
        );
      },
    );
  }

  List<({IconData icon, IconData selectedIcon, String label})> _destinations(BuildContext context) => [
        (icon: Icons.home_outlined, selectedIcon: Icons.home_rounded, label: context.l10n.home),
        (icon: Icons.assignment_outlined, selectedIcon: Icons.assignment_rounded, label: context.l10n.requests),
        (icon: Icons.person_outline_rounded, selectedIcon: Icons.person_rounded, label: context.l10n.profile),
      ];
}
