import 'package:flutter/material.dart';
import 'package:tenant_app/core/presentation/widgets/base_sheet/base_sheet.dart';
import 'package:tenant_app/core/presentation/widgets/base_sheet/base_sheet_option.dart';

class OptionsBaseSheet {
  const OptionsBaseSheet._();

  /// Shows a list of [BaseSheetOption]s. The option's `onTap` decides what
  /// to return — usually `Navigator.of(context).pop(value)`.
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required List<BaseSheetOption> options,
  }) =>
      BaseSheet.show<T>(
        context: context,
        title: title,
        child: Column(mainAxisSize: MainAxisSize.min, children: options),
      );
}
