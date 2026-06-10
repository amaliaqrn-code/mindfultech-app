// lib/presentation/timer/widgets/timer_circle_progress.dart
import 'package:flutter/material.dart';
import '../theme/timer_theme.dart';

class TimerCircleProgress extends StatelessWidget {
  final String timeString;
  final double progressValue; // Nilai 0.0 sampai 1.0 untuk lingkaran

  const TimerCircleProgress({
    super.key,
    required this.timeString,
    required this.progressValue,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: CircularProgressIndicator(
            value: progressValue,
            strokeWidth: 12,
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        Text(timeString, style: TimerTheme.timerNumberStyle),
      ],
    );
  }
}