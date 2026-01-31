import 'package:flutter/material.dart';

class ResponsiveLayout {
  static const double _designWidth = 395;
  static const double _designHeight = 855;

  static double _screenWidth = _designWidth;
  static double _screenHeight = _designHeight;

  static void init(BuildContext context) {
    try {
      final mediaQuery = MediaQuery.of(context);
      _screenWidth = mediaQuery.size.width;
      _screenHeight = mediaQuery.size.height;
    } catch (_) {
      // Fallback if MediaQuery is not available yet
    }
  }

  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;

  static double get scaleWidth => _screenWidth / _designWidth;
  static double get scaleHeight => _screenHeight / _designHeight;
}

extension SizeExtension on num {
  double get w => this * ResponsiveLayout.scaleWidth;

  double get h => this * ResponsiveLayout.scaleHeight;

  double get sp => this * ResponsiveLayout.scaleWidth;

  double get r => this * ResponsiveLayout.scaleWidth;
}

extension EdgeInsetsExtension on EdgeInsets {
  EdgeInsets get r => EdgeInsets.fromLTRB(
    left * ResponsiveLayout.scaleWidth,
    top * ResponsiveLayout.scaleWidth,
    right * ResponsiveLayout.scaleWidth,
    bottom * ResponsiveLayout.scaleWidth,
  );
}

extension BorderRadiusExtension on BorderRadius {
  BorderRadius get r => copyWith(
    topLeft: topLeft * ResponsiveLayout.scaleWidth,
    topRight: topRight * ResponsiveLayout.scaleWidth,
    bottomLeft: bottomLeft * ResponsiveLayout.scaleWidth,
    bottomRight: bottomRight * ResponsiveLayout.scaleWidth,
  );
}

extension RadiusExtension on Radius {
  Radius get r => Radius.circular(x * ResponsiveLayout.scaleWidth);
}

extension BoxConstraintsExtension on BoxConstraints {
  BoxConstraints get r => copyWith(
    minWidth: minWidth * ResponsiveLayout.scaleWidth,
    maxWidth: maxWidth * ResponsiveLayout.scaleWidth,
    minHeight: minHeight * ResponsiveLayout.scaleWidth,
    maxHeight: maxHeight * ResponsiveLayout.scaleWidth,
  );
}
