import 'package:flutter/material.dart';
import 'package:tenant_app/core/theme/app_breakpoints.dart';

/// Centers content and caps its width on tablets / landscape so cards and
/// text lines don't stretch edge-to-edge.
class ResponsiveCenterWidget extends StatelessWidget {
  const ResponsiveCenterWidget({
    required this.child,
    this.maxWidth = AppBreakpoints.maxContentWidth,
    super.key,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
