import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../data/journey_data.dart';
import 'journey_state.dart';

class JourneyCubit extends Cubit<JourneyState> {
  final _storage = GetStorage();

  JourneyCubit() : super(JourneyState.initial()) {
    _loadJourneyData();
  }

  void _loadJourneyData() {
    final total = _storage.read('totalFocusDays') ?? 5;
    final levelsList = JourneyData.getLevels();
    final current = JourneyData.getLevelForDay(total);
    
    emit(JourneyState(
      totalDays: total,
      levels: levelsList,
      currentLevel: current,
    ));
  }

  void addFocusDay() {
    final newDays = state.totalDays + 1;
    _storage.write('totalFocusDays', newDays);
    _updateJourneyState(newDays);
  }

  void setTotalDays(int days) {
    _storage.write('totalFocusDays', days);
    _updateJourneyState(days);
  }

  void _updateJourneyState(int days) {
    final current = JourneyData.getLevelForDay(days);
    emit(state.copyWith(
      totalDays: days,
      currentLevel: current,
    ));
  }

  int get currentLevelIndex {
    return state.levels.indexWhere((l) => l.level == state.currentLevel.level);
  }

  int get dayInCycle => JourneyData.getDayInCurrentCycle(state.totalDays);

  int get currentCycle => JourneyData.getCurrentCycle(state.totalDays);

  bool isLevelUnlocked(int levelNumber) {
    if (levelNumber == 1) return true;

    switch (levelNumber) {
      case 2:
        return state.totalDays >= 7;
      case 3:
        return state.totalDays >= 14;
      case 4:
        return state.totalDays >= 21;
      case 5:
        return state.totalDays >= 30;
      default:
        return false;
    }
  }

  bool isLevelCompleted(int levelNumber) {
    switch (levelNumber) {
      case 1:
        return state.totalDays >= 7;
      case 2:
        return state.totalDays >= 14;
      case 3:
        return state.totalDays >= 21;
      case 4:
        return state.totalDays >= 30;
      case 5:
        return state.totalDays >= 30;
      default:
        return false;
    }
  }

  bool isDayUnlocked(int day) {
    return day <= dayInCycle;
  }

  bool isDayCompleted(int day) {
    return day < dayInCycle;
  }

  bool isCurrentDay(int day) {
    return day == dayInCycle;
  }

  String getMotivationalMessage() {
    if (state.totalDays == 0) {
      return "Mulai perjalananmu hari ini!";
    } else if (state.totalDays < 7) {
      return "Terus fokus, ya!";
    } else if (state.totalDays < 14) {
      return "Hebat! Terus semangat!";
    } else if (state.totalDays < 21) {
      return "Kamu luar biasa!";
    } else if (state.totalDays < 30) {
      return "Hampir sampai tujuan!";
    } else {
      return "Kamu berhasil! 🎉";
    }
  }
}
