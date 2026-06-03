import 'package:flutter/material.dart';

/// ============================================================
/// MINDY BASE THEME - Shared theme configurations
/// ============================================================

class MindyBaseTheme {
  // === GREEN (Low Energy) ===
  static const green = MindyThemeColors(
    primary: Color(0xFF5D8A57),
    cardBg: Color(0xFFE3EFE0),
    subtitle: Color(0xFF8FA88B),
    gradient: [Color(0xFF5D8A57), Color(0xFF8FBC8F)],
    mascotAsset: 'assets/images/energirendah/awanmindy1.png',
    decorationIcon: Icons.eco_rounded,
  );

  // === BLUE (Medium Energy) ===
  static const blue = MindyThemeColors(
    primary: Color(0xFF4597E6),
    cardBg: Color(0xFFE8F4FD),
    subtitle: Color(0xFF7BBEFF),
    gradient: [Color(0xFF4597E6), Color(0xFF83DFC6)],
    mascotAsset: 'assets/images/energisedang/mindy.png',
    decorationIcon: Icons.star_rounded,
  );

  // === PURPLE (High Energy) ===
  static const purple = MindyThemeColors(
    primary: Color(0xFF7C4DFF),
    cardBg: Color(0xFFF3E5F5),
    subtitle: Color(0xFF9C27B0),
    gradient: [Color(0xFF7C4DFF), Color(0xFFB388FF)],
    mascotAsset: 'assets/images/energitinggi/mindy.png',
    decorationIcon: Icons.bolt_rounded,
  );

  // === Get theme by energy level ===
  static MindyThemeColors getByEnergy(int energyLevel) {
    switch (energyLevel) {
      case 0:
        return green;
      case 1:
        return blue;
      case 2:
        return purple;
      default:
        return green;
    }
  }
}

/// ============================================================
/// MINDY THEME COLORS
/// ============================================================

class MindyThemeColors {
  final Color primary;
  final Color cardBg;
  final Color subtitle;
  final List<Color> gradient;
  final String mascotAsset;
  final IconData decorationIcon;

  const MindyThemeColors({
    required this.primary,
    required this.cardBg,
    required this.subtitle,
    required this.gradient,
    required this.mascotAsset,
    required this.decorationIcon,
  });
}

/// ============================================================
/// CATEGORIES DATA
/// ============================================================

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

/// ============================================================
/// TASK DATA - Base task model
/// ============================================================

class MindyTaskModel {
  final String title;
  final String duration;
  final String category;
  final Color color;

  const MindyTaskModel({
    required this.title,
    required this.duration,
    required this.category,
    required this.color,
  });
}

/// ============================================================
/// NAV ITEMS
/// ============================================================

class MindyNavItem {
  final String label;
  final IconData icon;
  final bool isActive;

  const MindyNavItem({
    required this.label,
    required this.icon,
    required this.isActive,
  });

  static List<MindyNavItem> getItems(int activeIndex, MindyThemeColors theme) {
    return [
      MindyNavItem(
        label: 'Home',
        icon: Icons.home_rounded,
        isActive: activeIndex == 0,
      ),
      MindyNavItem(
        label: 'Fokus',
        icon: Icons.pie_chart_rounded,
        isActive: activeIndex == 1,
      ),
      MindyNavItem(
        label: 'Journey',
        icon: Icons.map_rounded,
        isActive: activeIndex == 2,
      ),
      MindyNavItem(
        label: 'Streak',
        icon: Icons.local_fire_department_rounded,
        isActive: activeIndex == 3,
      ),
      MindyNavItem(
        label: 'Profil',
        icon: Icons.person_rounded,
        isActive: activeIndex == 4,
      ),
    ];
  }
}