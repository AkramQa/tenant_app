import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/service_requests_list/service_requests_list_notifier.dart';

/// Tab shell: bottom navigation on phones, navigation rail on tablets /
/// landscape. Each tab keeps its own state (`StatefulShellRoute.indexedStack`).
class DashboardHomeScreen extends ConsumerStatefulWidget {
  const DashboardHomeScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

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

  void _onDestinationSelected(int index) {
    // Tapping the active tab again returns it to its first page.
    widget.navigationShell.goBranch(index, initialLocation: index == widget.navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final destinations = _destinations(context);
    final int currentIndex = widget.navigationShell.currentIndex;

    if (context.isWideLayout) {
      return Scaffold(
        body: SafeArea(
          bottom: false,
          child: Row(
            children: [
              NavigationRail(
                selectedIndex: currentIndex,
                onDestinationSelected: _onDestinationSelected,
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
              Expanded(child: widget.navigationShell),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: _onDestinationSelected,
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
  }

  List<({IconData icon, IconData selectedIcon, String label})> _destinations(BuildContext context) => [
        (icon: Icons.home_outlined, selectedIcon: Icons.home_rounded, label: context.l10n.home),
        (icon: Icons.assignment_outlined, selectedIcon: Icons.assignment_rounded, label: context.l10n.requests),
        (icon: Icons.person_outline_rounded, selectedIcon: Icons.person_rounded, label: context.l10n.profile),
      ];
}
