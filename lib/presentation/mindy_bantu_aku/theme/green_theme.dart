import 'package:flutter/material.dart';

/// Green Theme Colors for Choose Energy Screen
class GreenTheme {
  // Primary Green Colors
  static const Color sageGreen = Color(0xFF6A9859);
  static const Color sageGreenDark = Color(0xFF3D6B33);
  static const Color sageGreenLight = Color(0xFFD4E6C9);
  static const Color sageGreenPale = Color(0xFFF5F7F4);
  static const Color sageGreenFaded = Color(0xFFE8EDE4);

  // Mint Accents
  static const Color mintGreen = Color(0xFF83DFC6);
  static const Color mintGreenLight = Color(0xFFE8F8F2);

  // Background Colors
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundCream = Color(0xFFFAFDF7);
  static const Color backgroundPage = Color(0xFFF8FAF5);

  // Text Colors
  static const Color textDark = Color(0xFF2C2C2C);
  static const Color textMedium = Color(0xFF4A4A4A);
  static const Color textGrey = Color(0xFF655F5F);
  static const Color textLightGrey = Color(0xFF8A8A8A);
  static const Color textMuted = Color(0xFFB5B5B5);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color warning = Color(0xFFFFB74D);
  static const Color warningLight = Color(0xFFFFF3E0);

  // Border & Shadow
  static const Color borderLight = Color(0xFFE0E8DA);
  static const Color borderMedium = Color(0xFFC8D4BD);
  static const Color shadowColor = Color(0x1A3D6B33);

  // Gradient for buttons
  static const LinearGradient primaryButtonGradient = LinearGradient(
    colors: [sageGreen, sageGreenDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [mintGreenLight, backgroundWhite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Category Colors
  static const Map<String, Color> categoryColors = {
    'rumah': Color(0xFFE8F5E9),
    'selfCare': Color(0xFFFCE4EC),
    'belajar': Color(0xFFE3F2FD),
    'hubungan': Color(0xFFFFF3E0),
    'kreativitas': Color(0xFFF3E5F5),
    'kesehatan': Color(0xFFE0F7FA),
  };

  static const Map<String, Color> categoryIconColors = {
    'rumah': Color(0xFF4CAF50),
    'selfCare': Color(0xFFE91E63),
    'belajar': Color(0xFF2196F3),
    'hubungan': Color(0xFFFF9800),
    'kreativitas': Color(0xFF9C27B0),
    'kesehatan': Color(0xFF00BCD4),
  };
}
