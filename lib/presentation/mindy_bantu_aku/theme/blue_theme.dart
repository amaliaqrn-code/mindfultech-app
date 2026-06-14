import 'package:flutter/material.dart';

/// Blue Theme Colors for Choose Energy Screen - Medium Energy
class BlueTheme {
  // Primary Blue Colors
  static const Color primaryBlue = Color(0xFF7BBEFF);
  static const Color primaryBlueDark = Color(0xFF4597E6);
  static const Color primaryNavy = Color(0xFF2859C5);
  static const Color primaryBlueLight = Color(0xFF83DFC6);
  static const Color primaryBluePale = Color(0xFFE8F1FE);
  static const Color primaryBlueFaded = Color(0xFFEDF4FF);

  // Accent Colors
  static const Color cyanAccent = Color(0xFF83DFC6);
  static const Color cyanAccentLight = Color(0xFFE8F8F2);

  // Background Colors
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundCream = Color(0xFFF5F8FF);
  static const Color backgroundPage = Color(0xFFF0F5FC);

  // Text Colors
  static const Color textDark = Color(0xFF2C2C2C);
  static const Color textMedium = Color(0xFF4A4A4A);
  static const Color textGrey = Color(0xFF655F5F);
  static const Color textLightGrey = Color(0xFF8A8A8A);
  static const Color textMuted = Color(0xFFB5B5B5);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color warning = Color(0xFFFFB74D);
  static const Color warningLight = Color(0xFFFFF3E0);

  // Border & Shadow
  static const Color borderLight = Color(0xFFD0E3FF);
  static const Color borderMedium = Color(0xFFA5C7F0);
  static const Color shadowColor = Color(0x1A4597E6);

  // Gradient for buttons
  static const LinearGradient primaryButtonGradient = LinearGradient(
    colors: [primaryBlueDark,primaryBlue,primaryBlueLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient solidBlueGradient = LinearGradient(
    colors: [primaryBlueDark, primaryBlueDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [cyanAccentLight, backgroundWhite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Category Colors (Blue Theme)
  static const Map<String, Color> categoryColors = {
    'pekerjaan': Color(0xFFE3F2FD),
    'belajar': Color(0xFFE8F5E9),
    'kesehatan': Color(0xFFFFF3E0),
    'kreativitas': Color(0xFFF3E5F5),
    'hubungan': Color(0xFFFCE4EC),
    'kesehatanMental': Color(0xFFE0F7FA),
  };

  static const Map<String, Color> categoryIconColors = {
    'pekerjaan': Color(0xFF4597E6),
    'belajar': Color(0xFF4CAF50),
    'kesehatan': Color(0xFFFF9800),
    'kreativitas': Color(0xFF9C27B0),
    'hubungan': Color(0xFFE91E63),
    'kesehatanMental': Color(0xFF00BCD4),
  };
}
