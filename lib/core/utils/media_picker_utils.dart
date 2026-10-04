import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tenant_app/core/presentation/widgets/base_sheet/base_sheet_option.dart';
import 'package:tenant_app/core/presentation/widgets/base_sheet/options_base_sheet.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

class MediaPickerUtils {
  const MediaPickerUtils._();

  /// Lets the user choose camera or gallery, then returns the picked image
  /// path (`null` if cancelled). [onError] fires when the platform refuses
  /// access (e.g. permission denied).
  static Future<String?> pickImage({
    required BuildContext context,
    required ImagePicker imagePicker,
    VoidCallback? onError,
  }) async {
    final ImageSource? source = await OptionsBaseSheet.show<ImageSource>(
      context: context,
      title: context.l10n.add_photo,
      options: [
        BaseSheetOption.choice(
          text: context.l10n.take_photo,
          icon: Icons.photo_camera_outlined,
          onTap: (sheetContext) => Navigator.of(sheetContext).pop(ImageSource.camera),
        ),
        BaseSheetOption.choice(
          text: context.l10n.choose_from_gallery,
          icon: Icons.photo_library_outlined,
          onTap: (sheetContext) => Navigator.of(sheetContext).pop(ImageSource.gallery),
        ),
      ],
    );
    if (source == null) return null;

    try {
      final XFile? file = await imagePicker.pickImage(source: source, maxWidth: 1600, imageQuality: 80);
      return file?.path;
    } on PlatformException {
      onError?.call();
      return null;
    }
  }
}
