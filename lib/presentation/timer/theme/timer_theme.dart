import 'package:flutter/material.dart';

/// Timer Page Theme - Blue Sky & Green Meadow
class TimerTheme {
  // Primary Blue Colors
  static const Color primaryBlue = Color(0xFF4597E6);
  static const Color primaryBlueDark = Color(0xFF2E7DD1);
  static const Color primaryBlueLight = Color(0xFF87BFFF);
  static const Color primaryBluePale = Color(0xFFE8F4FD);
  static const Color primaryBlueVeryPale = Color(0xFFF0F7FF);

  // Green Colors (Meadow)
  static const Color greenMeadow = Color(0xFF6A9859);
  static const Color greenMeadowLight = Color(0xFFD4E6C9);
  static const Color greenMeadowPale = Color(0xFFF5FAF5);

  // Sky Gradient Colors
  static const Color skyTop = Color(0xFF87CEEB);
  static const Color skyMiddle = Color(0xFFB0E2FF);
  static const Color skyBottom = Color(0xFFE0F4FF);
  static const Color meadowGreen = Color(0xFF90C67C);

  // Timer Circle Colors
  static const Color timerStroke = Color(0xFF4597E6);
  static const Color timerBackground = Color(0xFFE8F4FD);
  static const Color timerProgressBackground = Color(0xFFF0F7FF);

  // Card Colors
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color cardYellowLight = Color(0xFFFFF8E1);
  static const Color cardYellowBorder = Color(0xFFFFE082);
  static const Color cardRedLight = Color(0xFFFFEBEE);
  static const Color cardRedBorder = Color(0xFFEF9A9A);

  // Text Colors
  static const Color textDark = Color(0xFF2C2C2C);
  static const Color textMedium = Color(0xFF4A4A4A);
  static const Color textGrey = Color(0xFF655F5F);
  static const Color textLightGrey = Color(0xFF8A8A8A);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textBlue = Color(0xFF4597E6);

  // Warning Colors
  static const Color warningYellow = Color(0xFFFFC107);
  static const Color warningYellowLight = Color(0xFFFFF8E1);
  static const Color warningRed = Color(0xFFE53935);
  static const Color warningRedLight = Color(0xFFFFEBEE);

  // Buttons
  static const LinearGradient actionButtonGradient = LinearGradient(
    colors: [primaryBlue, greenMeadow],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient circularProgressGradient = LinearGradient(
    colors: [primaryBlue, primaryBlueDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Background Gradient (Sky)
  static const LinearGradient skyGradient = LinearGradient(
    colors: [skyTop, skyMiddle, skyBottom],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Meadow Gradient (Green grass at bottom)
  static const LinearGradient meadowGradient = LinearGradient(
    colors: [greenMeadowLight, meadowGreen],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
