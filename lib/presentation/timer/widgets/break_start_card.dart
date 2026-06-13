// lib/presentation/timer/widgets/break_start_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Card transisi sementara yang muncul saat break dimulai.
/// Hanya tampil selama 2-3 detik sebelum berganti ke BreakActiveCard.
///
/// Card ini memberikan waktu bagi pengguna untuk "menyadari" bahwa
/// sesi istirahat telah dimulai.
class BreakStartCard extends StatelessWidget {
  
  final int breakDurationMinutes;

  const BreakStartCard({
    super.key,
    required this.breakDurationMinutes,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon BELL
          Container(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              'assets/icon/timerpage/bell.svg',
              width: 32,
              height: 32,
            )
          ),
          const SizedBox(width: 12),

          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
            children: [
            Text(
            "Waktunya Istirahat!",
            style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),

          // Subtitle
          Text(
            "Istirahat selama $breakDurationMinutes\nmenit menyegarkan pikiranmu.",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          ],
          ))
        ],
      ),
    );
  }
}
