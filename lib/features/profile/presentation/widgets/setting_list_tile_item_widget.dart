import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

class SettingListTileItemWidget extends StatelessWidget {
  const SettingListTileItemWidget({
    required this.icon,
    required this.title,
    this.value,
    this.onTap,
    this.trailing,
    this.color,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? value;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color foreground = color ?? context.colors.cardTitle;
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      leading: Icon(icon, color: color ?? context.colors.onSurfaceVariant),
      title: Text(title, style: context.bodyLarge?.copyWith(color: foreground)),
      trailing: trailing ??
          (value == null
              ? null
              : Text(value!, style: context.bodyMedium?.copyWith(color: context.colors.cardSubTitle))),
    );
  }
}
