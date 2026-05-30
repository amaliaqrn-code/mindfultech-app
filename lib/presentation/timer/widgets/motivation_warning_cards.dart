import 'package:flutter/material.dart';
import '../theme/timer_theme.dart';

/// Motivation Card - Shows motivational message
class MotivationCard extends StatelessWidget {
  const MotivationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TimerTheme.cardYellowLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: TimerTheme.cardYellowBorder,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Light bulb icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDE7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lightbulb_outline,
              color: Color(0xFFFFC107),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Ingat Tujuanmu',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: TimerTheme.textDark,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Fokus sekarang, hasil luar biasa menantimu',
                  style: TextStyle(
                    fontSize: 13,
                    color: TimerTheme.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Warning Card - Shows warning message
class WarningCard extends StatelessWidget {
  const WarningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TimerTheme.cardRedLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: TimerTheme.cardRedBorder,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Warning icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBEE),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_amber,
              color: TimerTheme.warningRed,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Jangan buka aplikasi lain ya',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: TimerTheme.textDark,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'sampai sesi mu selesai',
                  style: TextStyle(
                    fontSize: 13,
                    color: TimerTheme.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
