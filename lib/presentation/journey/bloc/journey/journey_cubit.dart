import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindfultech_app/core/database/database_helper.dart';
import 'package:mindfultech_app/core/network/dio_client.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'journey_state.dart';

class JourneyCubit extends Cubit<JourneyState> {
  final _storage = GetStorage();
  final _db = DatabaseHelper();
  final _authLocal = AuthLocalDataSource();

  static const String _keyTodayFocusSeconds = 'journey_todayFocusSeconds';
  static const String _keyTotalFocusDays = 'journey_totalFocusDays';
  static const String _keyStreakCount = 'journey_streakCount';
  static const String _keyLastFocusDate = 'journey_lastFocusDate';
  // ✅ FIX: Storage keys untuk emoji persistence
  static const String _keySelectedEmojiIndex = 'journey_selectedEmojiIndex';
  static const String _keySelectedEmojiDate = 'journey_selectedEmojiDate';
  static const String _keySelectedEmojiDayNumber = 'journey_selectedEmojiDayNumber';

  // ✅ PERBAIKAN 1: Konstruktor Tunggal
  JourneyCubit() : super(JourneyState.initial()) {
    _initializeAndLoadData();
  }

  String get _userId {
    final user = _authLocal.getUser();
    if (user != null && user.id > 0) {
      return user.id.toString();
    }
    final stored = _storage.read('userId');
    return stored?.toString() ?? 'guest';
  }

