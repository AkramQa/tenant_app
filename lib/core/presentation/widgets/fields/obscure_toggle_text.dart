import 'package:flutter/material.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

class ObscureToggleText extends StatefulWidget {
  const ObscureToggleText({required this.builder, super.key});

  final Widget Function(Widget suffixIcon, bool isTextObscured) builder;

  @override
  State<ObscureToggleText> createState() => _ObscureToggleTextState();
}

class _ObscureToggleTextState extends State<ObscureToggleText> {
  bool _obscureText = true;

  void _toggle() => setState(() => _obscureText = !_obscureText);

  @override
  Widget build(BuildContext context) {
    final suffixIcon = IconButton(
      tooltip: _obscureText ? context.l10n.show_password : context.l10n.hide_password,
      onPressed: _toggle,
      icon: Icon(
        _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: context.colors.onSurfaceVariant,
      ),
    );

    return widget.builder(suffixIcon, _obscureText);
  }
}
