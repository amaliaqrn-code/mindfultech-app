import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/timer_cubit.dart';
import '../bloc/timer_state.dart';
import '../theme/timer_theme.dart';
import '../widgets/goal_card.dart';
import '../widgets/circular_timer_widget.dart';
import '../widgets/motivation_warning_cards.dart';
import '../widgets/timer_action_button.dart';
import '../widgets/time_picker_bottom_sheet.dart';

/// Timer Screen - Functional Focus Timer Page
class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        final cubit = context.read<TimerCubit>();

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: TimerTheme.skyGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),

                          // Goal Card (Header)
                          GoalCard(
                            taskName: state.taskName,
                            onExitTap: () => _showExitDialog(context),
                          ),

                          const SizedBox(height: 32),

                          // Circular Timer
                          CircularTimerWidget(
                            progress: state.progress,
                            timeText: state.formattedTime,
                            minutesLabel: '${state.targetMinutes} menit',
                            sessionLabel: 'Sesi Fokus',
                            qualityLabel: 'Waktu Fokus Berkualitas',
                            canEdit: state.canEditTime,
                            onEditTap: () => _showTimePicker(context, cubit),
                          ),

                          const SizedBox(height: 32),

                          // Motivation Card
                          const MotivationCard(),

                          const SizedBox(height: 12),

                          // Warning Card
                          const WarningCard(),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Action Button
                  Padding(
                    padding: EdgeInsets.only(
                      left: 24,
                      right: 24,
                      bottom: MediaQuery.of(context).padding.bottom + 16,
                    ),
                    child: TimerActionButton(
                      isRunning: state.isRunning,
                      onTap: () => cubit.toggleTimer(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showTimePicker(BuildContext context, TimerCubit cubit) {
    TimePickerBottomSheet.show(
      context,
      currentMinutes: cubit.state.targetMinutes,
      onSave: (minutes) {
        cubit.setTargetMinutes(minutes);
      },
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Keluar Timer?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: TimerTheme.textDark,
          ),
        ),
        content: const Text(
          'Timer yang sedang berjalan akan dihentikan. Apakah kamu yakin ingin keluar?',
          style: TextStyle(
            color: TimerTheme.textGrey,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Batal',
              style: TextStyle(
                color: TimerTheme.textGrey,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: TimerTheme.warningRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Keluar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}