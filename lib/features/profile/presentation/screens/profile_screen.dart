import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/data/models/enum/languages_enum.dart';
import 'package:tenant_app/core/data/utils/network/network_info.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/presentation/providers/app_settings/app_settings_notifier.dart';
import 'package:tenant_app/core/presentation/providers/auth/auth_notifier.dart';
import 'package:tenant_app/core/presentation/widgets/base_card_widget.dart';
import 'package:tenant_app/core/presentation/widgets/base_sheet/base_sheet_option.dart';
import 'package:tenant_app/core/presentation/widgets/base_sheet/options_base_sheet.dart';
import 'package:tenant_app/core/presentation/widgets/loader.dart';
import 'package:tenant_app/core/presentation/widgets/responsive_center_widget.dart';
import 'package:tenant_app/core/presentation/widgets/screen_utils.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/presentation/widgets/title_view_all.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/auth/presentation/dialogs/logout_confirmation_dialog.dart';
import 'package:tenant_app/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:tenant_app/features/profile/presentation/widgets/setting_list_tile_item_widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  static const String routePath = '/profile';

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> with ScreenUtils {
  @override
  Widget build(BuildContext context) {
    final tenant = ref.watch(authProvider.select((state) => state is Authenticated ? state.user : null));
    final settings = ref.watch(appSettingsProvider);
    final bool isOfflineSimulated = ref.watch(simulateOfflineProvider);

    if (tenant == null) return const Scaffold(body: Loader());

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.profile)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: ResponsiveCenterWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileHeaderWidget(tenant: tenant),
              const SpacerH24(),
              TitleViewAll(title: context.l10n.contact_information),
              const SpacerH8(),
              BaseCardWidget(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    SettingListTileItemWidget(
                      icon: Icons.mail_outline_rounded,
                      title: context.l10n.email,
                      value: tenant.email ?? '-',
                    ),
                    const Divider(),
                    SettingListTileItemWidget(
                      icon: Icons.phone_outlined,
                      title: context.l10n.phone_number,
                      value: tenant.phoneNumber ?? '-',
                    ),
                  ],
                ),
              ),
              const SpacerH24(),
              TitleViewAll(title: context.l10n.settings),
              const SpacerH8(),
              BaseCardWidget(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    SettingListTileItemWidget(
                      icon: Icons.language_rounded,
                      title: context.l10n.language,
                      value: settings.language?.translate ?? context.l10n.system_default,
                      onTap: () => _selectLanguage(context, ref, settings.language),
                    ),
                    const Divider(),
                    SettingListTileItemWidget(
                      icon: Icons.dark_mode_outlined,
                      title: context.l10n.theme,
                      value: _themeModeLabel(context, settings.themeMode),
                      onTap: () => _selectThemeMode(context, ref, settings.themeMode),
                    ),
                    if (!kReleaseMode) ...[
                      const Divider(),
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                        secondary: Icon(Icons.wifi_off_rounded, color: context.colors.onSurfaceVariant),
                        title: Text(context.l10n.simulate_offline_mode, style: context.bodyLarge),
                        subtitle: Text(
                          context.l10n.simulate_offline_mode_description,
                          style: context.bodySmall?.copyWith(color: context.colors.cardSubTitle),
                        ),
                        value: isOfflineSimulated,
                        onChanged: ref.read(simulateOfflineProvider.notifier).setSimulateOffline,
                      ),
                    ],
                  ],
                ),
              ),
              const SpacerH24(),
              BaseCardWidget(
                padding: EdgeInsets.zero,
                child: SettingListTileItemWidget(
                  icon: Icons.logout_rounded,
                  title: context.l10n.logout,
                  color: context.colors.error,
                  onTap: () => _logout(context, ref),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectLanguage(BuildContext context, WidgetRef ref, LanguageEnum? current) async {
    final notifier = ref.read(appSettingsProvider.notifier);
    await OptionsBaseSheet.show<void>(
      context: context,
      title: context.l10n.language,
      options: [
        BaseSheetOption.selectedChoice(
          text: context.l10n.system_default,
          selected: current == null,
          onTap: (sheetContext) {
            notifier.changeLanguage(null);
            Navigator.of(sheetContext).pop();
          },
        ),
        for (final language in LanguageEnum.values)
          BaseSheetOption.selectedChoice(
            text: language.translate,
            selected: current == language,
            onTap: (sheetContext) {
              notifier.changeLanguage(language);
              Navigator.of(sheetContext).pop();
            },
          ),
      ],
    );
  }

  Future<void> _selectThemeMode(BuildContext context, WidgetRef ref, ThemeMode current) async {
    final notifier = ref.read(appSettingsProvider.notifier);
    await OptionsBaseSheet.show<void>(
      context: context,
      title: context.l10n.theme,
      options: [
        for (final themeMode in ThemeMode.values)
          BaseSheetOption.selectedChoice(
            text: _themeModeLabel(context, themeMode),
            selected: current == themeMode,
            onTap: (sheetContext) {
              notifier.changeThemeMode(themeMode);
              Navigator.of(sheetContext).pop();
            },
          ),
      ],
    );
  }

  String _themeModeLabel(BuildContext context, ThemeMode themeMode) => switch (themeMode) {
        ThemeMode.system => context.l10n.system_default,
        ThemeMode.light => context.l10n.light,
        ThemeMode.dark => context.l10n.dark,
      };

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final bool confirmed = await LogoutConfirmationDialog.show(context: context);
    if (!confirmed) return;
    // `App` listens to the auth state and routes back to sign-in.
    final Failure? failure = await ref.read(authProvider.notifier).logout();
    if (failure != null && mounted) handleError(failure: failure);
  }
}
