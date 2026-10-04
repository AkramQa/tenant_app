import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/presentation/widgets/base_shimmer_widget.dart';
import 'package:tenant_app/core/theme/app_radius.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

/// Skeleton placeholders matching the request card layout.
class ServiceRequestsShimmerListWidget extends StatelessWidget {
  const ServiceRequestsShimmerListWidget({this.itemCount = 4, super.key});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return BaseShimmerWidget(
      child: Column(
        children: List.generate(
          itemCount,
          (_) => Container(
            height: 96.h,
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: context.colors.shimmerBase,
              borderRadius: BorderRadius.circular(AppRadius.ml),
            ),
          ),
        ),
      ),
    );
  }
}
