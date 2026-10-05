import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:separated_row/separated_row.dart';
import 'package:tenant_app/core/presentation/widgets/buttons/loadable_widget.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/theme/app_radius.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

class BaseElevatedButton extends StatelessWidget {
  const BaseElevatedButton({
    required this.onPressed,
    required this.label,
    required this.type,
    this.child,
    this.isEnabled = true,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.padding,
    super.key,
  });

  factory BaseElevatedButton.primary({
    required VoidCallback onPressed,
    required String label,
    bool isEnabled = true,
    bool isLoading = false,
    bool isFullWidth = true,
    Widget? child,
    Widget? icon,
    EdgeInsets? padding,
    Key? key,
  }) =>
      BaseElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        type: ElevatedButtonType.primary,
        isEnabled: isEnabled,
        isFullWidth: isFullWidth,
        isLoading: isLoading,
        icon: icon,
        padding: padding,
        child: child,
      );

  factory BaseElevatedButton.outline({
    required VoidCallback onPressed,
    required String label,
    bool isEnabled = true,
    bool isLoading = false,
    bool isFullWidth = true,
    Widget? child,
    Widget? icon,
    EdgeInsets? padding,
    Key? key,
  }) =>
      BaseElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        type: ElevatedButtonType.outline,
        isEnabled: isEnabled,
        isFullWidth: isFullWidth,
        isLoading: isLoading,
        icon: icon,
        padding: padding,
        child: child,
      );

  factory BaseElevatedButton.secondary({
    required VoidCallback onPressed,
    required String label,
    bool isEnabled = true,
    bool isLoading = false,
    bool isFullWidth = true,
    Widget? child,
    Widget? icon,
    EdgeInsets? padding,
    Key? key,
  }) =>
      BaseElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        type: ElevatedButtonType.secondary,
        isEnabled: isEnabled,
        isFullWidth: isFullWidth,
        isLoading: isLoading,
        icon: icon,
        padding: padding,
        child: child,
      );

  factory BaseElevatedButton.destructive({
    required VoidCallback onPressed,
    required String label,
    bool isEnabled = true,
    bool isLoading = false,
    bool isFullWidth = true,
    Widget? child,
    Widget? icon,
    EdgeInsets? padding,
    Key? key,
  }) =>
      BaseElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        type: ElevatedButtonType.destructive,
        isEnabled: isEnabled,
        isFullWidth: isFullWidth,
        isLoading: isLoading,
        icon: icon,
        padding: padding,
        child: child,
      );

  final ElevatedButtonType type;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isLoading;
  final String label;
  final bool isFullWidth;
  final Widget? child;
  final Widget? icon;
  final EdgeInsets? padding;

  bool get _isEnabled => isEnabled && !isLoading;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      style: type.buttonStyle(context, padding),
      onPressed: _isEnabled ? () => _onPressed(context) : null,
      child: _buildChild(context),
    );

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  void _onPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
    onPressed();
  }

  Widget _buildChild(BuildContext context) {
    late final Widget buttonChild;
    if (child != null) {
      buttonChild = child!;
    } else if (icon != null) {
      buttonChild = SeparatedRow(
        separatorBuilder: (_, __) => const SpacerW8(),
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          Flexible(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis)),
        ],
      );
    } else {
      buttonChild = Text(label, maxLines: 1, overflow: TextOverflow.ellipsis);
    }

    return LoadableWidget(
      isLoading: isLoading,
      loaderColor: type.foregroundColor(context),
      child: buttonChild,
    );
  }
}

enum ElevatedButtonType {
  primary,
  secondary,
  outline,
  destructive;

  ButtonStyle buttonStyle(BuildContext context, EdgeInsets? padding) {
    return ElevatedButton.styleFrom(
      elevation: 0,
      textStyle: context.textTheme.body.highlightEmphasis,
      foregroundColor: foregroundColor(context),
      backgroundColor: backgroundColor(context),
      disabledBackgroundColor: context.colors.surfaceContainerHighest,
      disabledForegroundColor: context.colors.onSurfaceVariant,
      padding: padding ?? EdgeInsets.symmetric(vertical: 14.0.h, horizontal: 24.0.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.ml.r),
        side: borderSide(context),
      ),
    );
  }

  Color foregroundColor(BuildContext context) => switch (this) {
        ElevatedButtonType.primary => context.colors.onPrimary,
        ElevatedButtonType.secondary => context.colors.onSurface,
        ElevatedButtonType.outline => context.colors.primary,
        ElevatedButtonType.destructive => context.colors.onError,
      };

  Color backgroundColor(BuildContext context) => switch (this) {
        ElevatedButtonType.primary => context.colors.primary,
        ElevatedButtonType.secondary => context.colors.surface,
        ElevatedButtonType.outline => context.colors.surface,
        ElevatedButtonType.destructive => context.colors.error,
      };

  BorderSide borderSide(BuildContext context) => switch (this) {
        ElevatedButtonType.secondary => BorderSide(color: context.colors.outline),
        ElevatedButtonType.outline => BorderSide(color: context.colors.primary.withValues(alpha: 0.9), width: 0.8),
        _ => BorderSide.none,
      };
}
