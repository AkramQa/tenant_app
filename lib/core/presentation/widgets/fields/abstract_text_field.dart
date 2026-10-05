import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:separated_column/separated_column.dart';
import 'package:tenant_app/core/presentation/widgets/fields/obscure_toggle_text.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/theme/app_radius.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

abstract class AbstractTextField extends StatelessWidget {
  const AbstractTextField({
    this.textFieldType = TextFieldType.baseTextField,
    this.label,
    this.autofillHints,
    this.textInputAction,
    this.userObscure = false,
    this.suffixIcon,
    this.onSubmitForm,
    this.validationMessages,
    this.inputFormatters,
    this.textInputType,
    this.hint,
    this.prefixIcon,
    this.maxLines,
    this.minLines,
    this.maxLength,
    super.key,
  });

  final String? label;
  final String? hint;
  final bool userObscure;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final Map<String, String Function(Object)>? validationMessages;
  final VoidCallback? onSubmitForm;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final Widget? prefixIcon;
  final TextFieldType textFieldType;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    late final Widget child;
    if (userObscure) {
      child = ObscureToggleText(
        builder: (suffixIcon, isTextObscured) =>
            buildField(context, isObscure: isTextObscured, suffixIcon: suffixIcon),
      );
    } else {
      child = buildField(context, suffixIcon: suffixIcon);
    }

    return SeparatedColumn(
      separatorBuilder: (_, __) => const SpacerH8(),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text(label!, style: context.titleSmall?.copyWith(color: context.colors.cardTitle)),
        child,
      ],
    );
  }

  Widget buildField(BuildContext context, {bool isObscure = false, Widget? suffixIcon});

  InputDecoration buildDecoration(BuildContext context, Widget? suffixIcon) {
    return InputDecoration(
      hintText: hint,
      hintMaxLines: 2,
      alignLabelWithHint: true,
      suffixIcon: suffixIcon,
      prefixIcon: _buildPrefixIcon(),
      enabledBorder: textFieldType.getEnabledBorder(context),
      focusedBorder: textFieldType.getFocusedBorder(context),
      fillColor: textFieldType.fillColor(context),
    );
  }

  Widget? _buildPrefixIcon() {
    if (prefixIcon == null) return null;
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 12.0.w, end: 6.w),
      child: Row(mainAxisSize: MainAxisSize.min, children: [prefixIcon!]),
    );
  }
}

enum TextFieldType {
  baseTextField,
  borderedTextField;

  Color? fillColor(BuildContext context) => switch (this) {
        TextFieldType.baseTextField => null,
        TextFieldType.borderedTextField => context.colors.surface,
      };

  InputBorder? getEnabledBorder(BuildContext context) => switch (this) {
        TextFieldType.baseTextField => null,
        TextFieldType.borderedTextField => OutlineInputBorder(
            borderSide: BorderSide(color: context.colors.surfaceContainerHighest),
            borderRadius: BorderRadius.circular(AppRadius.ml),
          ),
      };

  InputBorder? getFocusedBorder(BuildContext context) => switch (this) {
        TextFieldType.baseTextField => null,
        TextFieldType.borderedTextField => OutlineInputBorder(
            borderSide: BorderSide(color: context.colors.primary),
            borderRadius: BorderRadius.circular(AppRadius.ml),
          ),
      };
}
