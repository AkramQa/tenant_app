import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/presentation/widgets/base_card_widget.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/auth/data/models/tenant_info_model.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({required this.tenant, super.key});

  final TenantInfoModel tenant;

  @override
  Widget build(BuildContext context) {
    return BaseCardWidget(
      child: Column(
        children: [
          CircleAvatar(
            radius: 36.r,
            backgroundColor: context.colors.primaryHighlight,
            child: Text(tenant.initials, style: context.titleLarge?.copyWith(color: context.colors.primary)),
          ),
          const SpacerH12(),
          Text(tenant.fullName, style: context.titleLarge?.copyWith(color: context.colors.cardTitle)),
          const SpacerH4(),
          Text(
            '${tenant.propertyName} · ${context.l10n.unit_number(tenant.unitNumber)}',
            textAlign: TextAlign.center,
            style: context.bodyMedium?.copyWith(color: context.colors.cardSubTitle),
          ),
        ],
      ),
    );
  }
}
