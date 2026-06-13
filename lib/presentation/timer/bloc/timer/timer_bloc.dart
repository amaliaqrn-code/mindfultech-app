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
    on<TimerSessionEnded>(_onSessionEnded);
  }

  // =========================
  // SETUP TIMER
  // =========================
  void _onSetup(TimerSetup event, Emitter<TimerState> emit) {
    _timer?.cancel();
    _timer = null;

    final sessions = (event.totalTarget / event.perSession).ceil();

    emit(state.copyWith(
      totalTargetMinutes: event.totalTarget,
      durationPerSession: event.perSession,
      breakDurationMinutes: event.breakDuration,
      totalSessions: sessions,
      currentSession: 1,
      remainingSeconds: event.perSession * 60,
      isRunning: false,
      isBreakTime: false,
      isAllCompleted: false,
    ));
  }

  // =========================
  // START TIMER
  // =========================
  void _onStart(TimerStarted event, Emitter<TimerState> emit) {
    if (state.isRunning || state.isAllCompleted) return;

    emit(state.copyWith(isRunning: true));
    _startLoop();
  }

  void _startLoop() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = state;

      if (!current.isRunning) return;

      if (current.remainingSeconds > 1) {
        add(TimerEvent.tick(current.remainingSeconds - 1));
      } else {
        add(const TimerEvent.sessionEnded());
      }
    });
  }

  // =========================
  // SESSION END HANDLER (AUTO SWITCH CORE)
  // =========================
  void _onSessionEnded(
    TimerSessionEnded event,
    Emitter<TimerState> emit,
  ) {
    _timer?.cancel();
    _timer = null;

    // =========================
    // dari STUDY → BREAK
    // =========================
    if (!state.isBreakTime) {
      emit(state.copyWith(
        isBreakTime: true,
        isRunning: true,
        remainingSeconds: state.breakDurationMinutes * 60,
      ));

      _startLoop();
      return;
    }

    // =========================
    // dari BREAK → NEXT SESSION
    // =========================
    if (state.currentSession < state.totalSessions) {
      emit(state.copyWith(
        isBreakTime: false,
        currentSession: state.currentSession + 1,
        isRunning: true,
        remainingSeconds: state.durationPerSession * 60,
      ));

      _startLoop();
    } else {
      // =========================
      // FINISH ALL SESSIONS
      // =========================
      emit(state.copyWith(
        isAllCompleted: true,
        isRunning: false,
      ));
    }
  }

  // =========================
  // PAUSE
  // =========================
  void _onPause(TimerPaused event, Emitter<TimerState> emit) {
    _timer?.cancel();
    _timer = null;

    emit(state.copyWith(isRunning: false));
  }

  // =========================
  // TOGGLE
  // =========================
  void _onToggle(TimerToggled event, Emitter<TimerState> emit) {
    if (state.isRunning) {
      add(const TimerEvent.pause());
    } else {
      add(const TimerEvent.start());
    }
  }

  // =========================
  // RESET
  // =========================
  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _timer?.cancel();
    _timer = null;

    emit(TimerState.initial());
  }

  // =========================
  // TICK UPDATE UI
  // =========================
  void _onTick(TimerTicked event, Emitter<TimerState> emit) {
    emit(state.copyWith(remainingSeconds: event.remainingSeconds));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}