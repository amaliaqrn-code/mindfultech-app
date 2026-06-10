import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'timer_event.dart';
import 'timer_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;

  TimerBloc() : super(TimerState.initial()) {
    // ✅ Menggunakan nama class publik dari Freezed
    on<TimerStarted>(_onStart);
    on<TimerPaused>(_onPause);
    on<TimerToggled>(_onToggle);
    on<TimerReset>(_onReset);
    on<TimerTicked>(_onTick);
    on<TimerSetTarget>(_onSetTarget);
  }

  void _onStart(TimerStarted event, Emitter<TimerState> emit) {
    if (state.isRunning || state.isCompleted) return;

    emit(state.copyWith(isRunning: true));

    _timer?.cancel(); // Pastikan tidak ada timer ganda yang berjalan
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds <= 0) {
        add(const TimerEvent.pause());
      } else {
        add(TimerEvent.tick(state.remainingSeconds - 1));
      }
    });
  }

  void _onPause(TimerPaused event, Emitter<TimerState> emit) {
    _timer?.cancel();
    _timer = null;
    emit(state.copyWith(isRunning: false));
  }

  void _onToggle(TimerToggled event, Emitter<TimerState> emit) {
    if (state.isRunning) {
      add(const TimerEvent.pause());
    } else {
      add(const TimerEvent.start());
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _timer?.cancel();
    _timer = null;
    final totalSeconds = state.targetMinutes * 60;
    emit(state.copyWith(
      remainingSeconds: totalSeconds,
      isRunning: false,
    ));
  }

  void _onTick(TimerTicked event, Emitter<TimerState> emit) {
    // Hanya update detik jika timer memang sedang berjalan
    if (state.isRunning) {
      emit(state.copyWith(remainingSeconds: event.remainingSeconds));
    }
  }

  void _onSetTarget(TimerSetTarget event, Emitter<TimerState> emit) {
    _timer?.cancel();
    _timer = null;
    final totalSeconds = event.minutes * 60;
    emit(state.copyWith(
      targetMinutes: event.minutes,
      remainingSeconds: totalSeconds,
      isRunning: false,
    ));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}