import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF6366F1); // Modern Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4338CA);

  static const Color accent = Color(0xFF10B981); // Emerald Green
  static const Color premium = Color(0xFFF59E0B); // Amber

  // Background & Surface - Light
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurface = Colors.white;
  static const Color lightCard = Colors.white;

  // Background & Surface - Dark
  static const Color darkBg = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF1E293B);

  // Text Colors
  static const Color textBlack = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF64748B);
  static const Color textWhite = Color(0xFFF8FAFC);
  static const Color textWhite70 = Color(0xB3F8FAFC);

  // Borders & Dividers
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF334155);

  // Status Colors
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
}

class AdIds {
  static const String banner = 'ca-app-pub-7607398523452249/4728096303';
  static const String interstitial = 'ca-app-pub-7607398523452249/8236096479';
  static const String native = 'ca-app-pub-7607398523452249/3777976717';
  static const String appOpen = 'ca-app-pub-7607398523452249/2305769488';
  static const String rewarded = 'ca-app-pub-7607398523452249/3776548036';
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
