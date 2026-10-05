import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/presentation/widgets/base_card_widget.dart';
import 'package:tenant_app/core/presentation/widgets/base_icon_container_widget.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/core/utils/ext/date_time_ext.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/presentation/utils/service_request_ui_utils.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/request_status_tag_widget.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/urgent_tag_widget.dart';

class ServiceRequestCardWidget extends StatelessWidget {
  const ServiceRequestCardWidget({required this.serviceRequest, required this.onTap, super.key});

  final ServiceRequestModel serviceRequest;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final serviceType = serviceRequest.serviceType;
    return BaseCardWidget(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseIconContainerWidget(icon: serviceType.icon, color: serviceType.color(context)),
          const SpacerW12(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        serviceType.translated(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.titleSmall?.copyWith(
                          color: context.colors.cardTitle,
                          fontWeight: FontWeight.w600,
                      ),
                    ),
                    ),
                    if (serviceRequest.isUrgent) ...[const SpacerW8(), const UrgentTagWidget()],
                  ],
                ),
                const SpacerH4(),
                Text(
                  serviceRequest.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodySmall?.copyWith(color: context.colors.cardSubTitle),
                ),
                const SpacerH8(),
                Row(
                  children: [
                    RequestStatusTagWidget(status: serviceRequest.status),
                    const SpacerW8(),
                    Flexible(
                      child: Text(
                        context.l10n.requested_on(serviceRequest.createdAt.toDisplayDate(context)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.labelSmall?.copyWith(color: context.colors.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SpacerW8(),
          Icon(
            // Mirrors itself in RTL (matchTextDirection).
            Icons.chevron_right_rounded,
            color: context.colors.onSurfaceVariant,
            size: 22.r,
          ),
        ],
      ),
    );
  }
}
