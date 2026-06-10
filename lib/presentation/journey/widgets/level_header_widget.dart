import 'package:flutter/material.dart';

class LevelHeaderWidget extends StatelessWidget {
  final int level;
  final String title;
  final String subtitle;

  const LevelHeaderWidget({
    super.key,
    required this.level,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Badge Level
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xff3f4384), // Sesuaikan dengan tema dark purple-mu
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Level $level',
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 32),
        // Judul Utama
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        // Subtitle
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}