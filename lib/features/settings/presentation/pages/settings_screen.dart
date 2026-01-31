import '../widgets/settings/settings_tile.dart';
import '../widgets/settings/settings_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../widgets/ads/custom_native_ad_widget.dart';
import '../../../../widgets/common/adaptive_app_bar.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../premium/presentation/screen/premium_screen.dart';
import 'how_to_use_screen.dart';
import '../widgets/settings/theme_option.dart';
import '../widgets/settings/section_header.dart';
import '../../../../core/services/analytics_service.dart';

import '../widgets/settings/settings_divider.dart';

class SettingsScreen extends StatelessWidget {
  final double bottomPadding;
  const SettingsScreen({super.key, this.bottomPadding = 100});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $urlString");
    }
  }

  Future<void> _contactSupport() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'primexiastudios.contact@gmail.com',
      query: 'subject=App Support&body=Describe your issue here...',
    );
    AnalyticsService().logFeedbackSubmitted(feedbackType: 'support');
    _launchUrl(emailLaunchUri.toString());
  }

  void _shareApp() {
    const String packageName = 'com.primeaxius.scriptcam';
    const String playStoreUrl =
        'https://play.google.com/store/apps/details?id=$packageName';

    const String message =
        'Record professional videos with confidence using ScriptCam! 🎥✨\n\n'
        'It features a built-in Teleprompter, 4K recording, and Video Editor. '
        'Try it out here:\n$playStoreUrl';

    AnalyticsService().logShareApp(shareMethod: 'system_share');
    Share.share(message, subject: 'Check out ScriptCam: Video Teleprompter');
  }

  void _showThemePicker(BuildContext context, ThemeProvider provider) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
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
                "Appearance",
                style: GoogleFonts.manrope(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              SizedBox(height: 15.h),
              ThemeOption(
                provider: provider,
                title: "System Default",
                icon: Icons.smartphone,
                mode: ThemeMode.system,
              ),
              ThemeOption(
                provider: provider,
                title: "Light Mode",
                icon: Icons.light_mode,
                mode: ThemeMode.light,
              ),
              ThemeOption(
                provider: provider,
                title: "Dark Mode",
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

    String themeText = "System";
    if (themeProvider.themeMode == ThemeMode.light) themeText = "Light";
    if (themeProvider.themeMode == ThemeMode.dark) themeText = "Dark";

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: const AdaptiveAppBar(title: "Settings", showBackButton: false),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, bottomPadding),
              child: Column(
                children: [
                  if (!premiumProvider.isPremium) ...[
                    FadeInDown(
                      duration: const Duration(milliseconds: 400),
                      child: GestureDetector(
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
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2C3E50), Color(0xFF000000)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20.r),
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
                                  color: const Color(0xFFFFD700),
                                  size: 28.sp,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Upgrade to Pro",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "Unlock all features & remove ads",
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
                    ),
                    SizedBox(height: 24.h),
                  ],

                  if (!premiumProvider.isPremium) ...[
                    Container(
                      decoration: _groupDecoration(isDark),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: CustomNativeAdWidget(
                          key: ValueKey("SettingsAd_$isDark"),
                          factoryId: 'adFactorySettings',
                          height: 72.h,
                          isGlass: false,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],

                  SectionHeader(title: "Preferences"),
                  SettingsGroup(
                    isDark: isDark,
                    children: [
                      SettingsTile(
                        icon: isDark
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined,
                        title: "Appearance",
                        value: themeText,
                        color: Colors.purpleAccent,
                        onTap: () => _showThemePicker(context, themeProvider),
                        isDark: isDark,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  SectionHeader(title: "Help"),
                  SettingsGroup(
                    isDark: isDark,
                    children: [
                      SettingsTile(
                        icon: Icons.help_outline_rounded,
                        title: "How to Use",
                        color: Colors.orangeAccent,
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

                  SectionHeader(title: "Support"),
                  SettingsGroup(
                    isDark: isDark,
                    children: [
                      SettingsTile(
                        icon: Icons.share_outlined,
                        title: "Share App",
                        color: Colors.blueAccent,
                        onTap: _shareApp,
                        isDark: isDark,
                      ),
                      SettingsDivider(isDark: isDark),
                      SettingsTile(
                        icon: Icons.mail_outline,
                        title: "Contact Us",
                        color: Colors.tealAccent,
                        onTap: _contactSupport,
                        isDark: isDark,
                      ),
                      SettingsDivider(isDark: isDark),
                      SettingsTile(
                        icon: Icons.star_outline_rounded,
                        title: "Rate Us",
                        color: Colors.amber,
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

                  SectionHeader(title: "About"),
                  SettingsGroup(
                    isDark: isDark,
                    children: [
                      SettingsTile(
                        icon: Icons.lock_outline_rounded,
                        title: "Privacy Policy",
                        color: Colors.greenAccent,
                        onTap: () {
                          AnalyticsService().logPrivacyPolicyViewed();
                          _launchUrl(AdIds.privacyPolicyUrl);
                        },
                        isDark: isDark,
                      ),
                      SettingsDivider(isDark: isDark),
                      SettingsTile(
                        icon: Icons.info_outline_rounded,
                        title: "Version",
                        value: "1.0.2",
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
    );
  }

  BoxDecoration _groupDecoration(bool isDark) {
    return BoxDecoration(
      color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      borderRadius: BorderRadius.circular(16.r),
    );
  }
}
