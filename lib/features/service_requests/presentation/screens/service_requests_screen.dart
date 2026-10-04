import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tenant_app/core/presentation/widgets/base_empty_widget.dart';
import 'package:tenant_app/core/presentation/widgets/base_icon_container_widget.dart';
import 'package:tenant_app/core/presentation/widgets/error_view.dart';
import 'package:tenant_app/core/presentation/widgets/responsive_center_widget.dart';
import 'package:tenant_app/core/presentation/widgets/screen_utils.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/service_requests/data/models/request_status.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/service_requests_list/service_requests_list_notifier.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/create_service_request_screen.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/service_request_details_screen.dart';
import 'package:tenant_app/features/service_requests/presentation/utils/service_request_ui_utils.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/cached_data_banner_widget.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/request_status_filter_widget.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/service_request_card_widget.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/service_requests_shimmer_list_widget.dart';

class ServiceRequestsScreen extends ConsumerStatefulWidget {
  const ServiceRequestsScreen({super.key});

  static const String routePath = '/service-requests';

  @override
  ConsumerState<ServiceRequestsScreen> createState() => _ServiceRequestsScreenState();
}

class _ServiceRequestsScreenState extends ConsumerState<ServiceRequestsScreen> with ScreenUtils {
  RequestStatus? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    ref.listen<ServiceRequestsListState>(serviceRequestsListProvider, (previous, state) {
      if (state is ServiceRequestsListSuccessful && state.refreshFailure != null && previous != state) {
        handleError(failure: state.refreshFailure);
      }
    });

    final state = ref.watch(serviceRequestsListProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.service_requests)),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'service_requests_fab',
        onPressed: () => context.push(CreateServiceRequestScreen.routePath),
        icon: const Icon(Icons.add_rounded),
        label: Text(context.l10n.new_request),
      ),
      body: switch (state) {
        InitialServiceRequestsList() || ServiceRequestsListLoading() => Padding(
            padding: EdgeInsets.all(16.r),
            child: const ResponsiveCenterWidget(child: ServiceRequestsShimmerListWidget()),
          ),
        ServiceRequestsListFailure(:final failure) => ErrorView(
            failure: failure,
            onRetry: () => fetchServiceRequests(),
          ),
        final ServiceRequestsListSuccessful successfulState => _buildList(successfulState),
      },
    );
  }

  Widget _buildList(ServiceRequestsListSuccessful state) {
    final List<ServiceRequestModel> serviceRequests = _selectedStatus == null
        ? state.serviceRequests
        : state.serviceRequests.where((request) => request.status == _selectedStatus).toList();

    return Column(
      children: [
        RequestStatusFilterWidget(
          selectedStatus: _selectedStatus,
          onChanged: (status) => setState(() => _selectedStatus = status),
        ),
        const SpacerH8(),
        Expanded(
          child: RefreshIndicator.adaptive(
            onRefresh: fetchServiceRequests,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                if (state.isFromCache)
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    sliver: const SliverToBoxAdapter(
                      child: ResponsiveCenterWidget(child: CachedDataBannerWidget()),
                    ),
                  ),
                if (serviceRequests.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: EdgeInsets.all(24.r),
                      child: _buildEmptyState(state.serviceRequests.isEmpty),
                    ),
                  )
                else
                  SliverPadding(
                    // Bottom padding keeps the last card clear of the FAB.
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 96.h),
                    sliver: SliverList.separated(
                      itemCount: serviceRequests.length,
                      separatorBuilder: (_, __) => const SpacerH12(),
                      itemBuilder: (context, index) {
                        final serviceRequest = serviceRequests[index];
                        return ResponsiveCenterWidget(
                          child: ServiceRequestCardWidget(
                            serviceRequest: serviceRequest,
                            onTap: () => context.push(ServiceRequestDetailsScreen.location(serviceRequest.id)),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(bool hasNoRequestsAtAll) {
    if (hasNoRequestsAtAll) {
      return BaseEmptyWidget(
        emptyIcon: BaseIconContainerWidget(icon: Icons.inbox_outlined, color: context.colors.primary, size: 72.r),
        title: context.l10n.no_service_requests_yet,
        description: context.l10n.no_service_requests_yet_description,
      );
    }
    return BaseEmptyWidget(
      emptyIcon: BaseIconContainerWidget(icon: Icons.filter_alt_off_outlined, color: context.colors.primary, size: 72.r),
      title: context.l10n.no_requests_with_status(_selectedStatus!.translated(context)),
      description: context.l10n.try_a_different_filter,
    );
  }

  Future<void> fetchServiceRequests() => ref.read(serviceRequestsListProvider.notifier).fetchServiceRequests();
}
