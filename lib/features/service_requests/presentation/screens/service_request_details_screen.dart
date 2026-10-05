import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/presentation/widgets/base_card_widget.dart';
import 'package:tenant_app/core/presentation/widgets/base_icon_container_widget.dart';
import 'package:tenant_app/core/presentation/widgets/base_row_key_value_widget.dart';
import 'package:tenant_app/core/presentation/widgets/error_view.dart';
import 'package:tenant_app/core/presentation/widgets/loader.dart';
import 'package:tenant_app/core/presentation/widgets/responsive_center_widget.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/core/utils/ext/date_time_ext.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/service_request_details/service_request_details_notifier.dart';
import 'package:tenant_app/features/service_requests/presentation/utils/service_request_ui_utils.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/attachment_preview_widget.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/cached_data_banner_widget.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/request_status_tag_widget.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/request_status_timeline_widget.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/urgent_tag_widget.dart';

class ServiceRequestDetailsScreen extends ConsumerStatefulWidget {
  const ServiceRequestDetailsScreen({
    required this.requestId,
    super.key,
  });

  final String requestId;

  static const String routePath = '/service-request/:id';

  static String location(String requestId) => '/service-request/$requestId';

  @override
  ConsumerState<ServiceRequestDetailsScreen> createState() => _ServiceRequestDetailsScreenState();
}

class _ServiceRequestDetailsScreenState extends ConsumerState<ServiceRequestDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(fetchServiceRequestDetails);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(serviceRequestDetailsProvider(widget.requestId));

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.request_details)),
      body: switch (state) {
        InitialServiceRequestDetails() || ServiceRequestDetailsLoading() => const Loader(),
        ServiceRequestDetailsFailure(:final failure) => ErrorView(
            failure: failure,
            onRetry: fetchServiceRequestDetails,
          ),
        ServiceRequestDetailsSuccessful(:final serviceRequest, :final isFromCache) => _ServiceRequestDetailsBody(
            serviceRequest: serviceRequest,
            isFromCache: isFromCache,
          ),
      },
    );
  }

  Future<void> fetchServiceRequestDetails() =>
      ref.read(serviceRequestDetailsProvider(widget.requestId).notifier).fetchServiceRequestDetails();
}

class _ServiceRequestDetailsBody extends StatelessWidget {
  const _ServiceRequestDetailsBody({required this.serviceRequest, required this.isFromCache});

  final ServiceRequestModel serviceRequest;
  final bool isFromCache;

  @override
  Widget build(BuildContext context) {
    final serviceType = serviceRequest.serviceType;
    final String? imagePath = serviceRequest.localImagePath;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: ResponsiveCenterWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isFromCache) ...[
              const CachedDataBannerWidget(),
              const SpacerH12(),
            ],
            // Header
            BaseCardWidget(
              child: Row(
                children: [
                  BaseIconContainerWidget(icon: serviceType.icon, color: serviceType.color(context), size: 56.r),
                  const SpacerW12(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serviceType.translated(context),
                          style: context.titleLarge?.copyWith(color: context.colors.cardTitle),
                        ),
                        const SpacerH8(),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 6.h,
                          children: [
                            RequestStatusTagWidget(status: serviceRequest.status),
                            if (serviceRequest.isUrgent) const UrgentTagWidget(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SpacerH16(),
            _DetailsSection(
              title: context.l10n.progress,
              child: RequestStatusTimelineWidget(status: serviceRequest.status),
            ),
            const SpacerH16(),
            _DetailsSection(
              title: context.l10n.description,
              child: Text(
                serviceRequest.description,
                style: context.bodyMedium?.copyWith(color: context.colors.cardTitle),
              ),
            ),
            const SpacerH16(),
            _DetailsSection(
              title: context.l10n.details,
              child: Column(
                children: [
                  BaseRowKeyValueWidget(
                    icon: Icons.tag_rounded,
                    keyAsString: context.l10n.request_number,
                    value: serviceRequest.referenceNumber,
                  ),
                  const SpacerH12(),
                  BaseRowKeyValueWidget(
                    icon: Icons.event_outlined,
                    keyAsString: context.l10n.preferred_date,
                    value: serviceRequest.preferredDate.toDisplayDate(context),
                  ),
                  const SpacerH12(),
                  BaseRowKeyValueWidget(
                    icon: Icons.schedule_outlined,
                    keyAsString: context.l10n.created_on,
                    value: serviceRequest.createdAt.toDisplayDateTime(context),
                  ),
                  const SpacerH12(),
                  BaseRowKeyValueWidget(
                    icon: Icons.flag_outlined,
                    keyAsString: context.l10n.status,
                    value: serviceRequest.status.translated(context),
                  ),
                  const SpacerH12(),
                  BaseRowKeyValueWidget(
                    icon: Icons.priority_high_rounded,
                    keyAsString: context.l10n.urgent_request,
                    value: serviceRequest.isUrgent ? context.l10n.yes : context.l10n.no,
                  ),
                ],
              ),
            ),
            const SpacerH16(),
            _DetailsSection(
              title: context.l10n.attached_photo,
              child: imagePath == null
                  ? Text(
                      context.l10n.no_photo_attached,
                      style: context.bodyMedium?.copyWith(color: context.colors.cardSubTitle),
                    )
                  : AttachmentPreviewWidget(imagePath: imagePath),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BaseCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.titleSmall?.copyWith(color: context.colors.cardTitle, fontWeight: FontWeight.w700)),
          const SpacerH12(),
          child,
        ],
      ),
    );
  }
}
