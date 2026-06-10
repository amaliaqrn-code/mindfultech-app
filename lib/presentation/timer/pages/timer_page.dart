// lib/presentation/timer/pages/timer_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/presentation/timer/bloc/timer/timer_bloc.dart';
import 'package:mindfultech_app/presentation/timer/bloc/timer/timer_event.dart';
import '../bloc/timer/timer_state.dart';
import '../theme/timer_theme.dart';
import '../widgets/timer_circle_progress.dart';
import '../widgets/timer_controller_buttons.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: TimerTheme.backgroundGradient,
        child: SafeArea(
          child: Center(
            child: BlocBuilder<TimerBloc, TimerState>(
            builder: (context, state) {
              return Column(
                children: [
                  // 1. Tampilkan teks waktu otomatis pakai helper state.timeString (Contoh: 25:00)
                  TimerCircleProgress(
                    timeString: state.timeString, 
                    progressValue: state.progressValue, // Menghasilkan double otomatis
                  ),
                  
                  // 2. Tombol kontrol trigger menggunakan Event Bloc
                  TimerControllerButtons(
                    isRunning: state.isRunning,
                    onPlayPause: () {
                      context.read<TimerBloc>().add(const TimerEvent.toggle());
                    },
                    onReset: () {
                      context.read<TimerBloc>().add(const TimerEvent.reset());
                    },
                  ),
                ],
              );
            },
)
          ),
        ),
      ),
    );
  }
}