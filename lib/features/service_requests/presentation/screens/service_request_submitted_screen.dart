import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tenant_app/core/presentation/widgets/base_card_widget.dart';
import 'package:tenant_app/core/presentation/widgets/base_icon_container_widget.dart';
import 'package:tenant_app/core/presentation/widgets/base_row_key_value_widget.dart';
import 'package:tenant_app/core/presentation/widgets/buttons/base_elevated_button.dart';
import 'package:tenant_app/core/presentation/widgets/buttons/base_text_button.dart';
import 'package:tenant_app/core/presentation/widgets/responsive_center_widget.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/core/utils/ext/date_time_ext.dart';
import 'package:tenant_app/features/home/presentation/screens/home_screen.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/service_request_details_screen.dart';
import 'package:tenant_app/features/service_requests/presentation/utils/service_request_ui_utils.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/request_status_tag_widget.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/urgent_tag_widget.dart';

/// Confirmation shown after a request is created, above the Requests tab.
class ServiceRequestSubmittedScreen extends StatefulWidget {
  const ServiceRequestSubmittedScreen({required this.serviceRequest, super.key});

  final ServiceRequestModel serviceRequest;

  static const String routePath = '/service-request-submitted';

  @override
  State<ServiceRequestSubmittedScreen> createState() => _ServiceRequestSubmittedScreenState();
}

class _ServiceRequestSubmittedScreenState extends State<ServiceRequestSubmittedScreen> {
  @override
  void initState() {
    super.initState();
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    final ServiceRequestModel serviceRequest = widget.serviceRequest;
    final serviceType = serviceRequest.serviceType;

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: ResponsiveCenterWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.6, end: 1),
                    duration: const Duration(milliseconds: 450),
                    curve: Curves.easeOutBack,
                    builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
                    child: BaseIconContainerWidget(
                      icon: Icons.check_rounded,
                      color: context.colors.success,
                      size: 88.r,
                    ),
                  ),
                ),
                const SpacerH24(),
                Text(
                  context.l10n.request_submitted_title,
                  textAlign: TextAlign.center,
                  style: context.titleLarge?.copyWith(color: context.colors.cardTitle, fontWeight: FontWeight.w700),
                ),
                const SpacerH8(),
                Text(
                  context.l10n.request_submitted_description(serviceType.translated(context)),
                  textAlign: TextAlign.center,
                  style: context.bodyMedium?.copyWith(color: context.colors.cardSubTitle),
                ),
                const SpacerH24(),
                BaseCardWidget(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          BaseIconContainerWidget(icon: serviceType.icon, color: serviceType.color(context)),
                          const SpacerW12(),
                          Expanded(
                            child: Text(
                              serviceType.translated(context),
                              style: context.titleMedium?.copyWith(color: context.colors.cardTitle),
                            ),
                          ),
                          RequestStatusTagWidget(status: serviceRequest.status),
                          if (serviceRequest.isUrgent) ...[const SpacerW8(), const UrgentTagWidget()],
                        ],
                      ),
                      const SpacerH16(),
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
                    ],
                  ),
                ),
                const SpacerH32(),
                BaseElevatedButton.primary(
                  label: context.l10n.view_request,
                  onPressed: () =>
                      context.pushReplacement(ServiceRequestDetailsScreen.location(serviceRequest.id)),
                ),
                const SpacerH8(),
                BaseTextButton(
                  label: context.l10n.back_to_home,
                  isFullWidth: true,
                  onPressed: () => context.go(HomeScreen.routePath),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
