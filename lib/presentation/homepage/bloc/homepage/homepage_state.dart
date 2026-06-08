import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TaskItem {
  final String id;
  final String title;
  final String duration;
  final String category;
  final String iconPath;
  final Color categoryColor;

  const TaskItem({
    required this.id,
    required this.title,
    required this.duration,
    required this.category,
    required this.iconPath,
    required this.categoryColor,
  });
}

class LevelData {
  final int level;
  final String streakText;
  final String levelText;
  final String mascotText;
  final List<TaskItem> tasks;

  const LevelData({
    required this.level,
    required this.streakText,
    required this.levelText,
    required this.mascotText,
    required this.tasks,
  });
}

class HomepageState extends Equatable {
  final int userLevel;
  final String mascotGreeting;

  const HomepageState({
    required this.userLevel,
    required this.mascotGreeting,
  });

  static const Map<int, LevelData> levelConfigs = {
    1: LevelData(
      level: 1,
      streakText: '5 / 30 hari',
      levelText: 'LEVEL 01',
      mascotText: 'Yuk mulai hari produktif bareng Mindy!',
      tasks: [
        TaskItem(
          id: 't1',
          title: 'Belajar',
          duration: '20 Menit Fokus',
          category: 'Belajar',
          iconPath: 'assets/icon/homepage/belajar.png',
          categoryColor: Color(0xFF4597E6),
        ),
        TaskItem(
          id: 't2',
          title: 'Olahraga Ringan',
          duration: '15 Menit Fokus',
          category: 'Kesehatan',
          iconPath: 'assets/icon/homepage/olahraga.png',
          categoryColor: Color(0xFF4CAF50),
        ),
        TaskItem(
          id: 't3',
          title: 'Minum Air',
          duration: '5 Menit Fokus',
          category: 'Kesehatan',
          iconPath: 'assets/icon/homepage/olahraga.png',
          categoryColor: Color(0xFF4CAF50),
        ),
      ],
    ),
    2: LevelData(
      level: 2,
      streakText: '10 / 30 hari',
      levelText: 'LEVEL 02',
      mascotText: 'Mindy siap jadi teman fokusmu hari ini!',
      tasks: [
        TaskItem(
          id: 't4',
          title: 'Baca Buku',
          duration: '25 Menit Fokus',
          category: 'Belajar',
          iconPath: 'assets/icon/homepage/belajar.png',
          categoryColor: Color(0xFF4597E6),
        ),
        TaskItem(
          id: 't5',
          title: 'Stretching',
          duration: '15 Menit Fokus',
          category: 'Kesehatan',
          iconPath: 'assets/icon/homepage/olahraga.png',
          categoryColor: Color(0xFF4CAF50),
        ),
        TaskItem(
          id: 't6',
          title: 'Journaling',
          duration: '10 Menit Fokus',
          category: 'Self Care',
          iconPath: 'assets/icon/homepage/menonton.png',
          categoryColor: Color(0xFFFF9800),
        ),
      ],
    ),
    3: LevelData(
      level: 3,
      streakText: '15 / 30 hari',
      levelText: 'LEVEL 03',
      mascotText: 'Keren! Kamu makin semangat nih!',
      tasks: [
        TaskItem(
          id: 't7',
          title: 'Kursus Online',
          duration: '30 Menit Fokus',
          category: 'Belajar',
          iconPath: 'assets/icon/homepage/belajar.png',
          categoryColor: Color(0xFF4597E6),
        ),
        TaskItem(
          id: 't8',
          title: 'Jogging',
          duration: '25 Menit Fokus',
          category: 'Kesehatan',
          iconPath: 'assets/icon/homepage/olahraga.png',
          categoryColor: Color(0xFF4CAF50),
        ),
        TaskItem(
          id: 't9',
          title: 'Meditasi',
          duration: '15 Menit Fokus',
          category: 'Self Care',
          iconPath: 'assets/icon/homepage/menonton.png',
          categoryColor: Color(0xFFFF9800),
        ),
      ],
    ),
    4: LevelData(
      level: 4,
      streakText: '20 / 30 hari',
      levelText: 'LEVEL 04',
      mascotText: 'Level 4! Progressmu amazing!',
      tasks: [
        TaskItem(
          id: 't10',
          title: 'Coding Practice',
          duration: '45 Menit Fokus',
          category: 'Belajar',
          iconPath: 'assets/icon/homepage/belajar.png',
          categoryColor: Color(0xFF4597E6),
        ),
        TaskItem(
          id: 't11',
          title: 'Gym Session',
          duration: '40 Menit Fokus',
          category: 'Kesehatan',
          iconPath: 'assets/icon/homepage/olahraga.png',
          categoryColor: Color(0xFF4CAF50),
        ),
        TaskItem(
          id: 't12',
          title: 'Memasak Sehat',
          duration: '30 Menit Fokus',
          category: 'Kesehatan',
          iconPath: 'assets/icon/homepage/menonton.png',
          categoryColor: Color(0xFF4CAF50),
        ),
      ],
    ),
    5: LevelData(
      level: 5,
      streakText: '25 / 30 hari',
      levelText: 'LEVEL 05',
      mascotText: 'Hampir sampai! Stay focused ya!',
      tasks: [
        TaskItem(
          id: 't13',
          title: 'Project Tutorial',
          duration: '60 Menit Fokus',
          category: 'Belajar',
          iconPath: 'assets/icon/homepage/belajar.png',
          categoryColor: Color(0xFF4597E6),
        ),
        TaskItem(
          id: 't14',
          title: 'HIIT Workout',
          duration: '30 Menit Fokus',
          category: 'Kesehatan',
          iconPath: 'assets/icon/homepage/olahraga.png',
          categoryColor: Color(0xFF4CAF50),
        ),
        TaskItem(
          id: 't15',
          title: 'Creative Writing',
          duration: '25 Menit Fokus',
          category: 'Kreativitas',
          iconPath: 'assets/icon/homepage/menonton.png',
          categoryColor: Color(0xFF9C27B0),
        ),
      ],
    ),
    6: LevelData(
      level: 6,
      streakText: '30 / 30 hari',
      levelText: 'LEVEL 06',
      mascotText: 'Level complete! Yuk lanjut berkembang bareng Mindy!',
      tasks: [
        TaskItem(
          id: 't16',
          title: 'Masterclass',
          duration: '90 Menit Fokus',
          category: 'Belajar',
          iconPath: 'assets/icon/homepage/belajar.png',
          categoryColor: Color(0xFF4597E6),
        ),
        TaskItem(
          id: 't17',
          title: 'Yoga Intensive',
          duration: '45 Menit Fokus',
          category: 'Kesehatan',
          iconPath: 'assets/icon/homepage/olahraga.png',
          categoryColor: Color(0xFF4CAF50),
        ),
        TaskItem(
          id: 't18',
          title: 'Portfolio Update',
          duration: '40 Menit Fokus',
          category: 'Kreativitas',
          iconPath: 'assets/icon/homepage/menonton.png',
          categoryColor: Color(0xFF9C27B0),
        ),
      ],
    ),
  };

