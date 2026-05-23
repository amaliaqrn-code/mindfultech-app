import '../models/journey_level_model.dart';

class JourneyData {
  static const int totalDaysInLevel = 7;
  static const int maxDays = 30; // 30-day journey cycle

  /// Each waypoint on the map corresponds to a day (1-7).
  /// The denah.png background shows 6 numbered pins + castle at top.
  /// Positions are relative to the denah image (percentage from top-left).
  /// These map the winding path from bottom-left (house) to top-right (castle).
  static const List<Map<String, double>> waypointPositions = [
    // Day 1 - Bottom, near the house
    {'x': 0.22, 'y': 0.88},
    // Day 2 - Lower middle area
    {'x': 0.45, 'y': 0.74},
    // Day 3 - Middle area, slightly right
    {'x': 0.52, 'y': 0.60},
    // Day 4 - Upper middle, slightly left
    {'x': 0.42, 'y': 0.46},
    // Day 5 - Upper area, middle-right
    {'x': 0.55, 'y': 0.35},
    // Day 6 - Near top, right area
    {'x': 0.62, 'y': 0.24},
    // Day 7 - Castle/top destination (flag)
    {'x': 0.72, 'y': 0.14},
  ];

  static List<JourneyLevelModel> getLevels() {
    return [
      JourneyLevelModel(
        level: 1,
        requiredDays: 1,
        areaName: 'Mulai Perjalanan',
        emoji: '🏠',
        backgroundImage: 'assets/images/journey/denah.png',
      ),
      JourneyLevelModel(
        level: 2,
        requiredDays: 7,
        areaName: 'Hutan Pinus',
        emoji: '🌲',
        backgroundImage: 'assets/images/journey/denah.png',
      ),
      JourneyLevelModel(
        level: 3,
        requiredDays: 14,
        areaName: 'Dataran Tinggi',
        emoji: '⛰️',
        backgroundImage: 'assets/images/journey/denah.png',
      ),
      JourneyLevelModel(
        level: 4,
        requiredDays: 21,
        areaName: 'Puncak Gunung',
        emoji: '🏔',
        backgroundImage: 'assets/images/journey/denah.png',
      ),
      JourneyLevelModel(
        level: 5,
        requiredDays: 30,
        areaName: 'Kastil Ketenangan',
        emoji: '🏰',
        backgroundImage: 'assets/images/journey/denah.png',
      ),
    ];
  }

  static JourneyLevelModel getLevelForDay(int totalDays) {
    final levels = getLevels();
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

  /// Get which day in the current 7-day cycle the user is on (1-7)
  static int getDayInCurrentCycle(int totalDays) {
    if (totalDays <= 0) return 0;
    int dayInCycle = totalDays % 7;
    return dayInCycle == 0 ? 7 : dayInCycle;
  }

  /// Get the current cycle number (1-based)
  static int getCurrentCycle(int totalDays) {
    if (totalDays <= 0) return 1;
    return ((totalDays - 1) ~/ 7) + 1;
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
    final daysInCurrentLevel = totalDays - previousLevelDays;

    return daysInCurrentLevel;
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
