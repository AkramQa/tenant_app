import 'package:flutter/material.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

class BaseEmptyWidget extends StatelessWidget {
  const BaseEmptyWidget({
    required this.title,
    this.description,
    this.emptyIcon,
    this.titleColor,
    this.action,
    super.key,
  });

  final String title;
  final String? description;
  final Widget? emptyIcon;
  final Color? titleColor;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (emptyIcon != null) ...[
          emptyIcon!,
          const SpacerH16(),
        ],
        Text(
          title,
          style: context.titleSmall?.copyWith(color: titleColor ?? context.colors.cardTitle),
          textAlign: TextAlign.center,
        ),
        const SpacerH8(),
        if (description != null)
          Text(
            description!,
            style: context.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        if (action != null) ...[
          const SpacerH16(),
          action!,
        ],
      ],
    );
  }
}
