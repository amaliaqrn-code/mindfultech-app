import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/models/task_model.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/theme/blue_theme.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/widgets/blue_alternative_task_list.dart';

/// ============================================================
/// BLUE ALTERNATIVE TASK LIST SCREEN
/// Halaman untuk memilih tugas lain (alternative)
/// ============================================================

class BlueAlternativeTaskListPage extends StatefulWidget {
  final TaskCategory category;
  final String? excludeTaskId;

  const BlueAlternativeTaskListPage({
    super.key,
    required this.category,
    this.excludeTaskId,
  });

  @override
  State<BlueAlternativeTaskListPage> createState() =>
      _BlueAlternativeTaskListPageState();
}

class _BlueAlternativeTaskListPageState
    extends State<BlueAlternativeTaskListPage> {
  TaskModel? _selectedTask;

  // Sample tasks for each category (medium energy tasks)
  List<TaskModel> get _tasks {
    final allTasks = _getTasksForCategory(widget.category);
    if (widget.excludeTaskId != null) {
      return allTasks.where((t) => t.id != widget.excludeTaskId).toList();
    }
    return allTasks;
  }

  List<TaskModel> _getTasksForCategory(TaskCategory category) {
    switch (category) {
      case TaskCategory.belajar:
        return [
          const TaskModel(
            id: 'belajar_1',
            title: 'Belajar coding 30 menit',
            description: 'Belajar dasar pemrograman dengan materi interaktif',
            category: TaskCategory.belajar,
            energyLevel: EnergyLevel.medium,
            iconName: 'computer',
            estimatedMinutes: 30,
          ),
          const TaskModel(
            id: 'belajar_2',
            title: 'Baca buku teknis',
            description: 'Membaca satu bab dari buku pengembangan diri',
            category: TaskCategory.belajar,
            energyLevel: EnergyLevel.medium,
            iconName: 'menu_book',
            estimatedMinutes: 30,
          ),
          const TaskModel(
            id: 'belajar_3',
            title: 'Ikuti tutorial online',
            description: 'Menyelesaikan satu lesson dari course online',
            category: TaskCategory.belajar,
            energyLevel: EnergyLevel.medium,
            iconName: 'video_library',
            estimatedMinutes: 25,
          ),
        ];
      case TaskCategory.pekerjaan:
        return [
          const TaskModel(
            id: 'pekerjaan_1',
            title: 'Kerja project pertama',
            description: 'Mengerjakan bagian pertama dari project',
            category: TaskCategory.pekerjaan,
            energyLevel: EnergyLevel.medium,
            iconName: 'work',
            estimatedMinutes: 45,
          ),
          const TaskModel(
            id: 'pekerjaan_2',
            title: 'Meeting dengan tim',
            description: 'Ikut meeting dan berikan kontribusi',
            category: TaskCategory.pekerjaan,
            energyLevel: EnergyLevel.medium,
            iconName: 'groups',
            estimatedMinutes: 30,
          ),
        ];
      case TaskCategory.kesehatan:
        return [
          const TaskModel(
            id: 'kesehatan_1',
            title: 'Jogging ringan 15 menit',
            description: 'Lari ringan di sekitar kompleks untuk kesehatan',
            category: TaskCategory.kesehatan,
            energyLevel: EnergyLevel.medium,
            iconName: 'directions_walk',
            estimatedMinutes: 15,
          ),
          const TaskModel(
            id: 'kesehatan_2',
            title: 'Gym 45 menit',
            description: 'Latihan gym ringan dengan trainer',
            category: TaskCategory.kesehatan,
            energyLevel: EnergyLevel.medium,
            iconName: 'fitness_center',
            estimatedMinutes: 45,
          ),
        ];
      case TaskCategory.selfCare:
        return [
          const TaskModel(
            id: 'selfcare_1',
            title: 'Meditasi 15 menit',
            description: 'Meditasi dengan guided meditation untuk ketenangan',
            category: TaskCategory.selfCare,
            energyLevel: EnergyLevel.medium,
            iconName: 'self_improvement',
            estimatedMinutes: 15,
          ),
          const TaskModel(
            id: 'selfcare_2',
            title: 'Journaling',
            description: 'Menulis jurnal tentang perasaan dan goals',
            category: TaskCategory.selfCare,
            energyLevel: EnergyLevel.medium,
            iconName: 'edit',
            estimatedMinutes: 20,
          ),
        ];
      case TaskCategory.rumah:
        return [
          const TaskModel(
            id: 'rumah_1',
            title: 'Bersihkan kamar',
            description: 'Membersihkan dan merapikan kamar tidur',
            category: TaskCategory.rumah,
            energyLevel: EnergyLevel.medium,
            iconName: 'cleaning_services',
            estimatedMinutes: 30,
          ),
          const TaskModel(
            id: 'rumah_2',
            title: 'Masak makanan sehat',
            description: 'Memiapkan makanan sehat untuk minggu ini',
            category: TaskCategory.rumah,
            energyLevel: EnergyLevel.medium,
            iconName: 'restaurant',
            estimatedMinutes: 45,
          ),
        ];
      case TaskCategory.hubungan:
        return [
          const TaskModel(
            id: 'hubungan_1',
            title: 'Telepon teman',
            description: 'Mengobrol dengan teman dekat selama 20 menit',
            category: TaskCategory.hubungan,
            energyLevel: EnergyLevel.medium,
            iconName: 'call',
            estimatedMinutes: 20,
          ),
          const TaskModel(
            id: 'hubungan_2',
            title: 'Family time',
            description: 'Berkualitas time bersama keluarga',
            category: TaskCategory.hubungan,
            energyLevel: EnergyLevel.medium,
            iconName: 'family_restroom',
            estimatedMinutes: 30,
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlueTheme.backgroundPage,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),

            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Title
                    const Text(
                      'Pilih tugas lain',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: BlueTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    const Text(
                      'Pilih task yang ingin kamu kerjakan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: BlueTheme.textGrey,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Main image dari assets
                    _buildMainImage(),

                    const SizedBox(height: 20),

                    // Task list
                    BlueAlternativeTaskList(
                      tasks: _tasks,
                      selectedTask: _selectedTask,
                      onTaskSelected: (task) {
                        setState(() {
                          _selectedTask = task;
                        });
                      },
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Button
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).padding.bottom + 20,
              ),
              child: GestureDetector(
                onTap: _selectedTask != null
                    ? () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.blueTaskConfirmation,
                          arguments: {
                            'selectedTask': _selectedTask!,
                          },
                        );
                      }
                    : null,
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: _selectedTask != null
                        ? BlueTheme.primaryButtonGradient
                        : null,
                    color: _selectedTask != null ? null : BlueTheme.borderLight,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: _selectedTask != null
                        ? [
                            BoxShadow(
                              color: BlueTheme.primaryBlue.withValues(alpha: 0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      'Lanjut',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _selectedTask != null
                            ? Colors.white
                            : BlueTheme.textMuted,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom decoration
            Container(
              height: 30,
              decoration: BoxDecoration(
                color: BlueTheme.backgroundWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: BlueTheme.shadowColor.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: BlueTheme.borderLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: BlueTheme.borderMedium,
                  width: 2,
                ),
                color: BlueTheme.backgroundWhite,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: BlueTheme.primaryBlue,
                size: 18,
              ),
            ),
          ),
          const Spacer(),
          // Progress indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: BlueTheme.primaryBluePale,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: BlueTheme.primaryBlue,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  'Pilih tugas lain',
                  style: TextStyle(
                    fontSize: 12,
                    color: BlueTheme.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainImage() {
    return Image.asset(
      'assets/images/energisedang/energi_alternative.png',
      width: double.infinity,
      height: 200,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback jika asset tidak ditemukan
        return Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: BlueTheme.primaryBluePale,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.emoji_emotions_rounded,
                size: 60,
                color: BlueTheme.primaryBlue,
              ),
              const SizedBox(height: 8),
              const Text(
                '😊 Mindy siap membantu!',
                style: TextStyle(
                  fontSize: 16,
                  color: BlueTheme.primaryBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}