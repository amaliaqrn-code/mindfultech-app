// lib/presentation/timer/bloc/timer/timer_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'timer_state.freezed.dart';

@freezed
abstract class TimerState with _$TimerState {
  const factory TimerState({
    required int totalTargetMinutes,     // Total target dari task (misal: 60)
    required int durationPerSession,     // Durasi per sesi belajar (misal: 30)
    required int breakDurationMinutes,   // Durasi istirahat (misal: 10)
    required int totalSessions,          // Hasil hitung total target / per sesi (misal: 2)
    required int currentSession,         // Sesi berjalan sekarang (mulai dari 1)
    required int remainingSeconds,       // Hitung mundur detik yang aktif
    required bool isRunning,             // Apakah timer berdetak
    required bool isBreakTime,           // True jika sedang sesi istirahat, False jika sesi tugas
    required bool isAllCompleted,        // True jika semua rangkaian sesi habis
  }) = _TimerState;

  factory TimerState.initial() => const TimerState(
        totalTargetMinutes: 0,
        durationPerSession: 0,
        breakDurationMinutes: 0,
        totalSessions: 0,
        currentSession: 0,
        remainingSeconds: 0,
        isRunning: false,
        isBreakTime: false,
        isAllCompleted: false,
      );
}

extension TimerStateX on TimerState {
  String get timeString {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double get progressValue {
    final totalSeconds = (isBreakTime ? breakDurationMinutes : durationPerSession) * 60;
    if (totalSeconds == 0) return 0.0;
    return remainingSeconds / totalSeconds;
  }
}