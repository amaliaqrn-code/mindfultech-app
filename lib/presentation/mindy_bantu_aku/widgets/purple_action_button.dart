import 'package:flutter/material.dart';
import '../theme/purple_theme.dart';

/// Purple Main Action Button
class PurpleMainActionButton extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final VoidCallback? onPressed;
  final bool useGradient;

  const PurpleMainActionButton({
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
            ? (useGradient ? PurpleTheme.primaryButtonGradient : PurpleTheme.solidPurpleGradient)
            : null,
        color: isEnabled ? null : PurpleTheme.borderLight,
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: PurpleTheme.primaryPurple.withValues(alpha: 0.4),
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
            color: isEnabled ? Colors.white : PurpleTheme.textMuted,
          ),
        ),
      ),
    );
  }
}

/// Purple Back Button
class PurpleBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const PurpleBackButton({
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
            color: PurpleTheme.borderMedium,
            width: 2,
          ),
          color: PurpleTheme.backgroundWhite,
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: PurpleTheme.primaryPurple,
          size: 18,
        ),
      ),
    );
  }
}