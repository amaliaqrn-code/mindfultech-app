import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindfultech_app/core/database/database_helper.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'journey_state.dart';

class JourneyCubit extends Cubit<JourneyState> {
  final _storage = GetStorage();
  final _db = DatabaseHelper();
  final _authLocal = AuthLocalDataSource();

  // Storage keys (for GetStorage backup)
  static const String _keyTodayFocusSeconds = 'journey_todayFocusSeconds';
  static const String _keyTotalFocusDays = 'journey_totalFocusDays';
  static const String _keyStreakCount = 'journey_streakCount';
  static const String _keyLastFocusDate = 'journey_lastFocusDate';

  /// Get the current user's ID as a string for database isolation.
  /// Reads from AuthLocalDataSource (the single source of truth for auth).
  /// Falls back to a session-unique key so anonymous users don't share data.
  String get _userId {
    final user = _authLocal.getUser();
    if (user != null && user.id > 0) {
      return user.id.toString();
    }
    // Fallback: use a key stored in GetStorage that is cleared on logout
    final stored = _storage.read('userId');
    return stored?.toString() ?? 'guest';
  }

  JourneyCubit() : super(JourneyState.initial()) {
    // Load data asynchronously after cubit is created
    _initializeAndLoadData();
  }

  /// Initialize and load data - called from constructor
  Future<void> _initializeAndLoadData() async {
    // Emit loading state first
    emit(state.copyWith(isLoading: true));

    try {
      await _loadJourneyData();
    } catch (e) {
      // On error, use default state but with data loaded flag
      emit(state.copyWith(isLoading: false));
    }
  }

  // =========================
  // DAILY FOCUS SYSTEM
  // =========================

  /// Add focus time from a completed timer session
  void addFocusTime(int seconds) {
    if (seconds <= 0) return;

    // Check for day change BEFORE updating
    _checkAndHandleDayChange();

    final newFocusSeconds = state.todayFocusSeconds + seconds;
    final today = _getTodayDateString();

    // Update both SQLite and GetStorage
    _saveToStorage(todayFocusSeconds: newFocusSeconds);
    _saveToDatabase(todayFocusSeconds: newFocusSeconds, lastFocusDate: today);

    emit(state.copyWith(
      todayFocusSeconds: newFocusSeconds,
      lastFocusDate: today,
      isLoading: false,
    ));

    // Check if daily target is reached for the FIRST time today
    // Only increment streak if not already done today
    if (newFocusSeconds >= state.dailyTargetSeconds) {
      final yesterdayStreak = state.streakCount;
      // Only increment if this is a new day or streak hasn't been incremented today
      if (yesterdayStreak == 0 || _shouldIncrementStreak()) {
        _incrementStreak();
      }
    }
  }

  /// Reset daily focus (called at start of new day)
  void resetDailyFocus() {
    _saveToStorage(todayFocusSeconds: 0);
    _db.resetDailyFocus(_userId);

    emit(state.copyWith(
      todayFocusSeconds: 0,
      isLoading: false,
    ));
  }

  /// Check if daily target (5 minutes) is reached
  bool get isDailyTargetReached => state.isDailyTargetReached;

  /// Get today's focus progress in percentage (0-100)
  int get dailyProgressPercent => (state.dailyProgress * 100).round();

