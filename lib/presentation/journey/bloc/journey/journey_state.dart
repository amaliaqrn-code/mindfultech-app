// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../models/journey_level_model.dart';

class JourneyState extends Equatable {
  // Daily Focus System
  final int todayFocusSeconds;
  final int dailyTargetSeconds; // Default: 300 seconds (5 minutes)

  // Journey Progress
  final int totalDays;
  final List<JourneyLevelModel> levels;
  final JourneyLevelModel currentLevel;

  // Streak System
  final int streakCount;
  final String lastFocusDate; // Format: 'yyyy-MM-dd' for day change detection

  // Loading state
  final bool isLoading;
  final int animatedNode;
  final bool moveMindy;
  final int? selectedEmojiIndex;

  const JourneyState({
    required this.todayFocusSeconds,
    required this.dailyTargetSeconds,
    required this.totalDays,
    required this.levels,
    required this.currentLevel,
    required this.streakCount,
    required this.lastFocusDate,
    this.isLoading = false,
    this.animatedNode = 1,
    this.moveMindy = false,
    this.selectedEmojiIndex,
  });

  /// Factory untuk state awal - SELALU gunakan ini dengan nilai default yang aman
  factory JourneyState.initial() {
    return JourneyState(
      // Daily Focus - default 0 detik
      todayFocusSeconds: 0,
      dailyTargetSeconds: 300,
      // Journey - mulai dari level 1
      totalDays: 0,
      levels: JourneyData.getLevels(), // ✅ Selalu gunakan getter, bukan list kosong
      currentLevel: JourneyData.getLevelForDay(0), // ✅ Selalu gunakan getter
      // Streak - default 0
      streakCount: 0,
      lastFocusDate: '',
      // Loading state
      isLoading: true, // ✅ Mulai dengan loading=true sampai data dimuat
      animatedNode: 1,
    );
  }

  /// Check if daily focus target (5 minutes) is reached
  bool get isDailyTargetReached => todayFocusSeconds >= dailyTargetSeconds;

  /// Progress towards daily target (0.0 to 1.0)
  double get dailyProgress {
    if (dailyTargetSeconds == 0) return 0.0;
    return (todayFocusSeconds / dailyTargetSeconds).clamp(0.0, 1.0);
  }

  /// Remaining seconds to reach daily target
  int get remainingSecondsToTarget {
    return (dailyTargetSeconds - todayFocusSeconds).clamp(0, dailyTargetSeconds);
  }

  /// Safe getter untuk streakCount - tidak pernah null
  int get safeStreakCount => streakCount;

  /// Safe getter untuk totalDays - tidak pernah null
  int get safeTotalDays => totalDays;

  /// Safe getter untuk todayFocusSeconds - tidak pernah null
  int get safeTodayFocusSeconds => todayFocusSeconds;

  /// Check if data is loaded
  bool get isDataLoaded => !isLoading && levels.isNotEmpty;

  JourneyState copyWith({
    int? todayFocusSeconds,
    int? dailyTargetSeconds,
    int? totalDays,
    List<JourneyLevelModel>? levels,
    JourneyLevelModel? currentLevel,
    int? streakCount,
    String? lastFocusDate,
    bool? isLoading,
    bool? moveMindy,
    int? animatedNode,
    int? selectedEmojiIndex,
  }) {
    return JourneyState(
      todayFocusSeconds: todayFocusSeconds ?? this.todayFocusSeconds,
      dailyTargetSeconds: dailyTargetSeconds ?? this.dailyTargetSeconds,
      totalDays: totalDays ?? this.totalDays,
      levels: levels ?? this.levels,
      currentLevel: currentLevel ?? this.currentLevel,
      streakCount: streakCount ?? this.streakCount,
      lastFocusDate: lastFocusDate ?? this.lastFocusDate,
      isLoading: isLoading ?? this.isLoading,
      animatedNode: animatedNode ?? this.animatedNode,
      moveMindy: moveMindy ?? this.moveMindy,
      selectedEmojiIndex: selectedEmojiIndex ?? this.selectedEmojiIndex,
    );
  }

  @override
  List<Object?> get props => [
        todayFocusSeconds,
        dailyTargetSeconds,
        totalDays,
        levels,
        currentLevel,
        streakCount,
        lastFocusDate,
        isLoading,
      ];
}

/// Helper class untuk data default - digunakan di factory initial()
class JourneyData {
  static const int totalDaysInLevel = 5;
  static const int maxDays = 30;

  static List<JourneyLevelModel> getLevels() {
    return [
      JourneyLevelModel(
        level: 1,
        requiredDays: 1,
        areaName: 'Mulai Perjalanan',
        emoji: '🏠',
        backgroundImage: 'assets/images/journey/journey_map.png',
      ),
      JourneyLevelModel(
        level: 2,
        requiredDays: 6,
        areaName: 'Grassland',
        emoji: '🌿',
        backgroundImage: 'assets/images/journey/journey_map.png',
      ),
      JourneyLevelModel(
        level: 3,
        requiredDays: 11,
        areaName: 'Sunny Hill',
        emoji: '☀️',
        backgroundImage: 'assets/images/journey/journey_map.png',
      ),
      JourneyLevelModel(
        level: 4,
        requiredDays: 16,
        areaName: 'Calm Lake',
        emoji: '🌊',
        backgroundImage: 'assets/images/journey/journey_map.png',
      ),
      JourneyLevelModel(
        level: 5,
        requiredDays: 21,
        areaName: 'Focus Mountain',
        emoji: '🏔️',
        backgroundImage: 'assets/images/journey/journey_map.png',
      ),
      JourneyLevelModel(
        level: 6,
        requiredDays: 26,
        areaName: 'Kastil Ketenangan',
        emoji: '🏰',
        backgroundImage: 'assets/images/journey/journey_map.png',
      ),
    ];
  }

  static JourneyLevelModel getLevelForDay(int totalDays) {
    final levels = getLevels();
    if (levels.isEmpty) {
      return JourneyLevelModel(
        level: 1,
        requiredDays: 1,
        areaName: 'Mulai Perjalanan',
        emoji: '🏠',
        backgroundImage: '',
      );
    }

    JourneyLevelModel currentLevel = levels.first;
    for (var level in levels) {
      if (totalDays >= level.requiredDays) {
        currentLevel = level;
      } else {
        break;
      }
    }
    return currentLevel;
  }

  static int getDayInCurrentCycle(int totalDays) {
    if (totalDays <= 0) return 0;
    int dayInCycle = totalDays % 5;
    return dayInCycle == 0 ? 5 : dayInCycle;
  }

  static int getCurrentCycle(int totalDays) {
    if (totalDays <= 0) return 1;
    int cycle = 1;
    final levels = getLevels();
    for (var level in levels) {
      if (totalDays >= level.requiredDays) {
        cycle = level.level;
      }
    }
    return cycle;
  }
}
