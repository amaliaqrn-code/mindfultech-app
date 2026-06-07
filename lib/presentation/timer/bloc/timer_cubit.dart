import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  Timer? _timer;
  Function? onTimerComplete;

  TimerCubit({String taskName = 'Tugas Fokus'})
      : super(TimerState.initial(taskName: taskName));

  void startTimer() {
    if (state.isRunning) return;
    if (state.remainingSeconds <= 0) return;

    emit(state.copyWith(isRunning: true));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
      } else {
        stopTimer();
        onTimerComplete?.call();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    emit(state.copyWith(isRunning: false));
  }

  void toggleTimer() {
    if (state.isRunning) {
      stopTimer();
    } else {
      startTimer();
    }
  }

  void resetTimer() {
    stopTimer();
    emit(state.copyWith(remainingSeconds: state.targetMinutes * 60));
  }

  void setTargetMinutes(int minutes) {
    int target = minutes;
    if (target < 1) target = 1;
    if (target > 120) target = 120;

    emit(state.copyWith(
      targetMinutes: target,
      remainingSeconds: target * 60,
    ));
  }

  void setTaskName(String name) {
    emit(state.copyWith(taskName: name));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
