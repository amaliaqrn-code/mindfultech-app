import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {

  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 14,
    height: 1.5,
    color: AppColors.textGrey,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle smallText = TextStyle(
    fontSize: 13,
    color: AppColors.textGrey,
  );
}