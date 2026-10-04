import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

/// Platform-aware date picker: Cupertino wheel on iOS, Material calendar
/// on Android.
Future<DateTime?> showAdaptiveDatePickerSheet(
  BuildContext context, {
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) {
  if (!context.isCupertinoPlatform) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
  }

  DateTime selected = initialDate;
  return showCupertinoModalPopup<DateTime>(
    context: context,
    builder: (sheetContext) => Container(
      height: 300.h,
      color: sheetContext.colors.surface,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  onPressed: () => Navigator.of(sheetContext).pop(),
                  child: Text(sheetContext.l10n.cancel),
                ),
                CupertinoButton(
                  onPressed: () => Navigator.of(sheetContext).pop(selected),
                  child: Text(sheetContext.l10n.done),
                ),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate,
                minimumDate: firstDate,
                maximumDate: lastDate,
                onDateTimeChanged: (date) => selected = date,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
