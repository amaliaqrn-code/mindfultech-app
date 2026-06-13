import '../models/journey_level_model.dart';

class JourneyData {
  static const int totalDaysInLevel = 5; // Dibagi merata 5 hari per siklus level untuk siklus 30 hari
  static const int maxDays = 30; // 30-day journey cycle

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

    // Safety check: if levels is empty, return default level
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
    // Menghitung siklus level (1-6) berdasarkan total hari fokus yang dicapai
    int cycle = 1;
    final levels = getLevels();
    for (var level in levels) {
      if (totalDays >= level.requiredDays) {
        cycle = level.level;
      }
    }
    return cycle;
  }

  static int getCurrentLevelProgress(int totalDays) {
    final levels = getLevels();
    int currentLevelIndex = 0;

    for (int i = 0; i < levels.length; i++) {
      if (totalDays >= levels[i].requiredDays) {
        currentLevelIndex = i;
      } else {
        break;
      }
    }

    final previousLevelDays = currentLevelIndex > 0
        ? levels[currentLevelIndex - 1].requiredDays
        : 0;
    return totalDays - previousLevelDays;
  }

  static double getOverallProgress(int totalDays) {
    return (totalDays / maxDays).clamp(0.0, 1.0);
  }

  static int getNextMilestone(int totalDays) {
    final levels = getLevels();
    for (var level in levels) {
      if (totalDays < level.requiredDays) {
        return level.requiredDays;
      }
    }
    return maxDays;
  }

  static String getNextMilestoneName(int totalDays) {
    final levels = getLevels();
    for (var level in levels) {
      if (totalDays < level.requiredDays) {
        return '${level.emoji} ${level.areaName}';
      }
    }
    return '🏰 Kastil Ketenangan';
  }
}