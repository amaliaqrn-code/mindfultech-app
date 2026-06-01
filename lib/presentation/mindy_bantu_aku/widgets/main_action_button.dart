import 'package:flutter/material.dart';
import '../theme/green_theme.dart';

/// Tombol utama di bagian bawah layar
class MainActionButton extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final VoidCallback? onPressed;

  const MainActionButton({
    super.key,
    required this.text,
    required this.isEnabled,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: isEnabled ? GreenTheme.primaryButtonGradient : null,
        color: isEnabled ? null : GreenTheme.borderLight,
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: GreenTheme.sageGreen.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          disabledBackgroundColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isEnabled ? Colors.white : GreenTheme.textMuted,
          ),
        ),
      ),
    );
  }
}

/// Tombol back dengan style sama
class GreenBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const GreenBackButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: GreenTheme.borderMedium,
            width: 2,
          ),
          color: GreenTheme.backgroundWhite,
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: GreenTheme.sageGreen,
          size: 18,
        ),
      ),
    );
  }
}
