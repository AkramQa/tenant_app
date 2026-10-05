import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

/// Small spinner shown inside a button while its action is running.
class ButtonLoader extends StatelessWidget {
  const ButtonLoader({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final double dimension = size ?? 20.0.r;
    return SizedBox.square(
      dimension: dimension,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation(color ?? context.colors.onPrimary),
      ),
    );
  }
}
