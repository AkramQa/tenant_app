import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

/// Platform-adaptive switch tile bound to a `FormControl<bool>`.
class ReactiveSwitchListTile extends ReactiveFormField<bool, bool> {
  ReactiveSwitchListTile({
    super.key,
    super.formControlName,
    super.formControl,
    String? titleText,
    String? subtitleText,
    Widget? leading,
  }) : super(
          builder: (field) {
            final context = field.context;
            return SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: field.value ?? false,
              onChanged: field.control.enabled ? field.didChange : null,
              secondary: leading,
              title: titleText == null
                  ? null
                  : Text(titleText, style: context.titleSmall?.copyWith(color: context.colors.cardTitle)),
              subtitle: subtitleText == null
                  ? null
                  : Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(subtitleText, style: context.bodySmall?.copyWith(color: context.colors.cardSubTitle)),
                    ),
            );
          },
        );
}
