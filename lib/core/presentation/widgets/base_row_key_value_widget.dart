import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
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
          const SpacerW8(),
        ],
        // Flexible so a long (e.g. Arabic) key wraps instead of overflowing the row.
        Flexible(
          child: Text(keyAsString, style: context.bodyMedium?.copyWith(color: context.colors.cardSubTitle)),
        ),
        const SpacerW16(),
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
