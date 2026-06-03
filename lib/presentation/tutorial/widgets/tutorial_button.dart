import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';

class TutorialButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isGradient;
  final bool isOutline;
  final Color? backgroundColor;

  const TutorialButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isGradient = true,
    this.isOutline = false,
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
            gradient: isGradient && !isOutline
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
            color: !isGradient ? (backgroundColor ?? Colors.white) : null,
            border: isOutline
                ? Border.all(
                    color: AppColors.primary,
                    width: 1.5,
                  )
                : null,
            boxShadow: isGradient && !isOutline
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
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isOutline ? AppColors.primary : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}