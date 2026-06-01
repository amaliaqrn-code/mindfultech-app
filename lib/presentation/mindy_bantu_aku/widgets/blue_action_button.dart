import 'package:flutter/material.dart';
import '../theme/blue_theme.dart';

/// Blue Main Action Button
class BlueMainActionButton extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final VoidCallback? onPressed;
  final bool useGradient;

  const BlueMainActionButton({
    super.key,
    required this.text,
    required this.isEnabled,
    this.onPressed,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: isEnabled
            ? (useGradient ? BlueTheme.primaryButtonGradient : BlueTheme.solidBlueGradient)
            : null,
        color: isEnabled ? null : BlueTheme.borderLight,
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: BlueTheme.primaryBlue.withValues(alpha: 0.4),
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
            color: isEnabled ? Colors.white : BlueTheme.textMuted,
          ),
        ),
      ),
    );
  }
}

/// Blue Back Button
class BlueBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const BlueBackButton({
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
            color: BlueTheme.borderMedium,
            width: 2,
          ),
          color: BlueTheme.backgroundWhite,
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: BlueTheme.primaryBlue,
          size: 18,
        ),
      ),
    );
  }
}