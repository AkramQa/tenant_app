import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/presentation/widgets/base_card_widget.dart';
import 'package:tenant_app/core/presentation/widgets/base_empty_widget.dart';
import 'package:tenant_app/core/presentation/widgets/base_icon_container_widget.dart';
import 'package:tenant_app/core/presentation/widgets/buttons/base_elevated_button.dart';
import 'package:tenant_app/core/presentation/widgets/error_view.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/service_requests_list/service_requests_list_notifier.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/create_service_request_screen.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/service_request_details_screen.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/cached_data_banner_widget.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/service_request_card_widget.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/service_requests_shimmer_list_widget.dart';

class RecentServiceRequestsWidget extends ConsumerWidget {
  const RecentServiceRequestsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(serviceRequestsListProvider);

    return switch (state) {
      InitialServiceRequestsList() || ServiceRequestsListLoading() =>
        const ServiceRequestsShimmerListWidget(itemCount: kRecentServiceRequestsLimit),
      ServiceRequestsListFailure(:final failure) => BaseCardWidget(
          child: ErrorView(
            failure: failure,
            onRetry: () => ref.read(serviceRequestsListProvider.notifier).fetchServiceRequests(),
          ),
        ),
      ServiceRequestsListSuccessful(serviceRequests: final serviceRequests) when serviceRequests.isEmpty =>
        BaseCardWidget(
          padding: EdgeInsets.all(24.r),
          child: BaseEmptyWidget(
            emptyIcon: BaseIconContainerWidget(icon: Icons.inbox_outlined, color: context.colors.primary, size: 56.r),
            title: context.l10n.no_service_requests_yet,
            description: context.l10n.no_service_requests_yet_description,
            action: BaseElevatedButton.primary(
              label: context.l10n.new_request,
              isFullWidth: false,
              icon: const Icon(Icons.add_rounded),
              onPressed: () => context.push(CreateServiceRequestScreen.routePath),
            ),
          ),
        ),
      ServiceRequestsListSuccessful(:final serviceRequests, :final isFromCache) => Column(
          children: [
            if (isFromCache) ...[
              const CachedDataBannerWidget(),
              const SpacerH12(),
            ],
            for (final serviceRequest in serviceRequests.take(kRecentServiceRequestsLimit))
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: ServiceRequestCardWidget(
                  serviceRequest: serviceRequest,
                  onTap: () => context.push(ServiceRequestDetailsScreen.location(serviceRequest.id)),
                ),
              ),
          ],
        ),
    };
  }
}
