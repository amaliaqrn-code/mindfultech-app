import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/core/database/database_helper.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_state.dart';
import 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  final AuthLocalDataSource _authLocalDataSource;
  final DatabaseHelper _databaseHelper;

  HomepageCubit({
    AuthLocalDataSource? authLocalDataSource,
    DatabaseHelper? databaseHelper,
  })  : _authLocalDataSource = authLocalDataSource ?? AuthLocalDataSource(),
        _databaseHelper = databaseHelper ?? DatabaseHelper(),
        super(const HomepageState(userLevel: 1, mascotGreeting: 'Yuk mulai hari produktif bareng Mindy!')) {
    _updateMascotText();
  }

  void _updateMascotText() {
    final config = HomepageState.levelConfigs[state.userLevel];
    if (config != null) {
      emit(state.copyWith(mascotGreeting: config.mascotText));
    }
  }

  void setUserLevel(int level) {
    if (level >= 1 && level <= 6) {
      emit(state.copyWith(userLevel: level));
      _updateMascotText();
    }
  }

  /// Sync with JourneyCubit state (null-safe)
  void syncWithJourney(JourneyState? journeyState) {
    if (journeyState == null) return;

    // Update user level based on journey level
    final journeyLevel = journeyState.currentLevel.level;
    if (journeyLevel != state.userLevel) {
      setUserLevel(journeyLevel);
    }
  }

  /// Get streak count from JourneyCubit (with fallback)
  int getStreakFromJourney(JourneyState? journeyState) {
    return journeyState?.streakCount ?? 0;
  }

  /// Get formatted streak text for display (null-safe)
  /// ✅ FIXED: Use real data from JourneyState
  String getStreakText(JourneyState? journeyState) {
    if (journeyState == null) {
      return '0 / 0 hari';
    }
    final streak = journeyState.streakCount;
    final totalDays = journeyState.totalDays;
    return '$streak / $totalDays hari';
  }

  /// Get level text for display (null-safe)
  /// ✅ FIXED: Use real data from JourneyState
  String getLevelText(JourneyState? journeyState) {
    if (journeyState == null) {
      return 'LEVEL 01';
    }
    final levelNum = journeyState.currentLevel.level;
    return 'LEVEL ${levelNum.toString().padLeft(2, '0')}';
  }

  /// Load emotion session count from database
  Future<void> loadEmotionData() async {
    try {
      final user = _authLocalDataSource.getUser();
      if (user == null) return;

      final userId = user.id.toString();
      final uniqueEmotions = await _databaseHelper.getUniqueEmotionsUsed(userId);
      final sessionCount = await _databaseHelper.getFocusSessionCount(userId);

      emit(state.copyWith(
        emotionSessionCount: uniqueEmotions.length,
        totalFocusSessions: sessionCount,
      ));
    } catch (_) {
      // Ignore errors, keep default values
    }
  }

  /// Get current user ID
  String? getCurrentUserId() {
    final user = _authLocalDataSource.getUser();
    return user?.id.toString();
  }
}
