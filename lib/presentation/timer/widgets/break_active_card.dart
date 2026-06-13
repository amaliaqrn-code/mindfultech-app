// lib/presentation/timer/widgets/break_active_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Card istirahat aktif yang ditampilkan setelah transisi BreakStartCard.
/// Menampilkan icon lonceng/alarm besar di kiri dan informasi istirahat di kanan.
class BreakActiveCard extends StatelessWidget {

  const BreakActiveCard({
    super.key,
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
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon lonceng/alarm besar di kiri
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: SvgPicture.asset(
              'assets/icon/timerpage/self_improve.svg',
              width: 32,
              height: 32,
            )
          ),
          const SizedBox(width: 16),

          // Teks di kanan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Judul
                const Text(
                  "Saatnya istirahat",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // Subtitle dengan durasi dinamis
                Text(
                  "Gunakan waktu istirahat mu ini sebaik mungkin ya",
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
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
