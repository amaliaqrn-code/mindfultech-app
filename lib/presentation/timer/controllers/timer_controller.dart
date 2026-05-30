import 'dart:async';
import 'package:get/get.dart';

/// Timer Controller - State Management for Focus Timer
class TimerController extends GetxController {
  // Timer settings
  final RxInt targetMinutes = 25.obs;
  final RxInt remainingSeconds = (25 * 60).obs;

  // Timer state
  final RxBool isRunning = false.obs;

  // Task info
  final RxString taskName = ''.obs;

  // Timer instance
  Timer? _timer;

  // Callback for when timer completes
  Function? onTimerComplete;

  @override
  void onInit() {
    super.onInit();
    // Initialize with optional task name from arguments
    final args = Get.arguments;
    if (args != null && args['taskName'] != null) {
      taskName.value = args['taskName'] as String;
    } else {
      taskName.value = 'Tugas Fokus';
    }
    // Update remaining seconds based on target
    remainingSeconds.value = targetMinutes.value * 60;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  /// Format remaining seconds to MM:SS
  String get formattedTime {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }

  /// Get progress value (0.0 to 1.0) for circular progress
  double get progress {
    final totalSeconds = targetMinutes.value * 60;
    if (totalSeconds == 0) return 0;
    return 1 - (remainingSeconds.value / totalSeconds);
  }

  /// Check if timer can be edited (not running)
  bool get canEditTime => !isRunning.value && remainingSeconds.value == targetMinutes.value * 60;

  /// Start the timer
  void startTimer() {
    if (isRunning.value) return;
    if (remainingSeconds.value <= 0) return;

    isRunning.value = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        stopTimer();
        onTimerComplete?.call();
      }
    });
  }

  /// Stop/pause the timer
  void stopTimer() {
    isRunning.value = false;
    _timer?.cancel();
    _timer = null;
  }

  /// Toggle timer (start/stop)
  void toggleTimer() {
    if (isRunning.value) {
      stopTimer();
    } else {
      startTimer();
    }
  }

  /// Reset timer to target minutes
  void resetTimer() {
    stopTimer();
    remainingSeconds.value = targetMinutes.value * 60;
  }

  /// Update target minutes and reset timer
  void setTargetMinutes(int minutes) {
    if (minutes < 1) minutes = 1;
    if (minutes > 120) minutes = 120;

    targetMinutes.value = minutes;
    remainingSeconds.value = minutes * 60;
  }

  /// Set task name
  void setTaskName(String name) {
    taskName.value = name;
  }

  /// Check if timer is completed
  bool get isCompleted => remainingSeconds.value <= 0;

  /// Get remaining time in human readable format
  String get remainingTimeText {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;

    if (minutes > 0) {
      return '$minutes menit $seconds detik';
    }
    return '$seconds detik';
  }
}
