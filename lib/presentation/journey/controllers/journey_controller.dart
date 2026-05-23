import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/journey_level_model.dart';
import '../data/journey_data.dart';

class JourneyController extends GetxController {
  final _storage = GetStorage();

  final RxInt totalDays = 0.obs;
  final RxList<JourneyLevelModel> levels = <JourneyLevelModel>[].obs;
  final Rx<JourneyLevelModel> currentLevel = JourneyLevelModel(
    level: 1,
    requiredDays: 1,
    areaName: 'Mulai Perjalanan',
    emoji: '🏠',
    backgroundImage: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    _loadJourneyData();
  }

  void _loadJourneyData() {
    totalDays.value = _storage.read('totalFocusDays') ?? 5;
    levels.value = JourneyData.getLevels();
    _updateCurrentLevel();
  }

  void _updateCurrentLevel() {
    currentLevel.value = JourneyData.getLevelForDay(totalDays.value);
  }

  void addFocusDay() {
    totalDays.value++;
    _storage.write('totalFocusDays', totalDays.value);
    _updateCurrentLevel();
    levels.refresh();
  }

  void setTotalDays(int days) {
    totalDays.value = days;
    _storage.write('totalFocusDays', days);
    _updateCurrentLevel();
    levels.refresh();
  }

  int get currentLevelIndex {
    return levels.indexWhere((l) => l.level == currentLevel.value.level);
  }

  /// Which day (1-7) in the current 7-day map cycle
  int get dayInCycle => JourneyData.getDayInCurrentCycle(totalDays.value);

  /// Which cycle the user is on (1-based)
  int get currentCycle => JourneyData.getCurrentCycle(totalDays.value);

  bool isLevelUnlocked(int levelNumber) {
    if (levelNumber == 1) return true;

    switch (levelNumber) {
      case 2:
        return totalDays.value >= 7;
      case 3:
        return totalDays.value >= 14;
      case 4:
        return totalDays.value >= 21;
      case 5:
        return totalDays.value >= 30;
      default:
        return false;
    }
  }

  bool isLevelCompleted(int levelNumber) {
    switch (levelNumber) {
      case 1:
        return totalDays.value >= 7;
      case 2:
        return totalDays.value >= 14;
      case 3:
        return totalDays.value >= 21;
      case 4:
        return totalDays.value >= 30;
      case 5:
        return totalDays.value >= 30;
      default:
        return false;
    }
  }

  /// Is a specific day on the map unlocked (completed or current)
  bool isDayUnlocked(int day) {
    return day <= dayInCycle;
  }

  /// Is a specific day completed (past days)
  bool isDayCompleted(int day) {
    return day < dayInCycle;
  }

  /// Is the day the current active day
  bool isCurrentDay(int day) {
    return day == dayInCycle;
  }

  String getMotivationalMessage() {
    if (totalDays.value == 0) {
      return "Mulai perjalananmu hari ini!";
    } else if (totalDays.value < 7) {
      return "Terus fokus, ya!";
    } else if (totalDays.value < 14) {
      return "Hebat! Terus semangat!";
    } else if (totalDays.value < 21) {
      return "Kamu luar biasa!";
    } else if (totalDays.value < 30) {
      return "Hampir sampai tujuan!";
    } else {
      return "Kamu berhasil! 🎉";
    }
  }
}
