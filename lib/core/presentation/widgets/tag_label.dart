import 'package:flutter/material.dart';
import 'package:tenant_app/core/theme/app_radius.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/core/utils/ext/screen_utils_ext.dart';

/// Small pill label (request status, urgent badge).
class TagLabel extends StatelessWidget {
  const TagLabel({
    required this.label,
    required this.color,
    this.icon,
    this.showDot = false,
    super.key,
  });

  final String label;
  final Color color;
  final IconData? icon;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.round),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 8.wMin, vertical: 3.hMax),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showDot) ...[
              Container(
                width: 6.rMax,
                height: 6.rMax,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              SizedBox(width: 5.wMin),
            ],
            if (icon != null) ...[
              Icon(icon, size: 12.rMax, color: color),
              SizedBox(width: 3.wMin),
            ],
            Text(label, style: context.textTheme.body.caption.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
