import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/theme/app_radius.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

/// Optional photo field bound to a `FormControl<String>` holding the picked
/// file path. Picking is delegated to [onPickImage] so the widget stays free
/// of platform plumbing.
class ReactiveImageAttachmentField extends ReactiveFormField<String, String> {
  ReactiveImageAttachmentField({
    super.key,
    super.formControlName,
    super.formControl,
    required Future<String?> Function() onPickImage,
  }) : super(
          builder: (field) {
            final context = field.context;
            final String? imagePath = field.value;

            Future<void> pick() async {
              final String? path = await onPickImage();
              if (path != null) field.didChange(path);
            }

            if (imagePath == null) {
              return InkWell(
                onTap: field.control.enabled ? pick : null,
                borderRadius: BorderRadius.circular(AppRadius.ml),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.ml),
                    border: Border.all(color: context.colors.surfaceContainerHighest),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.add_a_photo_outlined, color: context.colors.primary, size: 28.r),
                      const SpacerH8(),
                      Text(context.l10n.add_photo, style: context.titleSmall?.copyWith(color: context.colors.primary)),
                      const SpacerH4(),
                      Text(
                        context.l10n.add_photo_hint,
                        textAlign: TextAlign.center,
                        style: context.bodySmall?.copyWith(color: context.colors.cardSubTitle),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.ml),
              child: Stack(
                children: [
                  Semantics(
                    image: true,
                    label: context.l10n.attached_photo,
                    child: Image.file(
                      File(imagePath),
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 200.h,
                        color: context.colors.surfaceContainerHighest,
                        alignment: Alignment.center,
                        child: Icon(Icons.broken_image_outlined, color: context.colors.onSurfaceVariant),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 8.r,
                    end: 8.r,
                    child: Row(
                      children: [
                        IconButton.filledTonal(
                          tooltip: context.l10n.change_photo,
                          onPressed: field.control.enabled ? pick : null,
                          icon: const Icon(Icons.edit_outlined),
                        ),
                        IconButton.filledTonal(
                          tooltip: context.l10n.remove_photo,
                          onPressed: field.control.enabled ? () => field.didChange(null) : null,
                          icon: const Icon(Icons.close_rounded),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
}
