import 'package:flutter/material.dart';

/// Model level pencapaian berdasarkan data gambar UI
class AchievementLevel {
  final String name;
  final String description;
  final int requiredDays;
  final Color activeColor;

  const AchievementLevel({
    required this.name,
    required this.description,
    required this.requiredDays,
    required this.activeColor,
  });

  static List<AchievementLevel> getAchievements() {
    return [
      const AchievementLevel(
        name: 'Pemula',
        description: 'Pertahankan fokusmu selama 5 hari berturut-turut.',
        requiredDays: 5,
        activeColor: Color(0xFFFFB74D), // Oranye Muda/Kuning hangat
      ),
      const AchievementLevel(
        name: 'Konsisten',
        description: 'Pertahankan fokusmu selama 10 hari berturut-turut.',
        requiredDays: 10,
        activeColor: Color(0xFFF57C00), // Oranye Tua
      ),
      const AchievementLevel(
        name: 'Bersemangat',
        description: 'Pertahankan fokusmu selama 15 hari berturut-turut.',
        requiredDays: 15,
        activeColor: Color(0xFFE53935), // Merah
      ),
      const AchievementLevel(
        name: 'Fokus',
        description: 'Pertahankan fokusmu selama 20 hari berturut-turut.',
        requiredDays: 20,
        activeColor: Color(0xFFB388FF), // Ungu
      ),
      const AchievementLevel(
        name: 'Hebat',
        description: 'Pertahankan fokusmu selama 25 hari berturut-turut.',
        requiredDays: 25,
        activeColor: Color(0xFF4DD0E1), // Biru Toska Muda
      ),
      const AchievementLevel(
        name: 'Legend',
        description: 'Pertahankan fokusmu selama 30 hari berturut-turut.',
        requiredDays: 30,
        activeColor: Color(0xFF00E5FF), // Biru Cyan/Neon
      ),
    ];
  }
}

/// Tema dinamis yang mengontrol seluruh warna UI berdasarkan jumlah hari
class StreakTheme {
  final int streakDays;
  final Color mainColor;
  final List<Color> progressGradient;

  StreakTheme({required this.streakDays})
      : mainColor = _determineColor(streakDays),
        progressGradient = _determineGradient(streakDays);

  static Color _determineColor(int days) {
    if (days >= 30) return const Color(0xFF00E5FF);
    if (days >= 25) return const Color(0xFF4DD0E1);
    if (days >= 20) return const Color(0xFFB388FF);
    if (days >= 15) return const Color(0xFFE53935);
    if (days >= 10) return const Color(0xFFF57C00);
    return const Color(0xFFFFB74D);
  }

  static List<Color> _determineGradient(int days) {
    if (days >= 30) return [const Color(0xFF26C6DA), const Color(0xFF00E5FF)];
    if (days >= 25) return [const Color(0xFF4DD0E1), const Color(0xFF26A69A)];
    if (days >= 20) return [const Color(0xFFCE93D8), const Color(0xFFB388FF)];
    if (days >= 15) return [const Color(0xFFFF8A80), const Color(0xFFE53935)];
    if (days >= 10) return [const Color(0xFFFFCC80), const Color(0xFFF57C00)];
    return [const Color(0xFFFFE082), const Color(0xFFFFB74D)];
  }

  double get progressPercent {
    if (streakDays >= 30) return 1.0;
    return streakDays / 30.0;
  }

  String getNextLevelInfo() {
    if (streakDays >= 30) return 'Level maksimal tercapai!';
    int nextMilestone = ((streakDays / 5).floor() + 1) * 5;
    if (nextMilestone > 30) nextMilestone = 30;
    
    // Jika posisi pas di milestone (misal hari ke 5), cari milestone berikutnya
    if (streakDays == nextMilestone - 5 && streakDays > 0) {
       nextMilestone = streakDays + 5;
    }
    
    final daysRemaining = nextMilestone - streakDays;
    return '$daysRemaining hari lagi ke level selanjutnya';
  }
}