import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/theme/app_radius.dart';

/// Tinted rounded square holding an icon (service types, empty/error states).
class BaseIconContainerWidget extends StatelessWidget {
  const BaseIconContainerWidget({
    required this.icon,
    required this.color,
    this.size,
    super.key,
  });

  final IconData icon;
  final Color color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final double dimension = size ?? 44.r;
    return Container(
      width: dimension,
      height: dimension,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.m.r),
      ),
      child: Icon(icon, color: color, size: dimension * 0.5),
    );
  }
}
