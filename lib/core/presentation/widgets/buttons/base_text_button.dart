import 'package:flutter/material.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

class BaseTextButton extends StatelessWidget {
  const BaseTextButton({
    required this.onPressed,
    required this.label,
    this.isFullWidth = true,
    this.color,
    super.key,
  });

  final VoidCallback? onPressed;
  final String label;
  final bool isFullWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final button = TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color ?? context.colors.primary,
        textStyle: context.labelLarge,
      ),
      child: Text(label),
    );
    return isFullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}
