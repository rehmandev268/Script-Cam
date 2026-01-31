import 'package:flutter/widgets.dart';
import '../../core/services/ads_service/app_open_ad_manager.dart';
import '../../features/premium/presentation/providers/premium_provider.dart';

import '../../features/settings/presentation/providers/ui_provider.dart';

class AppLifecycleReactor extends WidgetsBindingObserver {
  final AppOpenAdManager appOpenAdManager;
  final PremiumProvider premiumProvider;
  final UIProvider uiProvider;

  AppLifecycleReactor({
    required this.appOpenAdManager,
    required this.premiumProvider,
    required this.uiProvider,
  });

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      uiProvider.checkPermissions();
      appOpenAdManager.showAdIfAvailable(premiumProvider.isPremium);
    }
  }
}
