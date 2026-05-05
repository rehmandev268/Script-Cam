import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color primaryDark = Color(0xFF1D4ED8);

  static const Color record = primary;
  static const Color accent = record;
  static const Color premium = primary;

  // Background & Surface - Light
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurface = Colors.white;
  static const Color lightCard = Colors.white;

  // Background & Surface - Dark
  static const Color darkBg = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1B1B1D);
  static const Color darkSurface2 = Color(0xFF242428);
  static const Color darkCard = Color(0xFF1B1B1D);

  // Text Colors
  static const Color textBlack = Color(0xFF1F2937);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color textWhite = Color(0xFFF3F4F6);
  static const Color textWhite70 = Color(0xB3F3F4F6);

  // Borders & Dividers
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF2F2F34);

  // Status Colors
  static const Color error = Color(0xFFEF4444);
  static const Color success = record;
  static const Color warning = Color(0xFFF97316);
}

class AdIds {
  // Real Ad IDs (only rewarded + interstitial are active)
  static const String _interstitialReal =
      'ca-app-pub-7607398523452249/8236096479';
  static const String _rewardedReal = 'ca-app-pub-7607398523452249/4550583396';

  // Test Ad IDs
  static const String _interstitialTest =
      'ca-app-pub-3940256099942544/1033173712';
  static const String _rewardedTest = 'ca-app-pub-3940256099942544/5224354917';

  static String get interstitial =>
      kDebugMode ? _interstitialTest : _interstitialReal;
  static String get rewarded => kDebugMode ? _rewardedTest : _rewardedReal;

  static const String privacyPolicyUrl =
      'https://sites.google.com/view/primexia-studios/home';
}

class HiveKeys {
  static const String scriptsBox = 'cineprompt_scripts_box_final';
  static const String videosBox = 'cineprompt_videos_box_final';
  static const String settingsBox = 'cineprompt_settings_box';
}

class IAPConstants {
  static const String premiumProductId = 'premium_unlock';
  static const Set<String> kIds = <String>{
    premiumProductId,
    'android.test.purchased',
  };
}
