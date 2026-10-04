import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/presentation/widgets/buttons/base_text_button.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/theme/app_radius.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

/// Shows the mock account so reviewers can sign in without guessing.
class DemoCredentialsWidget extends StatelessWidget {
  const DemoCredentialsWidget({required this.onUseDemoAccount, super.key});

  final VoidCallback onUseDemoAccount;

  @override
  Widget build(BuildContext context) {
    final Color infoColor = context.colors.info;
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: infoColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.ml),
        border: Border.all(color: infoColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded, color: infoColor, size: 20.r),
              const SpacerW8(),
              Expanded(child: Text(context.l10n.demo_account, style: context.titleSmall)),
            ],
          ),
          const SpacerH8(),
          Text(
            context.l10n.demo_account_details(kDemoEmail, kDemoPhoneNumber, kDemoPassword),
            style: context.bodySmall?.copyWith(color: context.colors.cardSubTitle),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: BaseTextButton(
              onPressed: onUseDemoAccount,
              label: context.l10n.use_demo_account,
              isFullWidth: false,
            ),
          ),
        ],
      ),
    );
  }
}