  /// Get formatted focus time string (e.g., "3m 45s")
  String get formattedTodayFocus {
    final minutes = state.todayFocusSeconds ~/ 60;
    final seconds = state.todayFocusSeconds % 60;
    if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    }
    return '${seconds}s';
  }

  /// Get remaining time to reach daily target
  String get formattedRemainingTime {
    final remaining = state.remainingSecondsToTarget;
    final minutes = remaining ~/ 60;
    final seconds = remaining % 60;
    if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    }
    return '${seconds}s';
  }

  // =========================
  // STREAK SYSTEM
  // =========================

  /// Get current streak count - SAFE getter
  int get streakCount => state.streakCount;

  /// Check if streak should be incremented (new day and daily target reached)
  bool _shouldIncrementStreak() {
    final today = _getTodayDateString();
    return state.lastFocusDate != today;
  }

  /// Increment streak by 1 (called when daily target is reached)
  void _incrementStreak() {
    final newStreak = state.streakCount + 1;
    final today = _getTodayDateString();

    _saveToStorage(streakCount: newStreak, lastFocusDate: today);
    _db.incrementStreak(_userId, newStreak);

    emit(state.copyWith(
      streakCount: newStreak,
      lastFocusDate: today,
      isLoading: false,
    ));
  }

  /// Reset streak to 0 (called when user fails to reach daily target)
  void resetStreak() {
    _saveToStorage(streakCount: 0);
    _db.resetStreak(_userId);

    emit(state.copyWith(
      streakCount: 0,
      isLoading: false,
    ));
  }

  /// Update streak based on daily completion status
  void updateStreak() {
    _checkAndHandleDayChange();

    if (state.isDailyTargetReached) {
      final today = _getTodayDateString();
      if (state.lastFocusDate != today) {
        _incrementStreak();
      }
    }
  }

  /// Check if daily target is reached and handle completion
  void checkDailyCompletion() {
    if (state.isDailyTargetReached) {
      _incrementStreak();
    }
  }

  // =========================
  // JOURNEY SYSTEM
  // =========================

  /// Add a focus day to journey progress
  void addFocusDay() {
    final newDays = state.totalDays + 1;
    final newLevel = JourneyData.getLevelForDay(newDays);
    final today = _getTodayDateString();

    _saveToStorage(totalDays: newDays, lastFocusDate: today);
    _db.incrementTotalDays(_userId, newDays, newLevel.level);

    emit(state.copyWith(
      totalDays: newDays,
      currentLevel: newLevel,
      lastFocusDate: today,
      isLoading: false,
    ));
  }

  /// Set total focus days (for initialization)
  void setTotalDays(int days) {
    final newLevel = JourneyData.getLevelForDay(days);
    final today = _getTodayDateString();

    _saveToStorage(totalDays: days, lastFocusDate: today);
    _db.incrementTotalDays(_userId, days, newLevel.level);

    emit(state.copyWith(
      totalDays: days,
      currentLevel: newLevel,
      lastFocusDate: today,
      isLoading: false,
    ));
  }

  /// Complete a level session - handles all updates in one call
  /// Called when user completes a focus session and taps "Lanjut" on TimerFinishedPage.
  /// Always increments totalDays. Streak increment only if daily target is met.
  Future<void> completeLevelSession() async {
    final userId = _userId; // Capture once — reads from AuthLocalDataSource
    final today = _getTodayDateString();
    final newDays = state.totalDays + 1;
    final newLevel = JourneyData.getLevelForDay(newDays);

    // 1. Always increment total days (every completed session = 1 day)
    _saveToStorage(totalDays: newDays, lastFocusDate: today);

    // 2. Check if streak should be incremented
    // Streak increments only when daily focus target is reached for the first time today
    int newStreak = state.streakCount;
    if (state.isDailyTargetReached && state.lastFocusDate != today) {
      newStreak = state.streakCount + 1;
      _saveToStorage(streakCount: newStreak);
      await _db.incrementStreak(userId, newStreak);
    }

    // 3. Save total days and level to SQLite database
    await _db.incrementTotalDays(userId, newDays, newLevel.level);

    // 4. Emit new state
    emit(state.copyWith(
      totalDays: newDays,
      currentLevel: newLevel,
      lastFocusDate: today,
      streakCount: newStreak,
      isLoading: false,
    ));
  }

  /// Check if current totalDays is at a milestone (every 5 days)
  bool get isAtMilestone => state.totalDays % 5 == 0;

  /// Get next milestone day
  int get nextMilestone {
    final currentMilestone = (state.totalDays / 5).floor() * 5;
    return currentMilestone + 5;
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

  bool get isJourneyComplete => state.totalDays >= JourneyData.maxDays;

  bool get shouldNavigateToReward => isJourneyComplete;

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

  // =========================
  // DATA PERSISTENCE
  // =========================

  /// Load journey data from database and GetStorage
  Future<void> _loadJourneyData() async {
    final userId = _userId; // Capture once from AuthLocalDataSource
    final today = _getTodayDateString();

    // Load from SQLite first (primary source)
    final dbProgress = await _db.getOrCreateJourneyProgress(userId);

    // Get values with safe defaults (no null)
    int totalDays = dbProgress.totalDays;
    int streak = dbProgress.streakCount;
    int todayFocusSeconds = dbProgress.todayFocusSeconds;
    int dailyTargetSeconds = dbProgress.dailyTargetSeconds;
    String lastDate = dbProgress.lastFocusDate ?? '';

    // Handle day change detection
    // Streak only resets if user didn't complete focus in the previous day
    if (lastDate.isNotEmpty && lastDate != today) {
      // If NOT reached yesterday's target, reset streak to 0
      if (todayFocusSeconds < dailyTargetSeconds) {
        streak = 0;
        await _db.resetStreak(userId);
        _saveToStorage(streakCount: 0);
      }

      // Reset daily focus for new day
      todayFocusSeconds = 0;
      await _db.resetDailyFocus(userId);
      _saveToStorage(todayFocusSeconds: 0);
    }

    // Also sync with GetStorage as backup
    _syncFromGetStorage(
      todayFocusSeconds: todayFocusSeconds,
      totalDays: totalDays,
      streakCount: streak,
      lastFocusDate: lastDate,
    );

    final levelsList = JourneyData.getLevels();
    final current = JourneyData.getLevelForDay(totalDays);

    emit(JourneyState(
      todayFocusSeconds: todayFocusSeconds,
      dailyTargetSeconds: dailyTargetSeconds,
      totalDays: totalDays,
      levels: levelsList,
      currentLevel: current,
      streakCount: streak,
      lastFocusDate: lastDate,
      isLoading: false,
    ));
  }

  /// Sync values from GetStorage (backup source)
  void _syncFromGetStorage({
    required int todayFocusSeconds,
    required int totalDays,
    required int streakCount,
    required String lastFocusDate,
  }) {
    // Read from GetStorage and use if valid
    final storageTodayFocus = _storage.read(_keyTodayFocusSeconds);
    final storageTotalDays = _storage.read(_keyTotalFocusDays);
    final storageStreak = _storage.read(_keyStreakCount);
    final storageLastDate = _storage.read(_keyLastFocusDate);

    // Use storage values if they exist and are valid
    if (storageTodayFocus != null && storageTodayFocus is int) {
      todayFocusSeconds = storageTodayFocus;
    }
    if (storageTotalDays != null && storageTotalDays is int) {
      totalDays = storageTotalDays;
    }
    if (storageStreak != null && storageStreak is int) {
      streakCount = storageStreak;
    }
    if (storageLastDate != null && storageLastDate is String) {
      lastFocusDate = storageLastDate;
    }
  }

  /// Force reload data from database
  Future<void> reloadData() async {
    emit(state.copyWith(isLoading: true));
    await _loadJourneyData();
  }

  // =========================
  // STORAGE HELPERS
  // =========================

  void _saveToStorage({
    int? todayFocusSeconds,
    int? totalDays,
    int? streakCount,
    String? lastFocusDate,
  }) {
    if (todayFocusSeconds != null) {
      _storage.write(_keyTodayFocusSeconds, todayFocusSeconds);
    }
    if (totalDays != null) {
      _storage.write(_keyTotalFocusDays, totalDays);
    }
    if (streakCount != null) {
      _storage.write(_keyStreakCount, streakCount);
    }
    if (lastFocusDate != null) {
      _storage.write(_keyLastFocusDate, lastFocusDate);
    }
  }

  Future<void> _saveToDatabase({
    int? todayFocusSeconds,
    int? totalDays,
    int? streakCount,
    String? lastFocusDate,
    int? currentLevel,
  }) async {
    await _db.updateJourneyProgress(
      userId: _userId,
      todayFocusSeconds: todayFocusSeconds,
      totalDays: totalDays,
      streakCount: streakCount,
      lastFocusDate: lastFocusDate,
      currentLevel: currentLevel,
    );
  }

  // =========================
  // DAY CHANGE HANDLING
  // =========================

  void _checkAndHandleDayChange() {
    final today = _getTodayDateString();
    final lastDate = state.lastFocusDate;

    if (lastDate.isEmpty) {
      return;
    }

    if (lastDate != today) {
      // New day detected
      // Check if yesterday's daily target was reached
      if (state.todayFocusSeconds < state.dailyTargetSeconds) {
        // User didn't reach daily target yesterday - reset streak
        resetStreak();
      }
      // Reset daily focus for new day
      resetDailyFocus();
    }
  }

  String _getTodayDateString() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  // =========================
  // SYNC WITH TIMER
  // =========================

  void onTimerSessionEnded(int sessionDurationSeconds) {
    addFocusTime(sessionDurationSeconds);
  }

  void onAllTimerSessionsCompleted() {
    if (state.isDailyTargetReached) {
      _incrementStreak();
    }
  }
}
