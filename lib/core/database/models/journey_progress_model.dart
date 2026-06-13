/// Model untuk journey progress yang disimpan di database
/// ✅ FIXED: All fields have safe defaults - no null values
class JourneyProgress {
  final int? id;
  final String userId;
  final int totalDays;
  final int todayFocusSeconds;
  final int dailyTargetSeconds;
  final int streakCount;
  final String? lastFocusDate;
  final int currentLevel;
  final String createdAt;
  final String updatedAt;

  JourneyProgress({
    this.id,
    required this.userId,
    this.totalDays = 0,
    this.todayFocusSeconds = 0,
    this.dailyTargetSeconds = 300,
    this.streakCount = 0,
    this.lastFocusDate,
    this.currentLevel = 1,
    required this.createdAt,
    required this.updatedAt,
  });

  /// ✅ SAFE: Safe getters with default values
  int get safeTotalDays => totalDays;
  int get safeTodayFocusSeconds => todayFocusSeconds;
  int get safeDailyTargetSeconds => dailyTargetSeconds > 0 ? dailyTargetSeconds : 300;
  int get safeStreakCount => streakCount;
  int get safeCurrentLevel => currentLevel > 0 ? currentLevel : 1;
  String get safeLastFocusDate => lastFocusDate ?? '';

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'totalDays': totalDays,
      'todayFocusSeconds': todayFocusSeconds,
      'dailyTargetSeconds': dailyTargetSeconds,
      'streakCount': streakCount,
      'lastFocusDate': lastFocusDate,
      'currentLevel': currentLevel,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory JourneyProgress.fromMap(Map<String, dynamic> map) {
    // ✅ SAFE: All values extracted with default fallbacks
    return JourneyProgress(
      id: map['id'] as int?,
      userId: map['userId'] as String? ?? 'default_user',
      totalDays: (map['totalDays'] as int?) ?? 0,
      todayFocusSeconds: (map['todayFocusSeconds'] as int?) ?? 0,
      dailyTargetSeconds: (map['dailyTargetSeconds'] as int?) ?? 300,
      streakCount: (map['streakCount'] as int?) ?? 0,
      lastFocusDate: map['lastFocusDate'] as String?,
      currentLevel: (map['currentLevel'] as int?) ?? 1,
      createdAt: (map['createdAt'] as String?) ?? DateTime.now().toIso8601String(),
      updatedAt: (map['updatedAt'] as String?) ?? DateTime.now().toIso8601String(),
    );
  }

  JourneyProgress copyWith({
    int? id,
    String? userId,
    int? totalDays,
    int? todayFocusSeconds,
    int? dailyTargetSeconds,
    int? streakCount,
    String? lastFocusDate,
    int? currentLevel,
    String? createdAt,
    String? updatedAt,
  }) {
    return JourneyProgress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      totalDays: totalDays ?? this.totalDays,
      todayFocusSeconds: todayFocusSeconds ?? this.todayFocusSeconds,
      dailyTargetSeconds: dailyTargetSeconds ?? this.dailyTargetSeconds,
      streakCount: streakCount ?? this.streakCount,
      lastFocusDate: lastFocusDate ?? this.lastFocusDate,
      currentLevel: currentLevel ?? this.currentLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