  Future<void> _initializeAndLoadData() async {
    emit(state.copyWith(isLoading: true));
    try {
      await _loadJourneyData();
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  // ==========================================
  // SYSTEM WAKTU FOKUS
  // ==========================================

  // ✅ PERBAIKAN 3: Hubungkan Sesi Timer Langsung ke Sistem Fokus
  void onTimerSessionEnded(int totalFocusSeconds) {
    if (totalFocusSeconds <= 0) return;
    print("Sesi fokus selesai: $totalFocusSeconds detik berhasil dicatat.");
    addFocusTime(totalFocusSeconds);
  }

  void addFocusTime(int seconds) {
    if (seconds <= 0) return;

    _checkAndHandleDayChange();

    final newFocusSeconds = state.todayFocusSeconds + seconds;
    final today = _getTodayDateString();

    _saveToStorage(todayFocusSeconds: newFocusSeconds);
    _saveToDatabase(todayFocusSeconds: newFocusSeconds, lastFocusDate: today);

    emit(state.copyWith(
      todayFocusSeconds: newFocusSeconds,
      lastFocusDate: today,
      isLoading: false,
    ));

    // Cek kontribusi ke streak harian
    if (newFocusSeconds >= state.dailyTargetSeconds) {
      if (state.streakCount == 0 || _shouldIncrementStreak()) {
        _incrementStreak();
      }
    }
  }

  void resetDailyFocus() {
    _saveToStorage(todayFocusSeconds: 0);
    _db.resetDailyFocus(_userId);
    emit(state.copyWith(todayFocusSeconds: 0));
  }

  bool get isDailyTargetReached => state.isDailyTargetReached;
  int get dailyProgressPercent => (state.dailyProgress * 100).round();

  // ==========================================
  // STREAK SYSTEM
  // ==========================================

  int get streakCount => state.streakCount;

  bool _shouldIncrementStreak() {
    final today = _getTodayDateString();
    return state.lastFocusDate != today;
  }

  void _incrementStreak() {
    final newStreak = state.streakCount + 1;
    final today = _getTodayDateString();

    _saveToStorage(streakCount: newStreak, lastFocusDate: today);
    _db.incrementStreak(_userId, newStreak);

    emit(state.copyWith(
      streakCount: newStreak,
      lastFocusDate: today,
    ));
  }

  void resetStreak() {
    _saveToStorage(streakCount: 0);
    _db.resetStreak(_userId);
    emit(state.copyWith(streakCount: 0));
  }

  // ==========================================
  // JOURNEY SYSTEM (KELIPATAN 5 HARI)
  // ==========================================

  /// Dipanggil dari TimerFinishedPage saat klik "Lanjut"
  /// flow: fokusTime bertambah, totalDays HANYA bertambah jika SEMUA task selesai
  Future<void> completeLevelSession(int sessionDuration) async {
    final userId = _userId;
    final today = _getTodayDateString();

    // 1. Simpan fokus time hari ini
    final newFocusSeconds = state.todayFocusSeconds + sessionDuration;
    _saveToStorage(todayFocusSeconds: newFocusSeconds, lastFocusDate: today);
    await _db.updateJourneyProgress(
      userId: userId,
      todayFocusSeconds: newFocusSeconds,
      lastFocusDate: today,
    );

    // 2. Cek day change
    _checkAndHandleDayChange();

    // 3. Cek apakah semua task hari ini sudah selesai
    final completedTasks = await _db.getCompletedTasksCountToday(userId);
    final totalTasks = await _db.getTotalTasksCountToday(userId);
    final allTasksCompleted = totalTasks > 0 && completedTasks >= totalTasks;
    final lastDayCompleted = await _db.getLastDayCompletedDate(userId);

    if (allTasksCompleted && lastDayCompleted != today) {
      // Update totalDays dan lastDayCompleted
      final newDays = state.totalDays + 1;
      final newLevel = JourneyData.getLevelForDay(newDays);

      await _db.incrementTotalDays(userId, newDays, newLevel.level);
      await _db.updateLastDayCompleted(userId, today);
      _saveToStorage(totalDays: newDays, lastFocusDate: today);

      emit(state.copyWith(
        totalDays: newDays,
        currentLevel: newLevel,
        lastFocusDate: today,
        isLoading: false,
        moveMindy: true,
        animatedNode: newDays,
      ));
      emit(state.copyWith(moveMindy: false));
    }

    // 4. Emit state dengan focus seconds yang sudah diupdate
    emit(state.copyWith(
      todayFocusSeconds: newFocusSeconds,
      isLoading: false,
    ));
  }

  bool isLevelUnlocked(int levelNumber) {
    if (levelNumber == 1) return true;
    return state.totalDays >= ((levelNumber - 1) * 5);
  }

  bool isLevelCompleted(int levelNumber) {
    return state.totalDays >= (levelNumber * 5);
  }

  int get dayInCycle => ((state.totalDays - 1) % 5) + 1;

  String getMotivationalMessage() {
    final days = state.totalDays;
    if (days == 0) return "Mulai fokus pertamamu hari ini!";
    
    final progressInLevel = ((days - 1) % 5) + 1;
    
    switch (progressInLevel) {
      case 1:
        return "Awal level baru! Semangat ya!";
      case 2:
        return "Hari kedua, pertahankan fokusmu!";
      case 3:
        return "Hebat, kamu sudah setengah jalan!";
      case 4:
        return "Satu hari lagi menuju kelulusan level!";
      case 5:
        return "Hari terakhir di level ini! Yuk selesaikan!";
      default:
        return "Jangan berhenti disini, ya.";
    }
  }

  // ==========================================
  // DATA PERSISTENCE & SYNC
  // ==========================================

  Future<void> _loadJourneyData() async {
    final userId = _userId;
    final today = _getTodayDateString();

    final dbProgress = await _db.getOrCreateJourneyProgress(userId);

    int totalDays = dbProgress.totalDays;
    int streak = dbProgress.streakCount;
    int todayFocusSeconds = dbProgress.todayFocusSeconds;
    int dailyTargetSeconds = dbProgress.dailyTargetSeconds;
    String lastDate = dbProgress.lastFocusDate ?? '';

    // Deteksi hari baru sebelum sinkronisasi cadangan GetStorage
    if (lastDate.isNotEmpty && lastDate != today) {
      if (todayFocusSeconds < dailyTargetSeconds) {
        streak = 0;
        await _db.resetStreak(userId);
        _saveToStorage(streakCount: 0);
      }
      todayFocusSeconds = 0;
      await _db.resetDailyFocus(userId);
      _saveToStorage(todayFocusSeconds: 0);
    } else {
      // Ambil data dari GetStorage HANYA jika hari-nya masih sama
      final storageTodayFocus = _storage.read(_keyTodayFocusSeconds);
      final storageTotalDays = _storage.read(_keyTotalFocusDays);
      final storageStreak = _storage.read(_keyStreakCount);
      final storageLastDate = _storage.read(_keyLastFocusDate);

      if (storageTodayFocus is int) todayFocusSeconds = storageTodayFocus;
      if (storageTotalDays is int) totalDays = storageTotalDays;
      if (storageStreak is int) streak = storageStreak;
      if (storageLastDate is String) lastDate = storageLastDate;
    }

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

  void _checkAndHandleDayChange() {
    final today = _getTodayDateString();
    if (state.lastFocusDate.isNotEmpty && state.lastFocusDate != today) {
      if (state.todayFocusSeconds < state.dailyTargetSeconds) {
        resetStreak();
      }
      resetDailyFocus();
    }
  }

  void saveEmoji(int index) {
    emit(state.copyWith(selectedEmojiIndex: index));
  }

  /// ✅ Simpan emoji + buat focus session record di database
  ///    Dipanggil dari TimerFinishedPage saat user pilih emoji
  ///    @param emojiIndex Index emoji yang dipilih (0-5)
  ///    @param durationSeconds Durasi sesi fokus dalam detik
  ///    @param dayNumber Slot posisi emoji (0-5), dihitung otomatis dari totalDays
  Future<void> saveEmojiWithSession(int emojiIndex, int durationSeconds, {int? dayNumber}) async {
    // ✅ FIX: Hitung dayNumber dengan formula yang benar
    //    - totalDays = 0 (belum ada sesi): slot 0
    //    - totalDays = 1 (1 sesi selesai): slot 1 (karena sesi sebelumnya di slot 0)
    //    - dst...
    final int effectiveDayNumber = dayNumber ?? (state.totalDays % 6);

    // 1. Update state memory
    emit(state.copyWith(selectedEmojiIndex: emojiIndex));

    // 2. Simpan ke GetStorage
    _storage.write(_keySelectedEmojiIndex, emojiIndex);
    _storage.write(_keySelectedEmojiDate, _getTodayDateString());
    _storage.write(_keySelectedEmojiDayNumber, effectiveDayNumber);

    // 3. Insert focus session ke database
    final session = FocusSessionModel(
      userId: _userId,
      durationSeconds: durationSeconds,
      emotion: EmotionTypeExtension.fromValue(emojiIndex),
      createdAt: DateTime.now().toIso8601String(),
      dayNumber: effectiveDayNumber,
    );
    await _db.insertFocusSession(session);

    // 4. Sync ke Laravel API (POST /api/focus/sync)
    _syncFocusSessionToServer(durationSeconds, emojiIndex);

    // 5. ✅ FIX: Refresh emotion data di HomepageCubit
    _refreshHomepageEmotionData();
  }

  /// Helper untuk refresh emotion data
  void _refreshHomepageEmotionData() {
    _storage.write('journey_emojiUpdated', DateTime.now().millisecondsSinceEpoch);
  }

  /// Sync focus session ke Laravel API (POST /api/focus/sync)
  void _syncFocusSessionToServer(int durationSeconds, int emojiIndex) {
    try {
      final dioClient = DioClient();
      final emotionLabels = ['cloud1', 'cloud2', 'cloud3', 'cloud4', 'cloud5', 'cloud6'];
      final emotion = emojiIndex >= 0 && emojiIndex < emotionLabels.length
          ? emotionLabels[emojiIndex]
          : null;

      dioClient.post('/focus/sync', data: {
        'duration': durationSeconds,
        'emotion': emotion,
        'day_number': state.totalDays % 6,
      }).then((response) {
        if (response.statusCode == 200 && response.data is Map) {
          final data = response.data as Map<String, dynamic>;
          if (data.containsKey('journey')) {
            final journey = data['journey'] as Map<String, dynamic>;
            _storage.write(_keyTotalFocusDays, journey['total_focus_days']);
          }
          if (data.containsKey('streak') && data['streak'] != null) {
            final streakData = data['streak'] as Map<String, dynamic>;
            _storage.write(_keyStreakCount, streakData['current_streak']);
          }
        }
      }).catchError((error) {
        // Gagal sync ke server - data tetap aman di lokal
        // Akan sync nanti melalui SyncManager
      });
    } catch (_) {
      // Gagal sync ke server
    }
  }

  String _getTodayDateString() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  void _saveToStorage({int? todayFocusSeconds, int? totalDays, int? streakCount, String? lastFocusDate}) {
    if (todayFocusSeconds != null) _storage.write(_keyTodayFocusSeconds, todayFocusSeconds);
    if (totalDays != null) _storage.write(_keyTotalFocusDays, totalDays);
    if (streakCount != null) _storage.write(_keyStreakCount, streakCount);
    if (lastFocusDate != null) _storage.write(_keyLastFocusDate, lastFocusDate);
  }

  Future<void> _saveToDatabase({int? todayFocusSeconds, int? totalDays, int? streakCount, String? lastFocusDate, int? currentLevel}) async {
    await _db.updateJourneyProgress(
      userId: _userId,
      todayFocusSeconds: todayFocusSeconds,
      totalDays: totalDays,
      streakCount: streakCount,
      lastFocusDate: lastFocusDate,
      currentLevel: currentLevel,
    );
  }
}