import 'package:equatable/equatable.dart';

class LevelData {
  final int level;
  final String streakText;
  final String levelText;
  final String mascotText;

  const LevelData({
    required this.level,
    required this.streakText,
    required this.levelText,
    required this.mascotText,
  });
}

class HomepageState extends Equatable {
  final int userLevel;
  final String mascotGreeting;
  final int emotionSessionCount; // Number of unique emotions used
  final int totalFocusSessions;  // Total completed focus sessions
  final List<int> savedEmojiIndices; // ✅ TAMBAHKAN INI: Menyimpan list index emoji asli dari database

  const HomepageState({
    required this.userLevel,
    required this.mascotGreeting,
    this.emotionSessionCount = 0,
    this.totalFocusSessions = 0,
    this.savedEmojiIndices = const [], // ✅ Set default sebagai list kosong agar aman
  });

  static const Map<int, LevelData> levelConfigs = {
    1: LevelData(
      level: 1,
      streakText: '0 / 0 hari',
      levelText: 'LEVEL 01',
      mascotText: 'Yuk mulai hari produktif bareng Mindy!',
    ),
    2: LevelData(
      level: 2,
      streakText: '0 / 0 hari',
      levelText: 'LEVEL 02',
      mascotText: 'Mindy siap jadi teman fokusmu hari ini!',
    ),
    3: LevelData(
      level: 3,
      streakText: '0 / 0 hari',
      levelText: 'LEVEL 03',
      mascotText: 'Keren! Kamu makin semangat nih!',
    ),
    4: LevelData(
      level: 4,
      streakText: '0 / 0 hari',
      levelText: 'LEVEL 04',
      mascotText: 'Level 4! Progressmu amazing!',
    ),
    5: LevelData(
      level: 5,
      streakText: '0 / 0 hari',
      levelText: 'LEVEL 05',
      mascotText: 'Hampir sampai! Stay focused ya!',
    ),
    6: LevelData(
      level: 6,
      streakText: '0 / 0 hari',
      levelText: 'LEVEL 06',
      mascotText: 'Level complete! Yuk lanjut berkembang bareng Mindy!',
    ),
  };

  LevelData get currentLevelData {
    return levelConfigs[userLevel] ?? levelConfigs[1]!;
  }

  int get taskCount => 0; // Will be handled by TaskBloc

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
    return 0.0; // Will be calculated from JourneyState
  }

  double get streakProgress {
    return 0.0; // Will be calculated from JourneyState
  }

  // ✅ UPDATE METHOD COPYWITH AGAR BERHASIL MENERIMA PARAMS BARU
  HomepageState copyWith({
    int? userLevel,
    String? mascotGreeting,
    int? emotionSessionCount,
    int? totalFocusSessions,
    List<int>? savedEmojiIndices, // <-- Tambahkan parameter ini
  }) {
    return HomepageState(
      userLevel: userLevel ?? this.userLevel,
      mascotGreeting: mascotGreeting ?? this.mascotGreeting,
      emotionSessionCount: emotionSessionCount ?? this.emotionSessionCount,
      totalFocusSessions: totalFocusSessions ?? this.totalFocusSessions,
      savedEmojiIndices: savedEmojiIndices ?? this.savedEmojiIndices, // <-- Assign ke properti class
    );
  }

  // ✅ MASUKKAN KEDALAM PROPS EQUATABLE AGAR DI-TRACK SAAT EMIT STATE BARU
  @override
  List<Object?> get props => [
        userLevel,
        mascotGreeting,
        emotionSessionCount,
        totalFocusSessions,
        savedEmojiIndices, // <-- Daftarkan di sini
      ];
}