// lib/presentation/timer/theme/timer_theme.dart
import 'package:flutter/material.dart';

class TimerTheme {
  static const BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF4A90E2), Color(0xFF78E6C8)], // Sesuaikan warna lamamu
    ),
  );

  static const TextStyle timerNumberStyle = TextStyle(
    fontSize: 64,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}