// lib/presentation/timer/widgets/motivation_card.dart
import 'package:flutter/material.dart';

/// Card motivasi yang ditampilkan saat sesi fokus aktif.
/// Icon bintang oranye dengan teks motivasi.
class MotivationCard extends StatelessWidget {
  const MotivationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Tetap fokus kamu pasti bisa",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10),
          Icon(Icons.star, color: Colors.orange, size: 20),
        ],
      ),
    );
  }
}
