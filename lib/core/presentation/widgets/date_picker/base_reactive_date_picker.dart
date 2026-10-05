import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tenant_app/core/presentation/widgets/date_picker/adaptive_date_picker.dart';
import 'package:tenant_app/core/theme/app_radius.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/core/utils/ext/screen_utils_ext.dart';
import 'package:tenant_app/core/utils/ext/date_time_ext.dart';

/// Reactive-forms date field that opens the platform's native picker.
class BaseReactiveDatePicker extends StatelessWidget {
  const BaseReactiveDatePicker({
    required this.controller,
    required this.firstDate,
    required this.lastDate,
    this.label,
    this.hint,
    this.validationMessages,
    super.key,
  });

  factory BaseReactiveDatePicker.borderedTextField({
    required FormControl<DateTime> controller,
    required DateTime firstDate,
    required DateTime lastDate,
    String? label,
    String? hint,
    Map<String, String Function(Object)>? validationMessages,
    Key? key,
  }) =>
      BaseReactiveDatePicker(
        key: key,
        controller: controller,
        firstDate: firstDate,
        lastDate: lastDate,
        label: label,
        hint: hint,
        validationMessages: validationMessages,
      );

  final FormControl<DateTime> controller;
  final DateTime firstDate;
  final DateTime lastDate;
  final String? label;
  final String? hint;
  final Map<String, String Function(Object)>? validationMessages;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.dimens.spacing8.hMax,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text(label!, style: context.titleSmall?.copyWith(color: context.colors.cardTitle)),
        ReactiveFormField<DateTime, DateTime>(
          formControl: controller,
          validationMessages: validationMessages,
          builder: (field) {
            final DateTime? value = field.value;
            return InkWell(
              borderRadius: BorderRadius.circular(AppRadius.ml),
              onTap: field.control.enabled
                  ? () async {
                      FocusScope.of(field.context).unfocus();
                      final DateTime? picked = await showAdaptiveDatePickerSheet(
                        field.context,
                        initialDate: value ?? firstDate,
                        firstDate: firstDate,
                        lastDate: lastDate,
                      );
                      field.control.markAsTouched();
                      if (picked != null) field.didChange(picked.dateOnly);
                    }
                  : null,
              child: InputDecorator(
                isEmpty: value == null,
                decoration: InputDecoration(
                  hintText: hint,
                  errorText: field.errorText,
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                  suffixIcon: const Icon(Icons.expand_more_rounded),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: context.colors.surfaceContainerHighest),
                    borderRadius: BorderRadius.circular(AppRadius.ml),
                  ),
                ),
                child: Text(
                  value?.toDisplayDate(context) ?? '',
                  style: context.bodyLarge?.copyWith(color: context.colors.cardTitle),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
