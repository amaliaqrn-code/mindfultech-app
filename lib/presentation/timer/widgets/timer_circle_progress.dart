// lib/presentation/timer/widgets/timer_circle_progress.dart
import 'package:flutter/material.dart';

class TimerCircleProgress extends StatelessWidget {
  final String timeString;
  final double progressValue;
  final String sessionText;
  final bool showCloud;

  const TimerCircleProgress({
    super.key,
    required this.timeString,
    required this.progressValue,
    required this.sessionText,
    required this.showCloud,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive size: use up to 55% of available width, max 300
        final double size = constraints.maxWidth * 0.75;
        final double cappedSize = size.clamp(180.0, 300.0);
        final double fontSize = (cappedSize / 300 * 64).clamp(36.0, 64.0);
        final double strokeWidth = (cappedSize / 300 * 28).clamp(18.0, 28.0);
        final double cloudSize = (cappedSize / 300 * 120).clamp(60.0, 120.0);

        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // 🔵 PROGRESS CIRCLE
            SizedBox(
              width: cappedSize,
              height: cappedSize,
              child: ClipOval(
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const SweepGradient(
                      colors: [
                        Color(0xFF4A90E2),
                        Color(0xFF50E3C2),
                        Color(0xFF4A90E2),
                      ],
                    ).createShader(bounds);
                  },
                  child: CircularProgressIndicator(
                    value: progressValue,
                    strokeWidth: strokeWidth,
                    backgroundColor: const Color(0xFFE0F7FA),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),

            // ☁️ CLOUD TOP RIGHT
            if (showCloud)
              Positioned(
                top: -cappedSize * 0.1,
                right: -cappedSize * 0.1,
                child: Image.asset(
                  'assets/icon/timerpage/Cloud5.png',
                  width: cloudSize,
                ),
              ),

            // ☁️ CLOUD BOTTOM LEFT
            if (showCloud)
              Positioned(
                bottom: -cappedSize * 0.17,
                left: -cappedSize * 0.07,
                child: Image.asset(
                  'assets/icon/timerpage/Cloud5.png',
                  width: cloudSize,
                ),
              ),

            // 🧠 TEXT CENTER
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Waktu tersisa",
                  style: TextStyle(fontSize: fontSize * 0.22),
                ),
                SizedBox(height: cappedSize * 0.027),
                Text(
                  timeString,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: cappedSize * 0.027),
                Text(
                  sessionText,
                  style: TextStyle(fontSize: fontSize * 0.22),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}