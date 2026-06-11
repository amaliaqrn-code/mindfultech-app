// lib/presentation/timer/widgets/timer_controller_buttons.dart
import 'package:flutter/material.dart';

class TimerControllerButtons extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onPlayPause;
  final VoidCallback onReset;

  const TimerControllerButtons({
    super.key,
    required this.isRunning,
    required this.onPlayPause,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 64,
          icon: Icon(isRunning ? Icons.pause_circle_filled : Icons.play_circle_filled),
          color: Colors.white,
          onPressed: onPlayPause,
        ),
        const SizedBox(width: 20),
        IconButton(
          iconSize: 44,
          icon: const Icon(Icons.replay_rounded),
          color: Colors.white.withValues(alpha: 0.8),
          onPressed: onReset,
        ),
      ],
    );
  }
}