import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/core/utils/ext/screen_utils_ext.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:tenant_app/features/service_requests/presentation/utils/service_request_ui_utils.dart';

/// Chip group bound to a `FormControl<ServiceType>` — same pattern as
/// Ulearna's `ReactiveCourseReviewLevelSelection`.
class ReactiveServiceTypeSelection extends ReactiveFormField<ServiceType, ServiceType> {
  ReactiveServiceTypeSelection({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
  }) : super(
          builder: (field) {
            final context = field.context;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8.wMin,
                  runSpacing: 8.hMax,
                  children: ServiceType.getValues().map((serviceType) {
                    final bool isSelected = field.value == serviceType;
                    final Color color = serviceType.color(context);
                    return ChoiceChip(
                      avatar: Icon(serviceType.icon, size: 18.r, color: isSelected ? context.colors.white : color),
                      label: Text(serviceType.translated(context)),
                      selected: isSelected,
                      selectedColor: color,
                      backgroundColor: context.colors.surface,
                      side: BorderSide(color: isSelected ? color : context.colors.borderColor),
                      labelStyle: context.labelMedium?.copyWith(
                        color: isSelected ? context.colors.white : context.colors.cardTitle,
                      ),
                      onSelected: field.control.enabled
                          ? (_) {
                              field.control.markAsTouched();
                              field.didChange(serviceType);
                            }
                          : null,
                    );
                  }).toList(),
                ),
                if (field.errorText != null)
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 6.h, start: 4.w),
                    child: Text(field.errorText!, style: context.bodySmall?.copyWith(color: context.colors.error)),
                  ),
              ],
            );
          },
        );
}