  LevelData get currentLevelData {
    return levelConfigs[userLevel] ?? levelConfigs[1]!;
  }

  List<TaskItem> get currentTasks => currentLevelData.tasks;

  int get taskCount => currentTasks.length;

  String get backgroundImagePath {
    return 'assets/images/homepage/background.png';
  }

  String get streakText => currentLevelData.streakText;

  String get levelText => currentLevelData.levelText;

  /// Getters used by homepage_screen.dart
  int get currentLevel => userLevel;

  String get levelTitle => currentLevelData.levelText;

  int get streakCount {
    final parts = currentLevelData.streakText.split(' ');
    return int.tryParse(parts[0]) ?? 0;
  }

  double get experienceProgress {
    final streakValue = int.tryParse(currentLevelData.streakText.split(' ')[0]) ?? 0;
    return streakValue / 30;
  }

  double get streakProgress {
    final streakValue = int.parse(currentLevelData.streakText.split(' ')[0]);
    return streakValue / 30;
  }

  HomepageState copyWith({
    int? userLevel,
    String? mascotGreeting,
  }) {
    return HomepageState(
      userLevel: userLevel ?? this.userLevel,
      mascotGreeting: mascotGreeting ?? this.mascotGreeting,
    );
  }

  @override
  List<Object?> get props => [userLevel, mascotGreeting];
}
