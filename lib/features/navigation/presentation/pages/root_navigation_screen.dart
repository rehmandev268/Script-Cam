import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';

import '../../../scripts/presentation/providers/scripts_provider.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../premium/presentation/screen/premium_screen.dart';

import '../../../scripts/presentation/pages/home_screen.dart';
import '../../../scripts/presentation/pages/editor_screen.dart';
import '../../../teleprompter/presentation/pages/camera_mode_screen.dart';
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
  Timer? _premiumTimer;

  @override
  void initState() {
    super.initState();
    _premiumTimer = Timer(const Duration(seconds: 2), _maybeShowPremium);
  }

  @override
  void dispose() {
    _premiumTimer?.cancel();
    super.dispose();
  }

  void _maybeShowPremium() {
    if (!mounted) return;
    final isPremium = context.read<PremiumProvider>().isPremium;
    if (isPremium) return;
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        pageBuilder: (_, _, _) => const PremiumScreen(),
        transitionsBuilder: (_, anim, _, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
          child: child,
        ),
      ),
    );
  }

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

    final isDark = Theme.of(context).brightness == Brightness.dark;

    double contentBottomPadding = 20.h;

    final List<Widget> screens = [
      const CameraModeScreen(),
      HomeScreen(
        onGoToCreate: _openEditor,
        bottomPadding: contentBottomPadding,
      ),
      GalleryScreen(
        onGoToStudio: () => _switchTab(1),
        bottomPadding: contentBottomPadding,
      ),
      SettingsScreen(bottomPadding: contentBottomPadding),
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : Colors.transparent,
      resizeToAvoidBottomInset: false,
      extendBody: false,
      body: DecoratedBox(
        decoration: BoxDecoration(color: isDark ? AppColors.darkBg : AppColors.lightBg),
        child: IndexedStack(index: _index, children: screens),
      ),
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
            Container(
              height: 68.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavItem(
                    icon: Icons.videocam_rounded,
                    label: l10n.tabCamera,
                    index: 0,
                    currentIndex: _index,
                    onTap: _switchTab,
                  ),
                  NavItem(
                    icon: Icons.description_outlined,
                    label: l10n.tabScripts,
                    index: 1,
                    currentIndex: _index,
                    onTap: _switchTab,
                  ),
                  NavItem(
                    icon: Icons.video_library_rounded,
                    label: l10n.tabRecordings,
                    index: 2,
                    currentIndex: _index,
                    onTap: _switchTab,
                  ),
                  NavItem(
                    icon: Icons.settings_rounded,
                    label: l10n.settings,
                    index: 3,
                    currentIndex: _index,
                    onTap: _switchTab,
                  ),
                ],
              ),
            ),
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
