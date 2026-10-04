import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/theme/app_radius.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

/// Shown when the data on screen comes from the offline cache.
class CachedDataBannerWidget extends StatelessWidget {
  const CachedDataBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = context.colors.warning;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.m),
      ),
      child: Row(
        children: [
          Icon(Icons.cloud_off_rounded, color: color, size: 18.r),
          const SpacerW8(),
          Expanded(
            child: Text(
              context.l10n.you_are_viewing_saved_data,
              style: context.bodySmall?.copyWith(color: context.colors.cardTitle),
            ),
          ),
        ],
      ),
    );
  }
}
