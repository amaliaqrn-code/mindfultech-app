import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class TutorialButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isGradient;
  final Color? backgroundColor;

  const TutorialButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isGradient = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: isGradient
                ? const LinearGradient(
                    colors: [
                      Color(0xff4597E6),
                      Color(0xff7BBEFF),
                      Color(0xff83DFC6),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: !isGradient ? (backgroundColor ?? AppColors.secondary) : null,
            boxShadow: isGradient
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}