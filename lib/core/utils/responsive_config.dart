import 'package:flutter/material.dart';

class ResponsiveLayout {
  static late double screenWidth;
  static late double screenHeight;

  static const double _designWidth = 395;
  static const double _designHeight = 855;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
  }

  static double get scaleWidth => screenWidth / _designWidth;
  static double get scaleHeight => screenHeight / _designHeight;
}

extension SizeExtension on num {
  double get w => this * ResponsiveLayout.scaleWidth;

  double get h => this * ResponsiveLayout.scaleHeight;

  double get sp => this * ResponsiveLayout.scaleWidth;

  double get r => this * ResponsiveLayout.scaleWidth;
}
