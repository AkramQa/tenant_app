import 'dart:ui';

import 'package:flutter/material.dart';

/// Blocking overlay loader for screens that submit something
/// (`startLoading()` / `stopLoading()`). The host implements [screen]
/// instead of `build`.
mixin ScreenLoader<T extends StatefulWidget> on State<T> {
  bool isLoading = false;

  void startLoading() {
    if (!mounted) return;
    setState(() => isLoading = true);
  }

  void stopLoading() {
    if (!mounted) return;
    setState(() => isLoading = false);
  }

  /// Override to change the blur value in a specific view.
  double loadingBgBlur() => 5.0;

  /// Override to provide a custom loader in a specific view.
  Widget loader() => const CircularProgressIndicator.adaptive();

  Widget screen(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        screen(context),
        if (isLoading)
          Positioned.fill(
            child: AbsorbPointer(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: loadingBgBlur(), sigmaY: loadingBgBlur()),
                child: ColoredBox(
                  color: Colors.transparent,
                  child: Center(child: loader()),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
