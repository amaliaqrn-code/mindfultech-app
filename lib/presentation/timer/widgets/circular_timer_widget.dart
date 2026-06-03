import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/timer_theme.dart';

/// Circular Progress Timer Widget
class CircularTimerWidget extends StatelessWidget {
  final double progress;
  final String timeText;
  final String minutesLabel;
  final String sessionLabel;
  final String qualityLabel;
  final bool canEdit;
  final VoidCallback onEditTap;

  const CircularTimerWidget({
    super.key,
    required this.progress,
    required this.timeText,
    required this.minutesLabel,
    required this.sessionLabel,
    required this.qualityLabel,
    required this.canEdit,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          CustomPaint(
            size: const Size(260, 260),
            painter: _CircleBackgroundPainter(),
          ),
          // Progress arc
          CustomPaint(
            size: const Size(260, 260),
            painter: _CircleProgressPainter(progress: progress),
          ),
          // Inner content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Session label
              Text(
                sessionLabel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: TimerTheme.textBlue,
                ),
              ),
              const SizedBox(height: 8),
              // Minutes chip (clickable)
              GestureDetector(
                onTap: canEdit ? onEditTap : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFFFE082),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (canEdit) ...[
                        Icon(
                          Icons.edit,
                          size: 14,
                          color: TimerTheme.textGrey,
                        ),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        minutesLabel,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: canEdit
                              ? TimerTheme.textGrey
                              : TimerTheme.textLightGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Main time text
              Text(
                timeText,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: TimerTheme.textDark,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 12),
              // Quality label
              Text(
                qualityLabel,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: TimerTheme.textBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Custom painter for circle background
class _CircleBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;

    // Background circle
    final bgPaint = Paint()
      ..color = TimerTheme.timerBackground
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for progress arc
class _CircleProgressPainter extends CustomPainter {
  final double progress;

  _CircleProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;

    // Progress arc
    final progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [TimerTheme.primaryBlue, TimerTheme.primaryBlueDark],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    // Draw arc from top (-90 degrees) clockwise
    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
