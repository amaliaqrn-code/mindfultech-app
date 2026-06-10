import 'package:freezed_annotation/freezed_annotation.dart';
part 'timer_state.freezed.dart';

@freezed
abstract class TimerState with _$TimerState {
  const factory TimerState({
    required int targetMinutes,
    required int remainingSeconds,
    required bool isRunning,
  }) = _TimerState;

  // Nilai awal (Initial State) pengganti TimerState.initial()
  factory TimerState.initial() => const TimerState(
        targetMinutes: 25,
        remainingSeconds: 25 * 60,
        isRunning: false,
      );
}

// 💡 Helper extension untuk memudahkan UI membaca kondisi khusus
extension TimerStateX on TimerState {
  bool get isCompleted => remainingSeconds <= 0;
  
  // Mengubah detik ke format String MM:SS (Contoh: "25:00")
  String get timeString {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Mengubah progress menjadi nilai double (0.0 sampai 1.0) untuk CircularProgress Indicator
  double get progressValue {
    final totalSeconds = targetMinutes * 60;
    if (totalSeconds == 0) return 0.0;
    return remainingSeconds / totalSeconds;
  }
}