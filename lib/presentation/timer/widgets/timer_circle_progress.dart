// lib/presentation/timer/widgets/timer_circle_progress.dart
import 'package:flutter/material.dart';

class TimerCircleProgress extends StatelessWidget {
  final String timeString;
  final double progressValue;
  final String sessionText;

  const TimerCircleProgress({
    super.key,
    required this.timeString,
    required this.progressValue,
    required this.sessionText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Lingkaran Progress Sesuai Gambar (Tebal & Berwarna Gradasi/Biru)
        SizedBox(
          width: 280,
          height: 280,
          child: CircularProgressIndicator(
            value: progressValue,
            strokeWidth: 14,
            backgroundColor: const Color(0xFFE0F7FA), // Warna dasar lingkaran (biru muda sekali)
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4A90E2)), // Warna isi progress
          ),
        ),
        // Konten teks di dalam lingkaran (Disusun vertikal)
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Waktu tersisa",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              timeString,
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Warna hitam tebal sesuai gambar
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              sessionText,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}