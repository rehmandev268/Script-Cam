import '../widgets/settings/settings_tile.dart';
import '../widgets/settings/settings_group.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';

import '../../../../core/theme/theme_provider.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../../widgets/common/adaptive_app_bar.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../premium/presentation/screen/premium_details_screen.dart';
import '../../../premium/presentation/screen/premium_screen.dart';
import 'language_settings_screen.dart';
import 'how_to_use_screen.dart';
import '../widgets/settings/theme_option.dart';
import '../widgets/settings/section_header.dart';
import '../widgets/settings/settings_divider.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../../features/settings/presentation/providers/ui_provider.dart';
import '../../../teleprompter/presentation/widgets/prompter_overlay.dart';
import 'package:flutter_application_6/features/settings/presentation/providers/backup_provider.dart';
import 'package:flutter_application_6/features/gallery/presentation/providers/gallery_provider.dart';
import 'package:flutter_application_6/features/scripts/presentation/providers/scripts_provider.dart';

class SettingsScreen extends StatefulWidget {
  final double bottomPadding;
  const SettingsScreen({super.key, this.bottomPadding = 100});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _appVersion = "...";

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _appVersion = packageInfo.version;
      });
    }
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $urlString");
    }
  }

  Future<void> _contactSupport(AppLocalizations l10n) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'primexiastudios.contact@gmail.com',
      query: 'subject=${l10n.supportSubject}&body=${l10n.supportBody}',
    );
    AnalyticsService().logFeedbackSubmitted(feedbackType: 'support');
    _launchUrl(emailLaunchUri.toString());
  }

  void _shareApp(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const String packageName = 'com.primeaxius.scriptcam';
    const String playStoreUrl =
        'https://play.google.com/store/apps/details?id=$packageName';

    final String message = l10n.shareAppMessage(playStoreUrl);

    AnalyticsService().logShareApp(shareMethod: 'system_share');
    // ignore: deprecated_member_use
    Share.share(message, subject: l10n.shareAppSubject);
  }

  void _showThemePicker(BuildContext context, ThemeProvider provider) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                l10n.appearance,
                style: GoogleFonts.manrope(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              SizedBox(height: 15.h),
              ThemeOption(
                provider: provider,
                title: l10n.systemDefault,
                icon: Icons.smartphone,
                mode: ThemeMode.system,
              ),
              ThemeOption(
                provider: provider,
                title: l10n.lightMode,
                icon: Icons.light_mode,
                mode: ThemeMode.light,
              ),
              ThemeOption(
                provider: provider,
                title: l10n.darkMode,
                icon: Icons.dark_mode,
                mode: ThemeMode.dark,
              ),
              SizedBox(height: 25.h),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final premiumProvider = Provider.of<PremiumProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final l10n = AppLocalizations.of(context);

    String themeText = l10n.system;
    if (themeProvider.themeMode == ThemeMode.light) themeText = l10n.light;
    if (themeProvider.themeMode == ThemeMode.dark) themeText = l10n.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AdaptiveAppBar(title: l10n.settings, showBackButton: false),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                20.w,
                12.h,
                20.w,
                widget.bottomPadding,
              ),
              child: Column(
                children: [
                  if (!premiumProvider.isPremium) ...[
                    GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PremiumScreen(),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 16.h,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkSurface
                                : AppColors.darkBg,
                            borderRadius: BorderRadius.circular(20.r),
                            border: isDark
                                ? Border.all(
                                    color: Colors.white.withValues(alpha: 0.05),
                                    width: 1,
                                  )
                                : null,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.workspace_premium_rounded,
                                  color: AppColors.primary,
                                  size: 28.sp,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.upgradeToPro,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      l10n.unlockAllFeatures,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white54,
                                size: 16.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 24.h),
                  ] else ...[
                    // Premium Active Badge
                    GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PremiumDetailsScreen(),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 16.h,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkSurface
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.workspace_premium_rounded,
                                  color: AppColors.primary,
                                  size: 28.sp,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.premiumActive,
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      l10n.managePremiumStatus,
                                      style: TextStyle(
                                        color: AppColors.textGrey,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: AppColors.textGrey,
                                size: 16.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 24.h),
                  ],

                  SectionHeader(title: 'Recording Defaults'),
                  Consumer<UIProvider>(
                    builder: (context, uiProvider, _) {
                      return SettingsGroup(
                        isDark: isDark,
                        children: [
                          SettingsTile(
                            icon: Icons.tune_rounded,
                            title: l10n.overlaySettings,
                            value: null,
                            color: AppColors.primary,
                            onTap: () => showPrompterOverlaySettingsSheet(context),
                            isDark: isDark,
                          ),
                          SettingsTile(
                            icon: uiProvider.defaultFrontCamera
                                ? Icons.camera_front_outlined
                                : Icons.camera_rear_outlined,
                            title: l10n.defaultCamera,
                            value: uiProvider.defaultFrontCamera
                                ? l10n.frontCamera
                                : l10n.backCamera,
                            color: AppColors.primary,
                            onTap: () => uiProvider.setDefaultCamera(
                              !uiProvider.defaultFrontCamera,
                            ),
                            isDark: isDark,
                          ),
                          SettingsTile(
                            icon: Icons.high_quality_outlined,
                            title: l10n.exportQuality,
                            value: uiProvider.defaultExportQuality.toUpperCase(),
                            color: AppColors.primary,
                            onTap: () {
                              final next = switch (uiProvider.defaultExportQuality) {
                                'sd' => 'hd',
                                'hd' => 'fhd',
                                'fhd' => 'uhd',
                                _ => 'sd',
                              };
                              uiProvider.setDefaultExportQuality(next);
                            },
                            isDark: isDark,
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 24.h),

                  SectionHeader(title: l10n.preferences),
                  SettingsGroup(
                    isDark: isDark,
                    children: [
                      SettingsTile(
                        icon: isDark
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined,
                        title: l10n.appearance,
                        value: themeText,
                        color: AppColors.primary,
                        onTap: () => _showThemePicker(context, themeProvider),
                        isDark: isDark,
                      ),
                      Consumer<LocaleProvider>(
                        builder: (context, localeProvider, _) {
                          final languageName = LocaleProvider.getLanguageName(
                            localeProvider.locale.languageCode,
                          );
                          return SettingsTile(
                            icon: Icons.language_outlined,
                            title: l10n.language,
                            value: languageName,
                            color: AppColors.primary,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const LanguageSettingsScreen(),
                                ),
                              );
                            },
                            isDark: isDark,
                          );
                        },
                      ),
                      SettingsDivider(isDark: isDark),
                      Consumer2<UIProvider, PremiumProvider>(
                        builder: (context, uiProvider, premium, _) {
                          return SettingsTile(
                            icon: Icons.mic_external_on_outlined,
                            title: l10n.voiceSync,
                            color: AppColors.primary,
                            trailing: premium.isPremium
                                ? Switch.adaptive(
                                    value: uiProvider.voiceSyncEnabled,
                                    activeThumbColor: AppColors.primary,
                                    onChanged: (value) {
                                      uiProvider.toggleVoiceSync(value);
                                    },
                                  )
                                : Icon(
                                    Icons.lock_rounded,
                                    size: 18.sp,
                                    color: AppColors.textGrey,
                                  ),
                            onTap: premium.isPremium
                                ? () => uiProvider.toggleVoiceSync(
                                    !uiProvider.voiceSyncEnabled,
                                  )
                                : () {
                                    ToastService.show(l10n.voiceSyncLocked);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const PremiumScreen(),
                                      ),
                                    );
                                  },
                            isDark: isDark,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  SectionHeader(title: l10n.cloudBackup),
                  Consumer3<BackupProvider, ScriptsProvider, GalleryProvider>(
                    builder: (context, backup, scripts, gallery, _) {
                      final uiProvider = Provider.of<UIProvider>(context);
                      final user = backup.authService.currentUser;
                      final isSignedIn = user != null;

                      // Display error if present
                      if (backup.error != null && !backup.isAuthLoading) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          final error = _resolveBackupError(
                            l10n,
                            backup.error!,
                          );
                          ToastService.show(error, isError: true);
                        });
                      }

                      return SettingsGroup(
                        isDark: isDark,
                        children: [
                          if (!isSignedIn)
                            SettingsTile(
                              icon: Icons.cloud_outlined,
                              title: l10n.connectGoogleDrive,
                              color: AppColors.primary,
                              trailing: backup.isAuthLoading
                                  ? SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : null,
                              onTap: backup.isAuthLoading
                                  ? null
                                  : () => backup.signIn(uiProvider),
                              isDark: isDark,
                            )
                          else ...[
                            ListTile(
                              leading: Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: user.photoUrl != null
                                        ? NetworkImage(user.photoUrl!)
                                        : null,
                                    child: user.photoUrl == null
                                        ? const Icon(Icons.person)
                                        : null,
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(2.r),
                                      decoration: const BoxDecoration(
                                      color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: 10.r,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      user.displayName ?? l10n.googleUser,
                                      style: GoogleFonts.manrope(
                                        fontWeight: FontWeight.bold,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.3,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      l10n.connected,
                                      style: GoogleFonts.manrope(
                                        fontSize: 10.sp,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                user.email,
                                style: GoogleFonts.manrope(
                                  fontSize: 12.sp,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    onPressed: backup.isAuthLoading
                                        ? null
                                        : () async {
                                            await backup.signOut(uiProvider);
                                            await backup.signIn(uiProvider);
                                          },
                                    icon: Icon(
                                      Icons.switch_account_outlined,
                                      size: 16.sp,
                                    ),
                                    label: Text(
                                      l10n.switchAccount,
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  TextButton.icon(
                                    onPressed: backup.isAuthLoading
                                        ? null
                                        : () => backup.signOut(uiProvider),
                                    icon: Icon(
                                      Icons.logout_rounded,
                                      size: 16.sp,
                                      color: AppColors.error,
                                    ),
                                    label: Text(
                                      l10n.disconnect,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.error,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SettingsDivider(isDark: isDark),
                            SettingsTile(
                              icon: Icons.backup_outlined,
                              title: l10n.backupNow,
                              value: uiProvider.lastBackupTime.isEmpty
                                  ? l10n.never
                                  : uiProvider.lastBackupTime.split('T')[0],
                              color: AppColors.primary,
                              trailing: backup.isBackupInProgress
                                  ? SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        value: backup.backupProgress > 0
                                            ? backup.backupProgress
                                            : null,
                                      ),
                                    )
                                  : null,
                              onTap: backup.isBackupInProgress
                                  ? null
                                  : () => backup.backupNow(
                                      scripts,
                                      gallery,
                                      uiProvider,
                                    ),
                              isDark: isDark,
                            ),
                            SettingsTile(
                              icon: Icons.restore_outlined,
                              title: l10n.restore,
                              value: uiProvider.lastRestoreTime.isEmpty
                                  ? l10n.never
                                  : uiProvider.lastRestoreTime.split('T')[0],
                              color: AppColors.primary,
                              trailing: backup.isRestoreInProgress
                                  ? SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : null,
                              onTap: backup.isRestoreInProgress
                                  ? null
                                  : () => backup.restoreNow(
                                      scripts,
                                      gallery,
                                      uiProvider,
                                    ),
                              isDark: isDark,
                            ),
                            SettingsDivider(isDark: isDark),
                            SettingsTile(
                              icon: Icons.sync_outlined,
                              title: l10n.autoBackup,
                              color: AppColors.primary,
                              onTap: () => uiProvider.setAutoBackup(
                                !uiProvider.autoBackupEnabled,
                              ),
                              trailing: Switch.adaptive(
                                value: uiProvider.autoBackupEnabled,
                                activeThumbColor: AppColors.primary,
                                onChanged: (value) =>
                                    uiProvider.setAutoBackup(value),
                              ),
                              isDark: isDark,
                            ),
                            SettingsTile(
                              icon: Icons.video_library_outlined,
                              title: l10n.backupVideos,
                              color: AppColors.primary,
                              onTap: () => uiProvider.setBackupVideos(
                                !uiProvider.backupVideosEnabled,
                              ),
                              trailing: Switch.adaptive(
                                value: uiProvider.backupVideosEnabled,
                                activeThumbColor: AppColors.primary,
                                onChanged: (value) =>
                                    uiProvider.setBackupVideos(value),
                              ),
                              isDark: isDark,
                            ),
                            if (uiProvider.backupVideosEnabled)
                              SettingsTile(
                                icon: Icons.wifi_outlined,
                                title: l10n.wifiOnly,
                                color: AppColors.primary,
                                onTap: () => uiProvider.setWifiOnlyBackup(
                                  !uiProvider.wifiOnlyBackup,
                                ),
                                trailing: Switch.adaptive(
                                  value: uiProvider.wifiOnlyBackup,
                                  activeThumbColor: AppColors.primary,
                                  onChanged: (value) =>
                                      uiProvider.setWifiOnlyBackup(value),
                                ),
                                isDark: isDark,
                              ),
                          ],
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 24.h),

                  SectionHeader(title: l10n.help),
                  SettingsGroup(
                    isDark: isDark,
                    children: [
                      SettingsTile(
                        icon: Icons.help_outline_rounded,
                        title: l10n.howToUse,
                        color: AppColors.primary,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HowToUseScreen(),
                          ),
                        ),
                        isDark: isDark,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  SectionHeader(title: l10n.support),
                  SettingsGroup(
                    isDark: isDark,
                    children: [
                      SettingsTile(
                        icon: Icons.share_outlined,
                        title: l10n.shareApp,
                        color: AppColors.primary,
                        onTap: () => _shareApp(context),
                        isDark: isDark,
                      ),
                      SettingsDivider(isDark: isDark),
                      SettingsTile(
                        icon: Icons.mail_outline,
                        title: l10n.contactUs,
                        color: AppColors.primary,
                        onTap: () => _contactSupport(l10n),
                        isDark: isDark,
                      ),
                      SettingsDivider(isDark: isDark),
                      SettingsTile(
                        icon: Icons.star_outline_rounded,
                        title: l10n.rateUs,
                        color: AppColors.primary,
                        onTap: () {
                          AnalyticsService().logAppRated(
                            rating: 5,
                          ); // Default to logging rating intent
                          _launchUrl(
                            'https://play.google.com/store/apps/details?id=com.primeaxius.scriptcam',
                          );
                        },
                        isDark: isDark,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  SectionHeader(title: l10n.about),
                  SettingsGroup(
                    isDark: isDark,
                    children: [
                      SettingsTile(
                        icon: Icons.lock_outline_rounded,
                        title: l10n.privacyPolicy,
                        color: AppColors.primary,
                        onTap: () {
                          AnalyticsService().logPrivacyPolicyViewed();
                          _launchUrl(AdIds.privacyPolicyUrl);
                        },
                        isDark: isDark,
                      ),
                      SettingsDivider(isDark: isDark),
                      SettingsTile(
                        icon: Icons.info_outline_rounded,
                        title: l10n.version,
                        value: _appVersion,
                        color: Colors.grey,
                        onTap: null,
                        isDark: isDark,
                      ),
                    ],
                  ),
                ],
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _resolveBackupError(AppLocalizations l10n, String error) {
    if (error == 'signInCancelled') return l10n.signInCancelled;
    if (error == 'Not authenticated') return l10n.notAuthenticated;
    return l10n.backupFailedDetail(error);
  }
}
