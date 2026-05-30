import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';
import '../theme/timer_theme.dart';
import '../widgets/goal_card.dart';
import '../widgets/circular_timer_widget.dart';
import '../widgets/motivation_warning_cards.dart';
import '../widgets/timer_action_button.dart';
import '../widgets/time_picker_bottom_sheet.dart';

/// Timer Screen - Functional Focus Timer Page
class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(TimerController());

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
                      Obx(() => GoalCard(
                        taskName: controller.taskName.value,
                        onExitTap: () => _showExitDialog(context),
                      )),

                      const SizedBox(height: 32),

                      // Circular Timer
                      Obx(() => CircularTimerWidget(
                        progress: controller.progress,
                        timeText: controller.formattedTime,
                        minutesLabel: '${controller.targetMinutes.value} menit',
                        sessionLabel: 'Sesi Fokus',
                        qualityLabel: 'Waktu Fokus Berkualitas',
                        canEdit: controller.canEditTime,
                        onEditTap: () => _showTimePicker(context, controller),
                      )),

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
                child: Obx(() => TimerActionButton(
                  isRunning: controller.isRunning.value,
                  onTap: () => controller.toggleTimer(),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTimePicker(BuildContext context, TimerController controller) {
    TimePickerBottomSheet.show(
      context,
      currentMinutes: controller.targetMinutes.value,
      onSave: (minutes) {
        controller.setTargetMinutes(minutes);
      },
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(
                color: TimerTheme.textGrey,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Get.back();
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