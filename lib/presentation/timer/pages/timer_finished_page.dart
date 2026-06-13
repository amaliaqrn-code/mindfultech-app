import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/core/database/database_helper.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/presentation/choose_energy/pages/choose_energy_page.dart';
import 'package:mindfultech_app/presentation/homepage/bloc/homepage/homepage_cubit.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_cubit.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_state.dart';
import 'package:mindfultech_app/presentation/journey/pages/journey_page.dart';
import 'package:mindfultech_app/presentation/journey/pages/level_result_page.dart';
import 'package:mindfultech_app/presentation/task/bloc/task/task_bloc.dart';
import 'package:mindfultech_app/presentation/task/bloc/task/task_event.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';

class TimerFinishedPage extends StatefulWidget {
  final TaskModel? task;
  final int focusDurationSeconds;

  const TimerFinishedPage({
    super.key,
    this.task,
    this.focusDurationSeconds = 0,
  });

  @override
  State<TimerFinishedPage> createState() => _TimerFinishedPageState();
}

class _TimerFinishedPageState extends State<TimerFinishedPage> {
  int? selectedEmoji;

  final List<String> emojis = [
    'assets/icon/timerpage/Cloud1.png',
    'assets/icon/timerpage/Cloud2.png',
    'assets/icon/timerpage/Cloud3.png',
    'assets/icon/timerpage/Cloud4.png',
    'assets/icon/timerpage/Cloud5.png',
    'assets/icon/timerpage/Cloud6.png',
  ];

  final AuthLocalDataSource _authLocalDataSource = AuthLocalDataSource();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JourneyCubit, JourneyState>(
      builder: (context, journeyState) {
        final cubit = context.read<JourneyCubit>();

        return Scaffold(
          body: Stack(
            children: [
              // BACKGROUND IMAGE
              Positioned.fill(
                child: Image.asset(
                  'assets/images/timerpage/backcground.png',
                )
              ),

              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 100),

                    // ICON TENGAH ATAS (misal meditasi / selesai)
                    Image.asset(
                      'assets/images/timerpage/finish_icon.png',
                      height: 150,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Yeay, selesai!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Bagaimana perasaanmu?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,

                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),

                    const Text(
                      "Pilih salah satu yaa",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,

                        color: Colors.black45,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // EMOJI SECTION
                    if (selectedEmoji == null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: emojis.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedEmoji = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.white24),
                                ),
                                child: Image.asset(emojis[index]),
                              ),
                            );
                          },
                        ),
                      )
                    else
                      // SELECTED EMOJI ONLY
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          emojis[selectedEmoji!],
                          height: 90,
                        ),
                      ),

                    const Spacer(),

                    // FOCUS PROGRESS INDICATOR
                    _buildFocusProgressIndicator(journeyState),

                    const SizedBox(height: 16),

                    // BUTTONS COLUMN (VERTICAL)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: selectedEmoji != null
                                  ? () => _handleContinueToJourney(context, cubit)
                                  : null,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: ShaderMask(
                                shaderCallback: (bounds) {
                                  return const LinearGradient(
                                    colors: [
                                      Color(0xFF4A90E2),
                                      Color(0xFF78E6C8),
                                    ],
                                  ).createShader(
                                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                                  );
                                },
                                child: const Text(
                                  "Lanjut",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // wajib ini (biar mask jalan)
                                  ),
                                ),
                              )
                            ),
                          ),
                          const SizedBox(height: 12),

                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF4A90E2),
                                    Color(0xFF78E6C8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const ChooseEnergyPage(),
                                      ),
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    child: Center(
                                      child: Text(
                                        "Mulai Fokus Lagi",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Handle save focus session and navigate to journey
  Future<void> _handleContinueToJourney(BuildContext context, JourneyCubit cubit) async {
    // NAVIGATION GUARD: Check if daily target is reached
    if (!cubit.isDailyTargetReached) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Target fokus harian belum tercapai!"),
        ),
      );
      return;
    }

    // ✅ STEP 1: Save focus session to database
    await _saveFocusSession();

    // ✅ STEP 2: Delete completed task from database (except default tasks)
    await _deleteCompletedTask();

    // ✅ STEP 3: Update Journey state using completeLevelSession
    cubit.completeLevelSession();

    // ✅ STEP 4: Refresh homepage emotion data
    if (context.mounted) {
      context.read<HomepageCubit>().loadEmotionData();
      context.read<TaskBloc>().add(const FetchTasksEvent());
    }

    // ✅ STEP 5: Navigate to JourneyPage (mascot animation will trigger automatically)
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const JourneyPage(),
        ),
      );
    }

    // ✅ STEP 6: Wait for mascot animation to complete (~900ms)
    await Future.delayed(const Duration(milliseconds: 900));

    if (context.mounted) {
      // Get current level from cubit
      final currentLevel = cubit.state.currentLevel.level;

      // Navigate to LevelResultPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LevelResultPage(currentLevel: currentLevel),
        ),
      );
    }
  }

  /// Save focus session to database with emotion data
  Future<void> _saveFocusSession() async {
    if (selectedEmoji == null) return;

    try {
      final user = _authLocalDataSource.getUser();
      if (user == null) return;

      final userId = user.id.toString();
      final emotion = EmotionTypeExtension.fromValue(selectedEmoji!);

      // Use widget.focusDurationSeconds if available, otherwise calculate from timer
      final durationSeconds = widget.focusDurationSeconds > 0
          ? widget.focusDurationSeconds
          : 30 * 60; // Default 30 minutes if not provided

      final session = FocusSessionModel(
        taskId: widget.task?.id,
        userId: userId,
        durationSeconds: durationSeconds,
        emotion: emotion,
        createdAt: DateTime.now().toIso8601String(),
      );

      await _databaseHelper.insertFocusSession(session);
    } catch (_) {
      // Ignore save errors - session will not be logged but app continues
    }
  }

  /// Delete completed task from database (except default tasks)
  Future<void> _deleteCompletedTask() async {
    if (widget.task == null) return;

    try {
      // Only delete non-default tasks
      if (!widget.task!.isDefault) {
        await _databaseHelper.deleteTask(widget.task!.id);
      }
    } catch (_) {
      // Ignore delete errors - task will remain but app continues
    }
  }

  Widget _buildFocusProgressIndicator(JourneyState state) {
    final progress = state.dailyProgress;
    final isReached = state.isDailyTargetReached;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isReached ? const Color(0xFF4CAF50) : const Color(0xFF4A90E2),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isReached ? Icons.check_circle : Icons.timer,
            color: isReached ? const Color(0xFF4CAF50) : const Color(0xFF4A90E2),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isReached ? 'Target Harian Tercapai! 🎉' : 'Fokus Hari Ini',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isReached ? const Color(0xFF4CAF50) : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isReached ? const Color(0xFF4CAF50) : const Color(0xFF4A90E2),
                          ),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${(progress * 100).round()}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isReached ? const Color(0xFF4CAF50) : const Color(0xFF4A90E2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
