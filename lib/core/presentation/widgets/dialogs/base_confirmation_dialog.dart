import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

/// Platform-adaptive confirmation dialog (Cupertino alert on iOS).
class BaseConfirmationDialog {
  const BaseConfirmationDialog._();

  /// Returns `true` only when the user confirms.
  static Future<bool> show({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmLabel,
    bool isDestructive = false,
  }) async {
    final bool? result = await showAdaptiveDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: Text(title),
        content: Text(message),
        actions: [
          _DialogAction(
            label: dialogContext.l10n.cancel,
            onPressed: () => Navigator.of(dialogContext).pop(false),
          ),
          _DialogAction(
            label: confirmLabel,
            isDestructive: isDestructive,
            onPressed: () => Navigator.of(dialogContext).pop(true),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

class _DialogAction extends StatelessWidget {
  const _DialogAction({
    required this.label,
    required this.onPressed,
    this.isDestructive = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    if (context.isCupertinoPlatform) {
      return CupertinoDialogAction(
        isDestructiveAction: isDestructive,
        onPressed: onPressed,
        child: Text(label),
      );
    }
    return TextButton(
      onPressed: onPressed,
      style: isDestructive ? TextButton.styleFrom(foregroundColor: context.colors.error) : null,
      child: Text(label),
    );
  }
}
