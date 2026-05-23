class JourneyLevelModel {
  final int level;
  final int requiredDays;
  final String areaName;
  final String emoji;
  final String backgroundImage;
  final bool isUnlocked;
  final int currentDayInLevel;

  JourneyLevelModel({
    required this.level,
    required this.requiredDays,
    required this.areaName,
    required this.emoji,
    required this.backgroundImage,
    this.isUnlocked = false,
    this.currentDayInLevel = 0,
  });

  JourneyLevelModel copyWith({
    int? level,
    int? requiredDays,
    String? areaName,
    String? emoji,
    String? backgroundImage,
    bool? isUnlocked,
    int? currentDayInLevel,
  }) {
    return JourneyLevelModel(
      level: level ?? this.level,
      requiredDays: requiredDays ?? this.requiredDays,
      areaName: areaName ?? this.areaName,
      emoji: emoji ?? this.emoji,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      currentDayInLevel: currentDayInLevel ?? this.currentDayInLevel,
    );
  }
}