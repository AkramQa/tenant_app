import 'package:flutter/material.dart';
import 'package:tenant_app/core/presentation/widgets/tag_label.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

class UrgentTagWidget extends StatelessWidget {
  const UrgentTagWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TagLabel(
      label: context.l10n.urgent,
      color: context.colors.urgent,
      icon: Icons.priority_high_rounded,
    );
  }
}
