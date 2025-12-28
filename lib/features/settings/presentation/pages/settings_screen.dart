import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../widgets/common/adaptive_app_bar.dart'; // Custom App Bar
import '../../../../widgets/ads/native_ad_widget.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../premium/presentation/screen/premium_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // --- Logic Helpers ---
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $urlString");
    }
  }

  Future<void> _contactSupport() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@cineprompt.com',
      query: 'subject=App Support&body=Describe your issue here...',
    );
    _launchUrl(emailLaunchUri.toString());
  }

  void _shareApp() {
    Share.share('Check out this amazing Teleprompter app! [Link]');
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20.r,
                offset: Offset(0, 5.h),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
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
              _buildThemeOption(
                context,
                provider,
                "System Default",
                Icons.smartphone,
                ThemeMode.system,
              ),
              _buildThemeOption(
                context,
                provider,
                "Light Mode",
                Icons.light_mode,
                ThemeMode.light,
              ),
              _buildThemeOption(
                context,
                provider,
                "Dark Mode",
                Icons.dark_mode,
                ThemeMode.dark,
              ),
              SizedBox(height: 25.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    ThemeProvider provider,
    String title,
    IconData icon,
    ThemeMode mode,
  ) {
    final isSelected = provider.themeMode == mode;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.primary : Colors.grey,
          size: 24.sp,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: AppColors.primary, size: 24.sp)
          : null,
      onTap: () {
        provider.setThemeMode(mode);
        Navigator.pop(context);
      },
    );
  }

  // --- UI Build ---
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

      // NEW: Adaptive App Bar added here
      appBar: const AdaptiveAppBar(
        title: "Settings",
        showBackButton: false, // Main Tab, so no back button
      ),

      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 100.h),
                child: Column(
                  children: [
                    // 1. PREMIUM BANNER
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
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 15.r,
                                  offset: Offset(0, 5.h),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.r),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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

                    // 2. AD WIDGET
                    if (!premiumProvider.isPremium) ...[
                      CustomNativeAdWidget(
                        key: ValueKey("SettingsAd_$isDark"),
                        factoryId: 'adFactorySettings',
                        height: 64.h,
                        isGlass: true,
                      ),
                      SizedBox(height: 24.h),
                    ],

                    // 3. GENERAL
                    _buildSectionHeader("Preferences", isDark),
                    _buildSettingsGroup(
                      isDark: isDark,
                      children: [
                        _buildTile(
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

                    // 4. SUPPORT
                    _buildSectionHeader("Support", isDark),
                    _buildSettingsGroup(
                      isDark: isDark,
                      children: [
                        _buildTile(
                          icon: Icons.share_outlined,
                          title: "Share App",
                          color: Colors.blueAccent,
                          onTap: _shareApp,
                          isDark: isDark,
                        ),
                        _buildDivider(isDark),
                        _buildTile(
                          icon: Icons.mail_outline,
                          title: "Contact Us",
                          color: Colors.tealAccent,
                          onTap: _contactSupport,
                          isDark: isDark,
                        ),
                        _buildDivider(isDark),
                        _buildTile(
                          icon: Icons.star_outline_rounded,
                          title: "Rate Us",
                          color: Colors.amber,
                          onTap: () => _launchUrl(
                            'market://details?id=com.example.cineprompt',
                          ),
                          isDark: isDark,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // 5. INFO
                    _buildSectionHeader("About", isDark),
                    _buildSettingsGroup(
                      isDark: isDark,
                      children: [
                        _buildTile(
                          icon: Icons.lock_outline_rounded,
                          title: "Privacy Policy",
                          color: Colors.greenAccent,
                          onTap: () => _launchUrl(
                            AdIds.privacyPolicyUrl,
                          ), // Uses URL from Constants
                          isDark: isDark,
                        ),
                        _buildDivider(isDark),
                        _buildTile(
                          icon: Icons.info_outline_rounded,
                          title: "Version",
                          value: "1.0.0",
                          color: Colors.grey,
                          onTap: null,
                          isDark: isDark,
                        ),
                      ],
                    ),

                    SizedBox(height: 40.h),
                    Text(
                      "Made with ❤️ for Creators",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isDark ? Colors.white30 : Colors.grey.shade400,
                        fontWeight: FontWeight.w500,
                      ),
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

  // --- WIDGET BUILDERS ---

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.manrope(
            fontSize: 11.sp,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white54 : Colors.grey.shade600,
            letterSpacing: 1.0.w,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsGroup({
    required List<Widget> children,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
            blurRadius: 10.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    String? value,
    required Color color,
    required VoidCallback? onTap,
    required bool isDark,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, size: 20.sp, color: color),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              if (value != null)
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white54 : Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (onTap != null) ...[
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14.sp,
                  color: isDark ? Colors.white24 : Colors.grey.shade300,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1.h,
      thickness: 1.h,
      color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade100,
      indent: 56.w,
    );
  }
}
