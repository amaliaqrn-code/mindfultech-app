import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_event.freezed.dart';

@freezed
class TimerEvent with _$TimerEvent {
  const factory TimerEvent.start() = TimerStarted;
  const factory TimerEvent.pause() = TimerPaused;
  const factory TimerEvent.toggle() = TimerToggled;
  const factory TimerEvent.reset() = TimerReset;
  const factory TimerEvent.tick(int remainingSeconds) = TimerTicked;
  const factory TimerEvent.setTarget(int minutes) = TimerSetTarget;
}