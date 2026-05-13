import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  final double height;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 54,
    this.borderRadius = 18,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: double.infinity,
        height: height,

        decoration: BoxDecoration(
          gradient:
              AppColors.primaryGradient,

          borderRadius:
              BorderRadius.circular(
            borderRadius,
          ),

          boxShadow: [
            BoxShadow(
              color: AppColors.primary
                  .withOpacity(0.18),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Center(
          child: Text(
            text,

            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
} 