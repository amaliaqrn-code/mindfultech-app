// lib/presentation/timer/bloc/timer/timer_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'timer_event.dart';
import 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;

  TimerBloc() : super(TimerState.initial()) {
    on<TimerSetup>(_onSetup);
    on<TimerStarted>(_onStart);
    on<TimerPaused>(_onPause);
    on<TimerToggled>(_onToggle);
    on<TimerReset>(_onReset);
    on<TimerTicked>(_onTick);
    on<TimerNextSession>(_onNextSession);
  }

  void _onSetup(TimerSetup event, Emitter<TimerState> emit) {
    _timer?.cancel();
    _timer = null;
    
    // Hitung berapa sesi otomatis (pembulatan ke atas jika ada sisa menit)
    int calculatedSessions = (event.totalTarget / event.perSession).ceil();
    if (calculatedSessions < 1) calculatedSessions = 1;

    emit(state.copyWith(
      totalTargetMinutes: event.totalTarget,
      durationPerSession: event.perSession,
      breakDurationMinutes: event.breakDuration,
      totalSessions: calculatedSessions,
      currentSession: 1,
      remainingSeconds: event.perSession * 60,
      isRunning: false,
      isBreakTime: false,
      isAllCompleted: false,
    ));
  }

  void _onStart(TimerStarted event, Emitter<TimerState> emit) {
    if (state.isRunning || state.isAllCompleted) return;
    emit(state.copyWith(isRunning: true));

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds <= 0) {
        add(const TimerEvent.pause());
        add(const TimerEvent.nextSession()); // Pindah sesi otomatis saat waktu habis
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
    emit(state.copyWith(
      currentSession: 1,
      remainingSeconds: state.durationPerSession * 60,
      isRunning: false,
      isBreakTime: false,
      isAllCompleted: false,
    ));
  }

  void _onTick(TimerTicked event, Emitter<TimerState> emit) {
    if (state.isRunning) {
      emit(state.copyWith(remainingSeconds: event.remainingSeconds));
    }
  }

  void _onNextSession(TimerNextSession event, Emitter<TimerState> emit) {
    _timer?.cancel();
    _timer = null;

    if (!state.isBreakTime) {
      // Jika baru menyelesaikan sesi tugas, alihkan ke sesi istirahat
      emit(state.copyWith(
        isBreakTime: true,
        remainingSeconds: state.breakDurationMinutes * 60,
        isRunning: false,
      ));
    } else {
      // Jika baru menyelesaikan sesi istirahat, cek apakah masih ada sesi tugas berikutnya
      if (state.currentSession < state.totalSessions) {
        emit(state.copyWith(
          isBreakTime: false,
          currentSession: state.currentSession + 1,
          remainingSeconds: state.durationPerSession * 60,
          isRunning: false,
        ));
      } else {
        // Jika sesi sudah habis semua
        emit(state.copyWith(
          isAllCompleted: true,
          isRunning: false,
        ));
      }
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}