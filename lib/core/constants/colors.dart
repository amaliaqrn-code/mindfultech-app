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
}