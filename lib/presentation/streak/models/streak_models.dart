import 'package:flutter/material.dart';

/// ============================================================
/// STREAK MODELS - Data models untuk Streak feature
/// ============================================================

/// ============================================================
/// Achievement Level Model
/// ============================================================

class AchievementLevel {
  final String name;
  final String description;
  final int requiredDays;
  final Color torchColor;
  final IconData icon;
  final bool isUnlocked;

  const AchievementLevel({
    required this.name,
    required this.description,
    required this.requiredDays,
    required this.torchColor,
    required this.icon,
    required this.isUnlocked,
  });

  /// Get all achievements based on current streak
  static List<AchievementLevel> getAchievements(int currentStreak) {
    return [
      AchievementLevel(
        name: 'Pemula',
        description: 'Mulai perjalananmu',
        requiredDays: 5,
        torchColor: const Color(0xFFFFC107), // Yellow
        icon: Icons.local_fire_department_rounded,
        isUnlocked: currentStreak >= 5,
      ),
      AchievementLevel(
        name: 'Konsisten',
        description: 'Terus berlatih ya!',
        requiredDays: 10,
        torchColor: const Color(0xFFFF9800), // Orange
        icon: Icons.local_fire_department_rounded,
        isUnlocked: currentStreak >= 10,
      ),
      AchievementLevel(
        name: 'Bersemangat',
        description: 'Semangatmu luar biasa!',
        requiredDays: 15,
        torchColor: const Color(0xFFFF5722), // Deep Orange
        icon: Icons.local_fire_department_rounded,
        isUnlocked: currentStreak >= 15,
      ),
      AchievementLevel(
        name: 'Fokus',
        description: 'Kamu sangat fokus!',
        requiredDays: 20,
        torchColor: const Color(0xFF9C27B0), // Purple
        icon: Icons.local_fire_department_rounded,
        isUnlocked: currentStreak >= 20,
      ),
      AchievementLevel(
        name: 'Master',
        description: 'Kamu sangat konsisten!',
        requiredDays: 25,
        torchColor: const Color(0xFF3F51B5), // Indigo
        icon: Icons.local_fire_department_rounded,
        isUnlocked: currentStreak >= 25,
      ),
      AchievementLevel(
        name: 'Legend',
        description: 'Legenda MindfulTech!',
        requiredDays: 30,
        torchColor: const Color(0xFF00BCD4), // Cyan
        icon: Icons.local_fire_department_rounded,
        isUnlocked: currentStreak >= 30,
      ),
    ];
  }
}

/// ============================================================
/// Streak Theme - Dynamic colors based on streak level
/// ============================================================

class StreakTheme {
  final int streakDays;
  final Color primaryColor;
  final Color secondaryColor;
  final Color flameColor;
  final List<Color> progressGradient;

  StreakTheme({required this.streakDays})
      : primaryColor = _getPrimaryColor(streakDays),
        secondaryColor = _getSecondaryColor(streakDays),
        flameColor = _getFlameColor(streakDays),
        progressGradient = _getProgressGradient(streakDays);

  static Color _getPrimaryColor(int days) {
    if (days >= 25) return const Color(0xFF00BCD4); // Cyan
    if (days >= 20) return const Color(0xFF3F51B5); // Indigo
    if (days >= 15) return const Color(0xFF9C27B0); // Purple
    if (days >= 10) return const Color(0xFFFF5722); // Deep Orange
    if (days >= 5) return const Color(0xFFFF9800); // Orange
    return const Color(0xFFFFC107); // Yellow
  }

  static Color _getSecondaryColor(int days) {
    if (days >= 25) return const Color(0xFF00E5FF);
    if (days >= 20) return const Color(0xFF7986CB);
    if (days >= 15) return const Color(0xFFBA68C8);
    if (days >= 10) return const Color(0xFFFF7043);
    if (days >= 5) return const Color(0xFFFFB74D);
    return const Color(0xFFFFD54F);
  }

  static Color _getFlameColor(int days) {
    if (days >= 25) return const Color(0xFF00E5FF);
    if (days >= 20) return const Color(0xFF5C6BC0);
    if (days >= 15) return const Color(0xFFE040FB);
    if (days >= 10) return const Color(0xFFFF5252);
    if (days >= 5) return const Color(0xFFFFAB40);
    return const Color(0xFFFFD740);
  }

  static List<Color> _getProgressGradient(int days) {
    if (days >= 25) return [const Color(0xFF00E5FF), const Color(0xFF00BCD4)];
    if (days >= 20) return [const Color(0xFF7986CB), const Color(0xFF3F51B5)];
    if (days >= 15) return [const Color(0xFFE040FB), const Color(0xFF9C27B0)];
    if (days >= 10) return [const Color(0xFFFF5252), const Color(0xFFFF5722)];
    if (days >= 5) return [const Color(0xFFFFAB40), const Color(0xFFFF9800)];
    return [const Color(0xFFFFD740), const Color(0xFFFFC107)];
  }

  String get streakLabel {
    if (streakDays >= 30) return '30+ Hari';
    return '$streakDays Hari';
  }

  double get progressPercent {
    if (streakDays >= 30) return 1.0;
    return streakDays / 30.0;
  }

  String getNextLevelInfo() {
    if (streakDays >= 30) return 'Level maksimal tercapai!';
    final nextDays = ((streakDays / 5 + 1) * 5).toInt();
    final daysLeft = nextDays - streakDays;
    return '$daysLeft hari lagi ke level selanjutnya';
  }
}