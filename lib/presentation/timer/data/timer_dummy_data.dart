// lib/presentation/timer/data/timer_dummy_data.dart

class TimerPreset {
  final String label;
  final int durationInMinutes;

  const TimerPreset({required this.label, required this.durationInMinutes});
}

class TimerDummyData {
  static const List<TimerPreset> timerPresets = [
    TimerPreset(label: 'Focus', durationInMinutes: 25),
    TimerPreset(label: 'Short Break', durationInMinutes: 5),
    TimerPreset(label: 'Long Break', durationInMinutes: 15),
  ];
}