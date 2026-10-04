import 'package:flutter/material.dart';

/// Full-area, platform-adaptive spinner (Cupertino on iOS, Material elsewhere).
class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
