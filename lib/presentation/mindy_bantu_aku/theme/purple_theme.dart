import 'package:flutter/material.dart';

/// Purple Theme Colors for High Energy
class PurpleTheme {
  // Primary Purple Colors
  static const Color primaryPurple = Color(0xFF8871C6);
  static const Color primaryPurpleDark = Color(0xFF5E4B9D);
  static const Color primaryPurpleLight = Color(0xFFB8A4E0);
  static const Color primaryPurplePale = Color(0xFFF3E5F5);
  static const Color primaryPurpleFaded = Color(0xFFEDE6F7);

  // Accent Colors
  static const Color violetAccent = Color(0xFFCE93D8);
  static const Color violetAccentLight = Color(0xFFF8E8FF);

  // Background Colors
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundCream = Color(0xFFFAF5FF);
  static const Color backgroundPage = Color(0xFFF5F0FA);

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
  static const Color borderLight = Color(0xFFE0D6F5);
  static const Color borderMedium = Color(0xFFC4B3E8);
  static const Color shadowColor = Color(0x1A8871C6);

  // Gradient for buttons
  static const LinearGradient primaryButtonGradient = LinearGradient(
    colors: [primaryPurple, Color(0xFF6B4E9E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient solidPurpleGradient = LinearGradient(
    colors: [primaryPurple, primaryPurpleDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [violetAccentLight, backgroundWhite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Category Colors (Purple Theme)
  static const Map<String, Color> categoryColors = {
    'kesehatan': Color(0xFFE3F2FD),
    'kreativitas': Color(0xFFF3E5F5),
    'pekerjaan': Color(0xFFE8F5E9),
    'belajar': Color(0xFFFFF3E0),
    'hubungan': Color(0xFFFCE4EC),
    'kesehatanMental': Color(0xFFE0F7FA),
  };

  static const Map<String, Color> categoryIconColors = {
    'kesehatan': Color(0xFF4597E6),
    'kreativitas': Color(0xFF9C27B0),
    'pekerjaan': Color(0xFF4CAF50),
    'belajar': Color(0xFFFF9800),
    'hubungan': Color(0xFFE91E63),
    'kesehatanMental': Color(0xFF00BCD4),
  };
}