import 'package:flutter/material.dart';
import 'package:tenant_app/core/presentation/widgets/dialogs/base_confirmation_dialog.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

class LogoutConfirmationDialog {
  const LogoutConfirmationDialog._();

  static Future<bool> show({required BuildContext context}) => BaseConfirmationDialog.show(
        context: context,
        title: context.l10n.logout_confirmation_title,
        message: context.l10n.logout_confirmation_message,
        confirmLabel: context.l10n.logout,
        isDestructive: true,
      );
}
