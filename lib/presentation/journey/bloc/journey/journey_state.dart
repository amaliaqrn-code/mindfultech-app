import 'package:equatable/equatable.dart';
import '../../models/journey_level_model.dart';

class JourneyState extends Equatable {
  final int totalDays;
  final List<JourneyLevelModel> levels;
  final JourneyLevelModel currentLevel;

  const JourneyState({
    required this.totalDays,
    required this.levels,
    required this.currentLevel,
  });

  factory JourneyState.initial() {
    return JourneyState(
      totalDays: 0,
      levels: const [],
      currentLevel: JourneyLevelModel(
        level: 1,
        requiredDays: 1,
        areaName: 'Mulai Perjalanan',
        emoji: '🏠',
        backgroundImage: '',
      ),
    );
  }

  JourneyState copyWith({
    int? totalDays,
    List<JourneyLevelModel>? levels,
    JourneyLevelModel? currentLevel,
  }) {
    return JourneyState(
      totalDays: totalDays ?? this.totalDays,
      levels: levels ?? this.levels,
      currentLevel: currentLevel ?? this.currentLevel,
    );
  }

  @override
  List<Object?> get props => [totalDays, levels, currentLevel];
}
