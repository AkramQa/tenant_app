import 'package:flutter/material.dart';
import 'package:tenant_app/core/presentation/widgets/buttons/base_text_button.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

class TitleViewAll extends StatelessWidget {
  const TitleViewAll({
    required this.title,
    this.onViewAllPressed,
    super.key,
  });

  final String title;
  final VoidCallback? onViewAllPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Semantics(
            header: true,
            child: Text(title, style: context.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          ),
        ),
        if (onViewAllPressed != null)
          BaseTextButton(
            onPressed: () => onViewAllPressed?.call(),
            label: context.l10n.view_all,
            isFullWidth: false,
          ),
      ],
    );
  }
}
