import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/presentation/widgets/base_card_widget.dart';
import 'package:tenant_app/core/presentation/widgets/base_icon_container_widget.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:tenant_app/features/service_requests/presentation/utils/service_request_ui_utils.dart';

/// Quick access to Maintenance, Plumbing, Electrical, AC and Cleaning.
/// Rows of 3 then 2 on phones (no empty cell), a single row of 5 when there's room.
class QuickServicesWidget extends StatelessWidget {
  const QuickServicesWidget({required this.onServiceSelected, super.key});

  final ValueChanged<ServiceType> onServiceSelected;

  static const int _phoneColumns = 3;

  @override
  Widget build(BuildContext context) {
    final List<ServiceType> serviceTypes = ServiceType.getValues();
    return LayoutBuilder(
      builder: (context, constraints) {
        final int columns = constraints.maxWidth >= 520 ? serviceTypes.length : _phoneColumns;
        final List<List<ServiceType>> rows = [
          for (int start = 0; start < serviceTypes.length; start += columns)
            serviceTypes.sublist(start, (start + columns).clamp(0, serviceTypes.length)),
        ];
        return Column(
          children: [
            for (int index = 0; index < rows.length; index++) ...[
              if (index > 0) const SpacerH12(),
              // Equal-height tiles per row even when one label wraps.
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int column = 0; column < rows[index].length; column++) ...[
                      if (column > 0) const SpacerW12(),
                      Expanded(child: _QuickServiceTile(serviceType: rows[index][column], onTap: onServiceSelected)),
                    ],
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _QuickServiceTile extends StatelessWidget {
  const _QuickServiceTile({required this.serviceType, required this.onTap});

  final ServiceType serviceType;
  final ValueChanged<ServiceType> onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: serviceType.translated(context),
      onTap: () => onTap(serviceType),
      excludeSemantics: true,
      child: BaseCardWidget(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        onTap: () => onTap(serviceType),
        child: Column(
          // Top-aligned so icons line up across tiles whatever the label length.
          mainAxisAlignment: MainAxisAlignment.start,
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
    );
  }
}
