import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

class BaseRowKeyValueWidget extends StatelessWidget {
  final String keyAsString;
  final String? value;
  final IconData? icon;

  const BaseRowKeyValueWidget({
    required this.keyAsString,
    required this.value,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18.r, color: context.colors.onSurfaceVariant),
          SizedBox(width: 8.w),
        ],
        Text(keyAsString, style: context.bodyMedium?.copyWith(color: context.colors.cardSubTitle)),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            value ?? '',
            textAlign: TextAlign.end,
            style: context.bodyMedium?.copyWith(color: context.colors.cardTitle, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
