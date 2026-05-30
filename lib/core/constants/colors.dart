import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff4597E6);
  static const Color secondary = Color(0xff7BBEFF);
  static const Color mint = Color(0xff83DFC6);

  static const Color textDark = Color(0xff2C2C2C);
  static const Color textGrey = Color(0xff655F5F);

  static const Color white = Colors.white;
  static const Color background = Color(0xffF8FAFC);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      primary,
      secondary,
      mint,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Green Theme Colors (Sage Green)
  static const Color sageGreen = Color(0xFF6A9859);
  static const Color sageGreenDark = Color(0xFF3D6B33);
  static const Color sageGreenLight = Color(0xFFD4E6C9);
  static const Color sageGreenPale = Color(0xFFF5F7F4);
  static const Color mintGreen = Color(0xFF83DFC6);
  static const Color mintGreenLight = Color(0xFFE8F8F2);
  static const Color greenBackground = Color(0xFFF8FAF5);

  static const LinearGradient greenButtonGradient = LinearGradient(
    colors: [
      sageGreen,
      sageGreenDark,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}