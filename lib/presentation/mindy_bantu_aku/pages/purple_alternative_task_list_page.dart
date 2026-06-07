import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/models/task_model.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/theme/purple_theme.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/widgets/purple_alternative_task_list.dart';

/// ============================================================
/// PURPLE ALTERNATIVE TASK LIST SCREEN
/// Halaman untuk memilih tugas lain (alternative)
/// ============================================================

class PurpleAlternativeTaskListPage extends StatefulWidget {
  final TaskCategory category;
  final String? excludeTaskId;

  const PurpleAlternativeTaskListPage({
    super.key,
    required this.category,
    this.excludeTaskId,
  });

  @override
  State<PurpleAlternativeTaskListPage> createState() =>
      _PurpleAlternativeTaskListPageState();
}

class _PurpleAlternativeTaskListPageState
    extends State<PurpleAlternativeTaskListPage> {
  TaskModel? _selectedTask;

  // Sample tasks for each category (high energy tasks)
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
            title: 'Belajar coding intensif',
            description: 'Belajar coding intensif selama 2 jam dengan project nyata',
            category: TaskCategory.belajar,
            energyLevel: EnergyLevel.high,
            iconName: 'computer',
            estimatedMinutes: 120,
          ),
          const TaskModel(
            id: 'belajar_2',
            title: 'Baca buku tebal',
            description: 'Membaca 2 bab dari buku pengembangan diri',
            category: TaskCategory.belajar,
            energyLevel: EnergyLevel.high,
            iconName: 'menu_book',
            estimatedMinutes: 60,
          ),
        ];
      case TaskCategory.pekerjaan:
        return [
          const TaskModel(
            id: 'pekerjaan_1',
            title: 'Kerja project besar',
            description: 'Fokus pengerjaan project utama dengan target selesai',
            category: TaskCategory.pekerjaan,
            energyLevel: EnergyLevel.high,
            iconName: 'work',
            estimatedMinutes: 180,
          ),
          const TaskModel(
            id: 'pekerjaan_2',
            title: 'Presentasi important',
            description: 'Siapkan dan berikan presentasi ke client',
            category: TaskCategory.pekerjaan,
            energyLevel: EnergyLevel.high,
            iconName: 'slideshow',
            estimatedMinutes: 90,
          ),
        ];
      case TaskCategory.kesehatan:
        return [
          const TaskModel(
            id: 'kesehatan_1',
            title: 'Gym intensif 1 jam',
            description: 'Latihan gym intensif dengan target progres',
            category: TaskCategory.kesehatan,
            energyLevel: EnergyLevel.high,
            iconName: 'fitness_center',
            estimatedMinutes: 60,
          ),
          const TaskModel(
            id: 'kesehatan_2',
            title: 'Olahraga outdoor',
            description: 'Hiking atau bersepeda di outdoor',
            category: TaskCategory.kesehatan,
            energyLevel: EnergyLevel.high,
            iconName: 'directions_walk',
            estimatedMinutes: 90,
          ),
        ];
      case TaskCategory.selfCare:
        return [
          const TaskModel(
            id: 'selfcare_1',
            title: 'Yoga intensif',
            description: 'Yoga advanced dengan tantangan fisik',
            category: TaskCategory.selfCare,
            energyLevel: EnergyLevel.high,
            iconName: 'self_improvement',
            estimatedMinutes: 45,
          ),
          const TaskModel(
            id: 'selfcare_2',
            title: 'Buat karya kreatif',
            description: 'Membuat karya seni atau musik',
            category: TaskCategory.selfCare,
            energyLevel: EnergyLevel.high,
            iconName: 'palette',
            estimatedMinutes: 60,
          ),
        ];
      case TaskCategory.rumah:
        return [
          const TaskModel(
            id: 'rumah_1',
            title: 'Deep cleaning',
            description: 'Bersihkan seluruh rumah dengan detail',
            category: TaskCategory.rumah,
            energyLevel: EnergyLevel.high,
            iconName: 'cleaning_services',
            estimatedMinutes: 120,
          ),
          const TaskModel(
            id: 'rumah_2',
            title: 'Renovasi kecil',
            description: 'Perbaiki atau renovasi area rumah',
            category: TaskCategory.rumah,
            energyLevel: EnergyLevel.high,
            iconName: 'construction',
            estimatedMinutes: 90,
          ),
        ];
      case TaskCategory.hubungan:
        return [
          const TaskModel(
            id: 'hubungan_1',
            title: 'Ikut komunitas',
            description: 'Ikut kegiatan komunitas atau meetup',
            category: TaskCategory.hubungan,
            energyLevel: EnergyLevel.high,
            iconName: 'groups',
            estimatedMinutes: 120,
          ),
          const TaskModel(
            id: 'hubungan_2',
            title: 'Event social',
            description: 'Datangi event sosial atau networking',
            category: TaskCategory.hubungan,
            energyLevel: EnergyLevel.high,
            iconName: 'event_note',
            estimatedMinutes: 90,
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PurpleTheme.backgroundPage,
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
                        color: PurpleTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    const Text(
                      'Pilih task yang ingin kamu kerjakan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: PurpleTheme.textGrey,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Main image dari assets
                    _buildMainImage(),

                    const SizedBox(height: 20),

                    // Task list
                    PurpleAlternativeTaskList(
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
                          AppRoutes.purpleTaskConfirmation,
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
                        ? PurpleTheme.primaryButtonGradient
                        : null,
                    color: _selectedTask != null ? null : PurpleTheme.borderLight,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: _selectedTask != null
                        ? [
                            BoxShadow(
                              color: PurpleTheme.primaryPurple.withValues(alpha: 0.4),
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
                            : PurpleTheme.textMuted,
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
                color: PurpleTheme.backgroundWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: PurpleTheme.shadowColor.withValues(alpha: 0.1),
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
                    color: PurpleTheme.borderLight,
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
                  color: PurpleTheme.borderMedium,
                  width: 2,
                ),
                color: PurpleTheme.backgroundWhite,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: PurpleTheme.primaryPurple,
                size: 18,
              ),
            ),
          ),
          const Spacer(),
          // Progress indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: PurpleTheme.primaryPurplePale,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: PurpleTheme.primaryPurple,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  'Pilih tugas lain',
                  style: TextStyle(
                    fontSize: 12,
                    color: PurpleTheme.primaryPurple,
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
      'assets/images/energitinggi/energi_alternative.png',
      width: double.infinity,
      height: 200,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback jika asset tidak ditemukan
        return Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: PurpleTheme.primaryPurplePale,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bolt_rounded,
                size: 60,
                color: PurpleTheme.primaryPurple,
              ),
              const SizedBox(height: 8),
              const Text(
                '⚡ Mindy siap membantu!',
                style: TextStyle(
                  fontSize: 16,
                  color: PurpleTheme.primaryPurple,
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