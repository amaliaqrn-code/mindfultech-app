import 'package:flutter/material.dart';

/// Achievement Level Model
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

  static List<AchievementLevel> getAchievements(int currentStreak) {
    return [
      AchievementLevel(name: 'Pemula', description: 'Mulai perjalananmu', requiredDays: 5, torchColor: const Color(0xFFFFC107), icon: Icons.local_fire_department_rounded, isUnlocked: currentStreak >= 5),
      AchievementLevel(name: 'Konsisten', description: 'Terus berlatih ya!', requiredDays: 10, torchColor: const Color(0xFFFF9800), icon: Icons.local_fire_department_rounded, isUnlocked: currentStreak >= 10),
      AchievementLevel(name: 'Bersemangat', description: 'Semangatmu luar biasa!', requiredDays: 15, torchColor: const Color(0xFFFF5722), icon: Icons.local_fire_department_rounded, isUnlocked: currentStreak >= 15),
      AchievementLevel(name: 'Fokus', description: 'Kamu sangat fokus!', requiredDays: 20, torchColor: const Color(0xFF9C27B0), icon: Icons.local_fire_department_rounded, isUnlocked: currentStreak >= 20),
      AchievementLevel(name: 'Master', description: 'Kamu sangat konsisten!', requiredDays: 25, torchColor: const Color(0xFF3F51B5), icon: Icons.local_fire_department_rounded, isUnlocked: currentStreak >= 25),
      AchievementLevel(name: 'Legend', description: 'Legenda MindfulTech!', requiredDays: 30, torchColor: const Color(0xFF00BCD4), icon: Icons.local_fire_department_rounded, isUnlocked: currentStreak >= 30),
    ];
  }
}

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
    if (days >= 25) return const Color(0xFF00BCD4);
    if (days >= 20) return const Color(0xFF3F51B5);
    if (days >= 15) return const Color(0xFF9C27B0);
    if (days >= 10) return const Color(0xFFFF5722);
    if (days >= 5) return const Color(0xFFFF9800);
    return const Color(0xFFFFC107);
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

  double get progressPercent => streakDays >= 30 ? 1.0 : streakDays / 30.0;

  String getNextLevelInfo() {
    if (streakDays >= 30) return 'Level maksimal tercapai!';
    final nextDays = ((streakDays / 5 + 1) * 5).toInt();
    return '${nextDays - streakDays} hari lagi ke level selanjutnya';
  }
}