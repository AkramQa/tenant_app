import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tenant_app/core/presentation/providers/auth/auth_notifier.dart';
import 'package:tenant_app/core/presentation/widgets/collapsible_fab_mixin.dart';
import 'package:tenant_app/core/presentation/widgets/loader.dart';
import 'package:tenant_app/core/presentation/widgets/responsive_center_widget.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/presentation/widgets/title_view_all.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/home/presentation/widgets/home_header_widget.dart';
import 'package:tenant_app/features/home/presentation/widgets/quick_services_widget.dart';
import 'package:tenant_app/features/home/presentation/widgets/recent_service_requests_widget.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/service_requests_list/service_requests_list_notifier.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/create_service_request_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  static const String routePath = '/home';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with CollapsibleFabMixin {
  @override
  Widget build(BuildContext context) {
    final tenant = ref.watch(authProvider.select((state) => state is Authenticated ? state.user : null));
    if (tenant == null) return const Scaffold(body: Loader());

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'home_fab',
        onPressed: () => context.push(CreateServiceRequestScreen.routePath),
        isExtended: isFabExtended,
        // Only the collapsed (icon-only) FAB needs a tooltip; the extended one shows the label.
        tooltip: isFabExtended ? null : context.l10n.new_request,
        icon: const Icon(Icons.add_rounded),
        label: Text(context.l10n.new_request),
      ),
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator.adaptive(
          onRefresh: () => ref.read(serviceRequestsListProvider.notifier).fetchServiceRequests(),
          child: NotificationListener<ScrollNotification>(
            onNotification: onScrollNotification,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              // Bottom padding keeps content clear of the FAB.
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 96.h),
              child: ResponsiveCenterWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HomeHeaderWidget(tenant: tenant),
                    const SpacerH24(),
                    TitleViewAll(title: context.l10n.quick_services),
                    const SpacerH12(),
                    QuickServicesWidget(
                      onServiceSelected: (serviceType) =>
                          context.push(CreateServiceRequestScreen.routePath, extra: serviceType),
                    ),
                    const SpacerH24(),
                    TitleViewAll(
                      title: context.l10n.recent_requests,
                      onViewAllPressed: () => StatefulNavigationShell.of(context).goBranch(1),
                    ),
                    const SpacerH8(),
                    const RecentServiceRequestsWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
