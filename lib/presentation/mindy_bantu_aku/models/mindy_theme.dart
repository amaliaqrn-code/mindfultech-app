import 'package:flutter/material.dart';
import 'task_model.dart' show EnergyLevel;

/// Konfigurasi tema untuk setiap level energi
class MindyTheme {
  final Color primaryColor;
  final Color secondaryColor;
  final Color cardBg;
  final Color subtitleColor;
  final String mascotAsset;
  final List<Widget> decorations;
  final Gradient? buttonGradient;
  final bool showBottomNav;
  final bool hasButtonIcon;

  const MindyTheme({
    required this.primaryColor,
    required this.secondaryColor,
    required this.cardBg,
    required this.subtitleColor,
    required this.mascotAsset,
    this.decorations = const [],
    this.buttonGradient,
    this.showBottomNav = false,
    this.hasButtonIcon = false,
  });

  // === GREEN THEME - Energi Rendah ===
  static const green = MindyTheme(
    primaryColor: Color(0xFF5D8A57),
    secondaryColor: Color(0xFF8FBC8F),
    cardBg: Color(0xFFE3EFE0),
    subtitleColor: Color(0xFF8FA88B),
    mascotAsset: 'assets/images/energirendah/awanmindy1.png',
    showBottomNav: false,
  );

  // === BLUE THEME - Energi Sedang ===
  static const blue = MindyTheme(
    primaryColor: Color(0xFF4597E6),
    secondaryColor: Color(0xFF83DFC6),
    cardBg: Color(0xFFE8F4FD),
    subtitleColor: Color(0xFF7BBEFF),
    mascotAsset: 'assets/images/energisedang/mindy.png',
    buttonGradient: LinearGradient(
      colors: [Color(0xFF4597E6), Color(0xFF83DFC6)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    showBottomNav: true,
  );

  // === PURPLE THEME - Energi Tinggi ===
  static const purple = MindyTheme(
    primaryColor: Color(0xFF7C4DFF),
    secondaryColor: Color(0xFFB388FF),
    cardBg: Color(0xFFF3E5F5),
    subtitleColor: Color(0xFF9C27B0),
    mascotAsset: 'assets/images/energitinggi/mindy.png',
    showBottomNav: true,
    hasButtonIcon: true,
  );

  /// Get theme by energy level
  static MindyTheme fromEnergyLevel(EnergyLevel level) {
    switch (level) {
      case EnergyLevel.low:
        return green;
      case EnergyLevel.medium:
        return blue;
      case EnergyLevel.high:
        return purple;
    }
  }
}

/// Kategori untuk Mindy Bantu Aku
class MindyCategory {
  final String name;
  final String imagePath;
  final IconData fallbackIcon;

  const MindyCategory({
    required this.name,
    required this.imagePath,
    required this.fallbackIcon,
  });

  static const List<MindyCategory> categories = [
    MindyCategory(
      name: 'Belajar',
      imagePath: 'assets/images/pilihenergi/belajar.png',
      fallbackIcon: Icons.menu_book_rounded,
    ),
    MindyCategory(
      name: 'Pekerjaan',
      imagePath: 'assets/images/pilihenergi/pekerjaan.png',
      fallbackIcon: Icons.work_rounded,
    ),
    MindyCategory(
      name: 'Kesehatan',
      imagePath: 'assets/images/pilihenergi/kesehatan.png',
      fallbackIcon: Icons.favorite_rounded,
    ),
    MindyCategory(
      name: 'Pribadi',
      imagePath: 'assets/images/pilihenergi/pribadi.png',
      fallbackIcon: Icons.person_rounded,
    ),
    MindyCategory(
      name: 'Rumah',
      imagePath: 'assets/images/pilihenergi/rumah.png',
      fallbackIcon: Icons.home_rounded,
    ),
    MindyCategory(
      name: 'Lainnya',
      imagePath: 'assets/images/pilihenergi/lainnya.png',
      fallbackIcon: Icons.auto_awesome_rounded,
    ),
  ];
}

/// Task model untuk Mindy Bantu Aku
class MindyTask {
  final String title;
  final String duration;
  final String category;
  final Color color;

  const MindyTask({
    required this.title,
    required this.duration,
    required this.category,
    required this.color,
  });
}