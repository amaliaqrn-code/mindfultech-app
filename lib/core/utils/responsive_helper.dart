/// Responsive helpers for Samsung A06 (720x1600) optimization
library;
import 'package:flutter/material.dart';

class AppResponsive {
  /// Get responsive height based on screen height percentage
  static double h(BuildContext context, double percent) {
    return MediaQuery.of(context).size.height * (percent / 100);
  }

  /// Get responsive width based on screen width percentage
  static double w(BuildContext context, double percent) {
    return MediaQuery.of(context).size.width * (percent / 100);
  }

  /// Get responsive font size (scaled for A06)
  static double fs(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Base reference is 375 (iPhone SE width), scale proportionally
    return baseSize * (screenWidth / 375);
  }

  /// Check if screen is small/large based on height
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.height < 700;
  }

  /// Get responsive padding
  static EdgeInsets responsivePadding(BuildContext context) {
    final isSmall = isSmallScreen(context);
    return EdgeInsets.symmetric(
      horizontal: isSmall ? 16 : 20,
      vertical: isSmall ? 12 : 16,
    );
  }

  /// Get responsive icon size
  static double iconSize(BuildContext context, {double base = 24}) {
    final screenWidth = MediaQuery.of(context).size.width;
    return base * (screenWidth / 375);
  }

  /// Get responsive button height
  static double buttonHeight(BuildContext context, {double base = 52}) {
    final screenHeight = MediaQuery.of(context).size.height;
    return base * (screenHeight / 812); // 812 is iPhone X height
  }
}