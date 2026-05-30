import 'package:flutter/material.dart';
import '../theme/timer_theme.dart';

/// Goal Card Widget - Shows the current task/focus goal
class GoalCard extends StatelessWidget {
  final String taskName;
  final VoidCallback onExitTap;

  const GoalCard({
    super.key,
    required this.taskName,
    required this.onExitTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: TimerTheme.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Target icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBEE),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.gps_fixed,
              color: TimerTheme.warningRed,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          // Task info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tujuan fokus hari ini',
                  style: TextStyle(
                    fontSize: 12,
                    color: TimerTheme.textGrey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  taskName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: TimerTheme.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Exit button
          GestureDetector(
            onTap: onExitTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: TimerTheme.primaryBluePale,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Keluar',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: TimerTheme.primaryBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
