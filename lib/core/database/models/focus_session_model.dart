/// Enum untuk emotion type setelah sesi fokus selesai
enum EmotionType {
  cloud1, // Sangat Bahagia
  cloud2, // Bahagia
  cloud3, // Tenang
  cloud4, // Lelah
  cloud5, // Sedih
  cloud6, // Frustasi
}

extension EmotionTypeExtension on EmotionType {
  String get displayName {
    switch (this) {
      case EmotionType.cloud1:
        return 'Sangat Bahagia';
      case EmotionType.cloud2:
        return 'Bahagia';
      case EmotionType.cloud3:
        return 'Tenang';
      case EmotionType.cloud4:
        return 'Lelah';
      case EmotionType.cloud5:
        return 'Sedih';
      case EmotionType.cloud6:
        return 'Frustasi';
    }
  }

  int get value {
    switch (this) {
      case EmotionType.cloud1:
        return 0;
      case EmotionType.cloud2:
        return 1;
      case EmotionType.cloud3:
        return 2;
      case EmotionType.cloud4:
        return 3;
      case EmotionType.cloud5:
        return 4;
      case EmotionType.cloud6:
        return 5;
    }
  }

  static EmotionType fromValue(int value) {
    switch (value) {
      case 0:
        return EmotionType.cloud1;
      case 1:
        return EmotionType.cloud2;
      case 2:
        return EmotionType.cloud3;
      case 3:
        return EmotionType.cloud4;
      case 4:
        return EmotionType.cloud5;
      case 5:
        return EmotionType.cloud6;
      default:
        return EmotionType.cloud3;
    }
  }

  /// Get emoji asset path
  String get assetPath {
    switch (this) {
      case EmotionType.cloud1:
        return 'assets/icon/timerpage/Cloud1.png';
      case EmotionType.cloud2:
        return 'assets/icon/timerpage/Cloud2.png';
      case EmotionType.cloud3:
        return 'assets/icon/timerpage/Cloud3.png';
      case EmotionType.cloud4:
        return 'assets/icon/timerpage/Cloud4.png';
      case EmotionType.cloud5:
        return 'assets/icon/timerpage/Cloud5.png';
      case EmotionType.cloud6:
        return 'assets/icon/timerpage/Cloud6.png';
    }
  }
}

/// Model untuk focus session log yang disimpan di database
/// Menyimpan data setelah user menyelesaikan sesi fokus di TimerFinishedPage
class FocusSessionModel {
  final int? id;
  final String? taskId;
  final String userId;
  final int durationSeconds;
  final EmotionType emotion;
  final String createdAt;

  FocusSessionModel({
    this.id,
    this.taskId,
    required this.userId,
    required this.durationSeconds,
    required this.emotion,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'taskId': taskId,
      'userId': userId,
      'durationSeconds': durationSeconds,
      'emotion': emotion.value,
      'createdAt': createdAt,
    };
  }

  factory FocusSessionModel.fromMap(Map<String, dynamic> map) {
    return FocusSessionModel(
      id: map['id'] as int?,
      taskId: map['taskId'] as String?,
      userId: map['userId'] as String,
      durationSeconds: map['durationSeconds'] as int? ?? 0,
      emotion: EmotionTypeExtension.fromValue(map['emotion'] as int? ?? 2),
      createdAt: map['createdAt'] as String,
    );
  }

  FocusSessionModel copyWith({
    int? id,
    String? taskId,
    String? userId,
    int? durationSeconds,
    EmotionType? emotion,
    String? createdAt,
  }) {
    return FocusSessionModel(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      userId: userId ?? this.userId,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      emotion: emotion ?? this.emotion,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Get formatted duration string
  String get formattedDuration {
    final minutes = durationSeconds ~/ 60;
    final seconds = durationSeconds % 60;
    if (minutes > 0) {
      return '$minutes menit $seconds detik';
    }
    return '$seconds detik';
  }
}
