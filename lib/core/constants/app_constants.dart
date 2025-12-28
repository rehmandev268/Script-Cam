import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryVariant = Color(0xFF4338CA);
  static const Color accent = Color(0xFFE11D48);
  static const Color premium = Color(0xFFF59E0B);

  static const Color lightBg = Color(0xFFF9FAFB);
  static const Color lightSurface = Colors.white;
  static const Color darkBg = Color(0xFF111827);
  static const Color darkSurface = Color(0xFF1F2937);

  static const Color textBlack = Color(0xFF111827);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color textWhite = Color(0xFFF9FAFB);
  static const Color textWhite70 = Color(0xB3F9FAFB);

  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF374151);
}

class AdIds {
  static const String banner = 'ca-app-pub-3940256099942544/6300978111';
  static const String interstitial = 'ca-app-pub-3940256099942544/1033173712';
  static const String native = 'ca-app-pub-3940256099942544/2247696110';
  static const String appOpen = 'ca-app-pub-3940256099942544/3419835294';
  static const String rewarded = 'ca-app-pub-3940256099942544/5224354917';
  static const String privacyPolicyUrl = 'https://www.google.com';
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

final List<Map<String, dynamic>> kFilters = [
  {"name": "Normal", "matrix": null},
  {
    "name": "Sepia",
    "matrix": [
      0.393,
      0.769,
      0.189,
      0.0,
      0.0,
      0.349,
      0.686,
      0.168,
      0.0,
      0.0,
      0.272,
      0.534,
      0.131,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
    ],
  },
  {
    "name": "Greyscale",
    "matrix": [
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
    ],
  },
];
