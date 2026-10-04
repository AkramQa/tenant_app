import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

/// A widget that displays a spinner while data is loading (used inside buttons).
class Loader extends StatelessWidget {
  const Loader({super.key, this.color, this.size});

  /// The color of the spinner.
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: color ?? context.colors.onPrimary,
      size: size ?? 24.0.r,
    );
  }
}
