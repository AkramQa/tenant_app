import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/theme/app_radius.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

enum BaseSheetType {
  normal,
  selectedOption;

  bool get isSelectedOption => this == selectedOption;
}

class BaseSheetOption extends StatelessWidget {
  const BaseSheetOption({
    super.key,
    required this.text,
    required this.selected,
    required this.onTap,
    required this.baseSheetType,
    this.icon,
  });

  final String text;
  final bool selected;
  final Function(BuildContext context) onTap;
  final BaseSheetType baseSheetType;
  final IconData? icon;

  factory BaseSheetOption.choice({
    required String text,
    required Function(BuildContext context) onTap,
    IconData? icon,
  }) =>
      BaseSheetOption(
        text: text,
        selected: false,
        onTap: onTap,
        icon: icon,
        baseSheetType: BaseSheetType.normal,
      );

  factory BaseSheetOption.selectedChoice({
    required String text,
    required bool selected,
    required Function(BuildContext context) onTap,
    IconData? icon,
  }) =>
      BaseSheetOption(
        text: text,
        selected: selected,
        onTap: onTap,
        icon: icon,
        baseSheetType: BaseSheetType.selectedOption,
      );

  @override
  Widget build(BuildContext context) {
    final Color color = selected ? context.colors.primary : context.colors.cardTitle;
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.m),
        onTap: () => onTap(context),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 4.w),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: color, size: 22.r),
                SizedBox(width: 12.w),
              ],
              Expanded(child: Text(text, style: context.bodyLarge?.copyWith(color: color))),
              if (baseSheetType.isSelectedOption && selected)
                Icon(Icons.check_rounded, color: context.colors.primary, size: 22.r),
            ],
          ),
        ),
      ),
    );
  }
}
