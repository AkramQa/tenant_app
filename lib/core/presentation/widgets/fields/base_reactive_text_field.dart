import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';
import 'package:tenant_app/core/presentation/widgets/fields/abstract_text_field.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

class BaseReactiveTextField<T, E> extends AbstractTextField<T, E> {
  const BaseReactiveTextField({
    required this.formModel,
    this.controller,
    this.formControlName,
    this.nextController,
    super.textFieldType = TextFieldType.baseTextField,
    super.label,
    super.autofillHints,
    super.textInputAction,
    super.userObscure = false,
    super.suffixIcon,
    super.onSubmitForm,
    super.onTextChanged,
    super.validationMessages,
    super.inputFormatters,
    super.textInputType,
    super.hint,
    super.prefixIcon,
    super.maxLines,
    super.minLines,
    super.maxLength,
    this.onTap,
    this.readOnly = false,
    super.key,
  });

  factory BaseReactiveTextField.borderedTextField({
    required FormModel<T, E> formModel,
    FormControl<Object?>? controller,
    String? formControlName,
    String? hintText,
    FormControl<dynamic>? nextController,
    void Function(FormControl<Object?>)? onTap,
    Map<String, String Function(Object)>? validationMessages,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? textInputType,
    TextInputAction? textInputAction,
    bool userObscure = false,
    Iterable<String>? autofillHints,
    ValueChanged<T>? onSubmitForm,
    ValueChanged<T>? onTextChanged,
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
        formModel: formModel,
        controller: controller,
        formControlName: formControlName,
        onTap: onTap,
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
        onTextChanged: onTextChanged,
        readOnly: readOnly,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
      );

  final FormModel<T, E> formModel;
  final FormControl<Object?>? controller;
  final String? formControlName;
  final FormControl<dynamic>? nextController;
  final void Function(FormControl<Object?>)? onTap;
  final bool readOnly;

  @override
  Widget buildField(BuildContext context, {bool isObscure = false, Widget? suffixIcon}) {
    final bool isMultiline = (maxLines ?? 1) > 1;
    return ReactiveTextField(
      obscureText: isObscure,
      readOnly: readOnly,
      formControl: controller,
      formControlName: formControlName,
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
      onTap: onTap,
      maxLines: isObscure ? 1 : (maxLines ?? 1),
      minLines: minLines,
      maxLength: maxLength,
      onSubmitted: (_) {
        if (nextController != null) {
          nextController!.focus();
        }
        if (onSubmitForm != null && formModel.form.valid) {
          onSubmitForm!(formModel.rawModel);
        }
      },
      onChanged: (_) {
        if (onTextChanged != null) {
          onTextChanged!(formModel.rawModel);
        }
      },
    );
  }
}
