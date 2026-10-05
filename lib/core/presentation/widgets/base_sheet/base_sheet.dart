import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/theme/app_radius.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

class BaseSheet<T> extends StatelessWidget {
  const BaseSheet._({
    required this.child,
    this.title,
    this.padding,
  });

  final Widget child;
  final String? title;
  final EdgeInsets? padding;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool useRootNavigator = true,
    EdgeInsets? padding,
  }) =>
      showModalBottomSheet<T>(
        context: context,
        useRootNavigator: useRootNavigator,
        isDismissible: isDismissible,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Colors.transparent,
        builder: (_) => BaseSheet<T>._(title: title, padding: padding, child: child),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.ml)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SpacerH12(),
            const SheetNotch(),
            const SpacerH16(),
            if (title != null) ...[
              Text(title!, style: context.titleMedium?.copyWith(color: context.colors.cardTitle)),
              const SpacerH8(),
            ],
            Flexible(
              child: SingleChildScrollView(
                padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SheetNotch extends StatelessWidget {
  const SheetNotch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.round),
      ),
    );
  }
}
