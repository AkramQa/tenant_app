import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/theme/app_radius.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/auth/data/models/tenant_info_model.dart';

/// Greeting card with tenant name, property and unit.
class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({required this.tenant, super.key});

  final TenantInfoModel tenant;

  @override
  Widget build(BuildContext context) {
    final Color onCard = context.colors.white;
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [context.colors.primary, context.colors.statusAssigned],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26.r,
                backgroundColor: onCard.withValues(alpha: 0.2),
                child: Text(tenant.initials, style: context.titleMedium?.copyWith(color: onCard)),
              ),
              const SpacerW12(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.welcome_home,
                      style: context.bodyMedium?.copyWith(color: onCard.withValues(alpha: 0.85)),
                    ),
                    const SpacerH4(),
                    Text(
                      tenant.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.headings.heading3.copyWith(color: onCard),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SpacerH16(),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _InfoPill(icon: Icons.apartment_rounded, text: tenant.propertyName),
              _InfoPill(icon: Icons.door_front_door_outlined, text: context.l10n.unit_number(tenant.unitNumber)),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final Color onCard = context.colors.white;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: onCard.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(AppRadius.round),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.r, color: onCard),
          const SpacerW4(),
          Flexible(child: Text(text, style: context.labelMedium?.copyWith(color: onCard))),
        ],
      ),
    );
  }
}
