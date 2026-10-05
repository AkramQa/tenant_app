import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/presentation/widgets/buttons/button_loader.dart';

class LoadableWidget extends StatelessWidget {
  const LoadableWidget({
    required this.isLoading,
    required this.child,
    this.loaderColor,
    super.key,
  });

  final bool isLoading;
  final Widget child;
  final Color? loaderColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        isLoading
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0.r),
                child: ButtonLoader(size: 14.0.r, color: loaderColor),
              )
            : Flexible(child: child),
      ],
    );
  }
}
