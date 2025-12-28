import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'dart:ui';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../widgets/ads/native_ad_widget.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../scripts/presentation/providers/scripts_provider.dart';
import '../../../settings/presentation/providers/ui_provider.dart';

import '../../../scripts/presentation/pages/home_screen.dart';
import '../../../scripts/presentation/pages/editor_screen.dart';
import '../../../gallery/presentation/pages/gallery_screen.dart';
import '../../../settings/presentation/pages/settings_screen.dart';

class RootNavigationScreen extends StatefulWidget {
  const RootNavigationScreen({super.key});
  @override
  State<RootNavigationScreen> createState() => _RootNavigationScreenState();
}

class _RootNavigationScreenState extends State<RootNavigationScreen> {
  int _index = 0;
  final GlobalKey _galleryKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<UIProvider>(context, listen: false);
      if (!provider.showcaseSeen) {
        ShowcaseView.get().startShowCase([_galleryKey]);
        provider.completeShowcase();
      }
    });
  }

  void _switchTab(int index) {
    if (_index == index) return;

    HapticFeedback.mediumImpact();

    if (_index == 0 && index != 0) {
      Provider.of<ScriptsProvider>(context, listen: false).setSearchQuery("");
    }
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
    final premiumProvider = Provider.of<PremiumProvider>(context);
    final uiProvider = Provider.of<UIProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bool showAd = !premiumProvider.isPremium && uiProvider.showcaseSeen;

    // Calculate reliable padding so content is never hidden behind the nav bar or ad
    double navBarHeight = 80.h;
    double adHeight = showAd ? 60.h : 0;
    double safeAreaBottom = MediaQuery.of(context).padding.bottom;
    double contentBottomPadding =
        navBarHeight + adHeight + safeAreaBottom + 20.h;

    final List<Widget> screens = [
      HomeScreen(onGoToCreate: _openEditor),
      GalleryScreen(onGoToStudio: () => _switchTab(0)),
      const SettingsScreen(),
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      extendBody: true,
      body: Stack(
        children: [
          // Main Content
          Padding(
            padding: EdgeInsets.only(
              bottom: 0,
            ), // Handle padding inside screens or use contentBottomPadding if needed
            child: IndexedStack(
              index: _index,
              children: screens.map((screen) {
                // Wrap each screen to ensure it has bottom padding for the floating bar
                return Padding(
                  padding: EdgeInsets.only(bottom: contentBottomPadding),
                  child: screen,
                );
              }).toList(),
            ),
          ),

          // Floating Navigation Bar & Ad
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // The Floating "Island" Navigation Bar
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.5 : 0.1),
                        blurRadius: 30,
                        spreadRadius: 0,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 8.w,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.darkSurface.withOpacity(0.7)
                              : Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withOpacity(0.1)
                                : Colors.white.withOpacity(0.6),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildNavItem(
                              Icons.dashboard_rounded,
                              "Studio",
                              0,
                              isDark,
                            ),

                            Showcase(
                              key: _galleryKey,
                              title: 'Gallery',
                              description: 'View recorded videos',
                              targetShapeBorder: const CircleBorder(),
                              child: _buildNavItem(
                                Icons.video_library_rounded,
                                "Gallery",
                                1,
                                isDark,
                              ),
                            ),

                            _buildNavItem(
                              Icons.settings_rounded,
                              "Settings",
                              2,
                              isDark,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Adaptive Banner Ad Area
                if (showAd) ...[
                  SizedBox(height: 12.h),
                  Container(
                    color: Colors.transparent,
                    child: const AdaptiveBannerWidget(),
                  ),
                  SizedBox(height: safeAreaBottom > 0 ? safeAreaBottom : 10.h),
                ] else ...[
                  SizedBox(height: safeAreaBottom + 20.h),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, bool isDark) {
    final isSelected = _index == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _switchTab(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: isSelected
              ? BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryVariant],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                )
              : BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(24.r),
                ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? Colors.white
                    : (isDark ? Colors.white54 : Colors.grey.shade500),
                size: 22.sp,
              ),
              if (isSelected) ...[
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
