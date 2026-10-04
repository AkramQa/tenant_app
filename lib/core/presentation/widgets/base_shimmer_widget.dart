import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

class BaseShimmerWidget extends StatelessWidget {
  const BaseShimmerWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colors.shimmerBase,
      highlightColor: context.colors.shimmerHighlight,
      child: child,
    );
  }
}
