import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../widgets/ads/adaptive_banner_ad.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../scripts/presentation/providers/scripts_provider.dart';

import '../../../scripts/presentation/pages/home_screen.dart';
import '../../../scripts/presentation/pages/editor_screen.dart';
import '../../../gallery/presentation/pages/gallery_screen.dart';
import '../../../settings/presentation/pages/settings_screen.dart';
import '../widgets/nav_item.dart';

class RootNavigationScreen extends StatefulWidget {
  const RootNavigationScreen({super.key});
  @override
  State<RootNavigationScreen> createState() => _RootNavigationScreenState();
}

class _RootNavigationScreenState extends State<RootNavigationScreen> {
  int _index = 0;

  void _switchTab(int index) {
    if (_index == index) return;
    HapticFeedback.lightImpact();
    setState(() => _index = index);
  }

  void _openEditor() {
    HapticFeedback.selectionClick();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditorScreen(
          onSaveSuccess: () => Provider.of<ScriptsProvider>(
            context,
            listen: false,
          ).setSearchQuery(""),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final premiumProvider = Provider.of<PremiumProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool showAd = !premiumProvider.isPremium;

    double contentBottomPadding = 20.h;

    final List<Widget> screens = [
      HomeScreen(
        onGoToCreate: _openEditor,
        bottomPadding: contentBottomPadding,
      ),
      GalleryScreen(
        onGoToStudio: () => _switchTab(0),
        bottomPadding: contentBottomPadding,
      ),
      SettingsScreen(bottomPadding: contentBottomPadding),
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      resizeToAvoidBottomInset: false,
      extendBody: false,
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
              blurRadius: 20,
              offset: const Offset(0, -8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top indicator line
            SizedBox(
              height: 3.h,
              child: Stack(
                children: [
                  // Background container
                  Container(color: Colors.transparent),
                  // Animated indicator
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    alignment: _index == 0
                        ? Alignment.centerLeft
                        : _index == 1
                        ? Alignment.center
                        : Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 3.h,
                      alignment: Alignment.center,
                      child: Container(
                        width: 80.w,
                        height: 3.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(2.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Navigation Bar
            Container(
              height: 68.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavItem(
                    icon: Icons.dashboard_rounded,
                    label: l10n.studio,
                    index: 0,
                    currentIndex: _index,
                    onTap: _switchTab,
                  ),
                  NavItem(
                    icon: Icons.video_library_rounded,
                    label: l10n.gallery,
                    index: 1,
                    currentIndex: _index,
                    onTap: _switchTab,
                  ),
                  NavItem(
                    icon: Icons.settings_rounded,
                    label: l10n.settings,
                    index: 2,
                    currentIndex: _index,
                    onTap: _switchTab,
                  ),
                ],
              ),
            ),
            // Bottom home indicator bar (iOS style)

            // Banner Ad at the absolute bottom
            if (showAd)
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.black.withValues(alpha: 0.05),
                      width: 0.5,
                    ),
                  ),
                ),
                padding: EdgeInsets.only(
                  top: 8.h,
                  bottom: MediaQuery.of(context).padding.bottom > 0
                      ? MediaQuery.of(context).padding.bottom
                      : 8.h,
                ),
                child: const Center(child: AdaptiveBannerWidget()),
              ),
            // Safe area for devices without ad
            if (!showAd)
              SizedBox(
                height: MediaQuery.of(context).padding.bottom > 0
                    ? MediaQuery.of(context).padding.bottom
                    : 8.h,
              ),
          ],
        ),
      ),
    );
  }
}
