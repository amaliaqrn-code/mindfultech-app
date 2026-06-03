import 'package:flutter/material.dart';
import '../theme/timer_theme.dart';

/// Timer Action Button - Start/Pause button with gradient
class TimerActionButton extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onTap;

  const TimerActionButton({
    super.key,
    required this.isRunning,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: TimerTheme.actionButtonGradient,
          boxShadow: [
            BoxShadow(
              color: TimerTheme.primaryBlue.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isRunning ? Icons.pause : Icons.play_arrow,
                color: TimerTheme.primaryBlue,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            // Button text
            Text(
              isRunning ? 'Berhenti' : 'Mulai Fokus',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}