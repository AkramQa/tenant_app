import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/presentation/providers/auth/auth_notifier.dart';
import 'package:tenant_app/core/presentation/routes/app_router.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/theme/app_radius.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

@RoutePage()
class LauncherScreen extends ConsumerStatefulWidget {
  const LauncherScreen({super.key});

  static const String routePath = '/';

  @override
  ConsumerState<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends ConsumerState<LauncherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAuthStatus());
  }

  Future<void> _checkAuthStatus() async {
    final authNotifier = ref.read(authProvider.notifier);
    // Minimum splash duration so the brand screen doesn't flash.
    await Future.wait([
      authNotifier.checkAuthenticationStatus(),
      Future<void>.delayed(const Duration(milliseconds: 600)),
    ]);
    if (!mounted) return;

    AutoRouter.of(context).pushAndPopUntil(
      authNotifier.isUserAuthenticated ? const DashboardHomeRoute() : const SignInRoute(),
      predicate: (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topCenter,
            end: AlignmentDirectional.bottomCenter,
            colors: [context.colors.primaryHighlight, context.colors.primary],
          ),
        ),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96.r,
                height: 96.r,
                decoration: BoxDecoration(
                  color: context.colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.lg.r),
                ),
                child: Icon(Icons.apartment_rounded, size: 52.r, color: context.colors.primary),
              ),
              const SpacerH16(),
              Text(
                context.l10n.app_name,
                style: context.textTheme.headings.heading2.copyWith(color: context.colors.white),
              ),
              const SpacerH8(),
              Text(
                context.l10n.app_tagline,
                style: context.bodyLarge?.copyWith(color: context.colors.white.withValues(alpha: 0.9)),
              ),
              const SpacerH32(),
              CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(context.colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
