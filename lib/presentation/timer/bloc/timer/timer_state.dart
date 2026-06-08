import 'package:equatable/equatable.dart';

class TimerState extends Equatable {
  final int targetMinutes;
  final int remainingSeconds;
  final bool isRunning;
  final String taskName;

  const TimerState({
    required this.targetMinutes,
    required this.remainingSeconds,
    required this.isRunning,
    required this.taskName,
  });

  factory TimerState.initial({String taskName = 'Tugas Fokus'}) {
    return TimerState(
      targetMinutes: 25,
      remainingSeconds: 25 * 60,
      isRunning: false,
      taskName: taskName,
    );
  }

  TimerState copyWith({
    int? targetMinutes,
    int? remainingSeconds,
    bool? isRunning,
    String? taskName,
  }) {
    return TimerState(
      targetMinutes: targetMinutes ?? this.targetMinutes,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
      taskName: taskName ?? this.taskName,
    );
  }

  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }

  double get progress {
    final totalSeconds = targetMinutes * 60;
    if (totalSeconds == 0) return 0;
    return 1 - (remainingSeconds / totalSeconds);
  }

  bool get canEditTime => !isRunning && remainingSeconds == targetMinutes * 60;

  bool get isCompleted => remainingSeconds <= 0;

  String get remainingTimeText {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    if (minutes > 0) {
      return '$minutes menit $seconds detik';
    }
    return '$seconds detik';
  }

  @override
  List<Object?> get props => [targetMinutes, remainingSeconds, isRunning, taskName];
}
