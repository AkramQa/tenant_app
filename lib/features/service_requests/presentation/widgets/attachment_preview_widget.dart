import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/theme/app_radius.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

/// Read-only attachment thumbnail; tap to open a zoomable full-screen view.
class AttachmentPreviewWidget extends StatelessWidget {
  const AttachmentPreviewWidget({required this.imagePath, super.key});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: context.l10n.attached_photo,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.ml),
        onTap: () {
          if (File(imagePath).existsSync()) _openFullScreen(context);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.ml),
          child: Image.file(
            File(imagePath),
            height: 220.h,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 120.h,
              color: context.colors.surfaceContainerHighest,
              alignment: Alignment.center,
              child: Text(context.l10n.photo_unavailable, style: context.bodySmall),
            ),
          ),
        ),
      ),
    );
  }

  void _openFullScreen(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog.fullscreen(
        backgroundColor: dialogContext.colors.black,
        child: Stack(
          children: [
            Positioned.fill(
              child: InteractiveViewer(
                maxScale: 4,
                child: Center(
                  child: Image.file(
                    File(imagePath),
                    errorBuilder: (_, __, ___) => Text(
                      dialogContext.l10n.photo_unavailable,
                      style: dialogContext.bodyMedium?.copyWith(color: dialogContext.colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: IconButton(
                  tooltip: dialogContext.l10n.close,
                  color: dialogContext.colors.white,
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
