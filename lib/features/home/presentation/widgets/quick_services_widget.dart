import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/presentation/widgets/base_card_widget.dart';
import 'package:tenant_app/core/presentation/widgets/base_icon_container_widget.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:tenant_app/features/service_requests/presentation/utils/service_request_ui_utils.dart';

/// Quick access to Maintenance, Plumbing, Electrical, AC and Cleaning.
/// 3 columns on phones, a single row of 5 when there's room.
class QuickServicesWidget extends StatelessWidget {
  const QuickServicesWidget({required this.onServiceSelected, super.key});

  final ValueChanged<ServiceType> onServiceSelected;

  @override
  Widget build(BuildContext context) {
    final List<ServiceType> serviceTypes = ServiceType.getValues();
    return LayoutBuilder(
      builder: (context, constraints) {
        final int columns = constraints.maxWidth >= 520 ? serviceTypes.length : 3;
        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 0.95,
          children: [
            for (final serviceType in serviceTypes)
              BaseCardWidget(
                padding: EdgeInsets.all(8.r),
                onTap: () => onServiceSelected(serviceType),
                child: Semantics(
                  button: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BaseIconContainerWidget(icon: serviceType.icon, color: serviceType.color(context)),
                      const SpacerH8(),
                      Text(
                        serviceType.translated(context),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: context.labelMedium?.copyWith(color: context.colors.cardTitle),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
