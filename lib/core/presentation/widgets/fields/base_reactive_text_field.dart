import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tenant_app/core/presentation/widgets/fields/abstract_text_field.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

/// Text field bound to a `FormControl<String>`.
class BaseReactiveTextField extends AbstractTextField {
  const BaseReactiveTextField({
    required this.controller,
    this.nextController,
    super.textFieldType = TextFieldType.baseTextField,
    super.label,
    super.autofillHints,
    super.textInputAction,
    super.userObscure = false,
    super.suffixIcon,
    super.onSubmitForm,
    super.validationMessages,
    super.inputFormatters,
    super.textInputType,
    super.hint,
    super.prefixIcon,
    super.maxLines,
    super.minLines,
    super.maxLength,
    this.readOnly = false,
    super.key,
  });

  factory BaseReactiveTextField.borderedTextField({
    required FormControl<String> controller,
    String? hintText,
    FormControl<dynamic>? nextController,
    Map<String, String Function(Object)>? validationMessages,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? textInputType,
    TextInputAction? textInputAction,
    bool userObscure = false,
    Iterable<String>? autofillHints,
    VoidCallback? onSubmitForm,
    String? label,
    bool readOnly = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    int? maxLines,
    int? minLines,
    int? maxLength,
    Key? key,
  }) =>
      BaseReactiveTextField(
        key: key,
        textFieldType: TextFieldType.borderedTextField,
        controller: controller,
        nextController: nextController,
        hint: hintText,
        label: label,
        validationMessages: validationMessages,
        inputFormatters: inputFormatters,
        textInputType: textInputType,
        textInputAction: textInputAction,
        userObscure: userObscure,
        autofillHints: autofillHints,
        onSubmitForm: onSubmitForm,
        readOnly: readOnly,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
      );

  final FormControl<String> controller;
  final FormControl<dynamic>? nextController;
  final bool readOnly;

  @override
  Widget buildField(BuildContext context, {bool isObscure = false, Widget? suffixIcon}) {
    final bool isMultiline = (maxLines ?? 1) > 1;
    return ReactiveTextField<String>(
      formControl: controller,
      obscureText: isObscure,
      readOnly: readOnly,
      autofillHints: autofillHints,
      validationMessages: validationMessages,
      inputFormatters: inputFormatters,
      decoration: buildDecoration(context, suffixIcon ?? this.suffixIcon),
      keyboardType: isMultiline ? TextInputType.multiline : textInputType,
      style: context.bodyLarge?.copyWith(color: context.colors.cardTitle),
      textInputAction: textInputAction ??
          (isMultiline
              ? TextInputAction.newline
              : (nextController == null ? TextInputAction.done : TextInputAction.next)),
      maxLines: isObscure ? 1 : (maxLines ?? 1),
      minLines: minLines,
      maxLength: maxLength,
      onSubmitted: (_) {
        if (nextController != null) {
          nextController!.focus();
        }
        onSubmitForm?.call();
      },
    );
  }
}
