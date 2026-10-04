import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  DateTime get dateOnly => DateTime(year, month, day);

  /// e.g. "Oct 5, 2026" — follows the active app locale.
  String toDisplayDate(BuildContext context) =>
      DateFormat.yMMMd(Localizations.localeOf(context).toLanguageTag()).format(this);

  /// e.g. "Oct 5, 2026 3:42 PM".
  String toDisplayDateTime(BuildContext context) =>
      DateFormat.yMMMd(Localizations.localeOf(context).toLanguageTag()).add_jm().format(this);
}
