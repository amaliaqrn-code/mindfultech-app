String _parseString(dynamic value, {String defaultValue = ''}) {
  if (value == null) return defaultValue;
  if (value is String) return value;
  return value.toString();
}

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
  final String? lastDayCompleted;
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
    this.lastDayCompleted,
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
      'lastDayCompleted': lastDayCompleted,
      'currentLevel': currentLevel,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory JourneyProgress.fromMap(Map<String, dynamic> map) {
    return JourneyProgress(
      id: map['id'] as int?,
      userId: _parseString(map['userId'], defaultValue: 'default_user'),
      totalDays: (map['totalDays'] as int?) ?? 0,
      todayFocusSeconds: (map['todayFocusSeconds'] as int?) ?? 0,
      dailyTargetSeconds: (map['dailyTargetSeconds'] as int?) ?? 300,
      streakCount: (map['streakCount'] as int?) ?? 0,
      lastFocusDate: map['lastFocusDate'] != null ? _parseString(map['lastFocusDate']) : null,
      lastDayCompleted: map['lastDayCompleted'] != null ? _parseString(map['lastDayCompleted']) : null,
      currentLevel: (map['currentLevel'] as int?) ?? 1,
      createdAt: map['createdAt'] != null ? _parseString(map['createdAt']) : DateTime.now().toIso8601String(),
      updatedAt: map['updatedAt'] != null ? _parseString(map['updatedAt']) : DateTime.now().toIso8601String(),
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
    String? lastDayCompleted,
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
      lastDayCompleted: lastDayCompleted ?? this.lastDayCompleted,
      currentLevel: currentLevel ?? this.currentLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
