import 'package:flutter/material.dart';
import 'package:tenant_app/core/theme/app_theme.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/core/utils/ext/screen_utils_ext.dart';

class SpacerH32 extends StatelessWidget {
  const SpacerH32({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: context.theme.dimensions.spacing32.hMax);
}

class SpacerH24 extends StatelessWidget {
  const SpacerH24({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: context.theme.dimensions.spacing24.hMax);
}

class SpacerH16 extends StatelessWidget {
  const SpacerH16({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: context.theme.dimensions.spacing16.hMax);
}

class SpacerH12 extends StatelessWidget {
  const SpacerH12({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: context.theme.dimensions.spacing12.hMax);
}

class SpacerH8 extends StatelessWidget {
  const SpacerH8({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: context.theme.dimensions.spacing8.hMax);
}

class SpacerH6 extends StatelessWidget {
  const SpacerH6({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: 6.hMax);
}

class SpacerH4 extends StatelessWidget {
  const SpacerH4({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: context.theme.dimensions.spacing4.hMax);
}

class SpacerW32 extends StatelessWidget {
  const SpacerW32({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(width: context.theme.dimensions.spacing32.wMax);
}

class SpacerW24 extends StatelessWidget {
  const SpacerW24({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(width: context.theme.dimensions.spacing24.wMax);
}

class SpacerW16 extends StatelessWidget {
  const SpacerW16({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(width: context.theme.dimensions.spacing16.wMax);
}

class SpacerW12 extends StatelessWidget {
  const SpacerW12({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(width: context.theme.dimensions.spacing12.wMax);
}

class SpacerW8 extends StatelessWidget {
  const SpacerW8({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(width: context.theme.dimensions.spacing8.wMax);
}

class SpacerW4 extends StatelessWidget {
  const SpacerW4({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(width: context.theme.dimensions.spacing4.wMax);
}
