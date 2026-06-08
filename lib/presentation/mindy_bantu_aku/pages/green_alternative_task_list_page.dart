import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/models/task_model.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/theme/green_theme.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/widgets/green_alternative_task_list.dart';

/// ============================================================
/// GREEN ALTERNATIVE TASK LIST SCREEN
/// Halaman untuk memilih tugas lain (alternative)
/// ============================================================

class GreenAlternativeTaskListPage extends StatefulWidget {
  final TaskCategory category;
  final String? excludeTaskId;

  const GreenAlternativeTaskListPage({
    super.key,
    required this.category,
    this.excludeTaskId,
  });

  @override
  State<GreenAlternativeTaskListPage> createState() =>
      _GreenAlternativeTaskListPageState();
}

class _GreenAlternativeTaskListPageState
    extends State<GreenAlternativeTaskListPage> {
  TaskModel? _selectedTask;

  // Sample tasks for each category (low energy tasks)
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
            title: 'Baca buku 5 menit',
            description: 'Membaca buku ringan selama 5 menit untuk melatih fokus',
            category: TaskCategory.belajar,
            energyLevel: EnergyLevel.low,
            iconName: 'menu_book',
            estimatedMinutes: 5,
          ),
          const TaskModel(
            id: 'belajar_2',
            title: 'Belajar vocabulary baru',
            description: 'Menghafal 3-5 kata baru dalam bahasa asing',
            category: TaskCategory.belajar,
            energyLevel: EnergyLevel.low,
            iconName: 'translate',
            estimatedMinutes: 10,
          ),
          const TaskModel(
            id: 'belajar_3',
            title: 'Baca artikel pendek',
            description: 'Membaca satu artikel singkat yang menarik',
            category: TaskCategory.belajar,
            energyLevel: EnergyLevel.low,
            iconName: 'article',
            estimatedMinutes: 10,
          ),
        ];
      case TaskCategory.pekerjaan:
        return [
          const TaskModel(
            id: 'pekerjaan_1',
            title: 'Baca email penting',
            description: 'Memeriksa dan merespons email yang penting saja',
            category: TaskCategory.pekerjaan,
            energyLevel: EnergyLevel.low,
            iconName: 'email',
            estimatedMinutes: 10,
          ),
          const TaskModel(
            id: 'pekerjaan_2',
            title: 'Update to-do list',
            description: 'Membuat atau memperbarui daftar tugas hari ini',
            category: TaskCategory.pekerjaan,
            energyLevel: EnergyLevel.low,
            iconName: 'assignment',
            estimatedMinutes: 5,
          ),
        ];
      case TaskCategory.kesehatan:
        return [
          const TaskModel(
            id: 'kesehatan_1',
            title: 'Stretching ringan',
            description: 'Regangan ringan selama 5 menit untuk melepas ketegangan',
            category: TaskCategory.kesehatan,
            energyLevel: EnergyLevel.low,
            iconName: 'self_improvement',
            estimatedMinutes: 5,
          ),
          const TaskModel(
            id: 'kesehatan_2',
            title: 'Minum air putih',
            description: 'Memastikan tubuh terhidrasi dengan baik',
            category: TaskCategory.kesehatan,
            energyLevel: EnergyLevel.low,
            iconName: 'local_cafe',
            estimatedMinutes: 2,
          ),
        ];
      case TaskCategory.selfCare:
        return [
          const TaskModel(
            id: 'selfcare_1',
            title: 'Journaling',
            description: 'Menulis perasaan dan pikiran di jurnal',
            category: TaskCategory.selfCare,
            energyLevel: EnergyLevel.low,
            iconName: 'edit',
            estimatedMinutes: 10,
          ),
          const TaskModel(
            id: 'selfcare_2',
            title: 'Meditasi singkat',
            description: 'Menenangkan pikiran dengan meditasi 5 menit',
            category: TaskCategory.selfCare,
            energyLevel: EnergyLevel.low,
            iconName: 'spa',
            estimatedMinutes: 5,
          ),
          const TaskModel(
            id: 'selfcare_3',
            title: 'Breathe exercise',
            description: 'Latihan pernapasan untuk menenangkan diri',
            category: TaskCategory.selfCare,
            energyLevel: EnergyLevel.low,
            iconName: 'face',
            estimatedMinutes: 5,
          ),
        ];
      case TaskCategory.rumah:
        return [
          const TaskModel(
            id: 'rumah_1',
            title: 'Rapikan meja',
            description: 'Membersihkan dan merapikan permukaan meja',
            category: TaskCategory.rumah,
            energyLevel: EnergyLevel.low,
            iconName: 'desk',
            estimatedMinutes: 5,
          ),
          const TaskModel(
            id: 'rumah_2',
            title: 'Rapikan tempat tidur',
            description: 'Membuat tempat tidur rapi dan bersih',
            category: TaskCategory.rumah,
            energyLevel: EnergyLevel.low,
            iconName: 'bed',
            estimatedMinutes: 3,
          ),
        ];
      case TaskCategory.hubungan:
        return [
          const TaskModel(
            id: 'hubungan_1',
            title: 'Kirim pesan ke keluarga',
            description: 'Mengirim pesan singkat ke anggota keluarga',
            category: TaskCategory.hubungan,
            energyLevel: EnergyLevel.low,
            iconName: 'chat',
            estimatedMinutes: 5,
          ),
          const TaskModel(
            id: 'hubungan_2',
            title: 'Telfon teman dekat',
            description: 'Menelepon teman dekat untuk mengecek kabar',
            category: TaskCategory.hubungan,
            energyLevel: EnergyLevel.low,
            iconName: 'call',
            estimatedMinutes: 10,
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GreenTheme.backgroundPage,
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
                        color: GreenTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    const Text(
                      'Pilih task yang ingin kamu kerjakan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: GreenTheme.textGrey,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Main image dari assets
                    _buildMainImage(),

                    const SizedBox(height: 20),

                    // Task list
                    GreenAlternativeTaskList(
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
                          AppRoutes.greenTaskConfirmation,
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
                        ? GreenTheme.primaryButtonGradient
                        : null,
                    color: _selectedTask != null ? null : GreenTheme.borderLight,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: _selectedTask != null
                        ? [
                            BoxShadow(
                              color: GreenTheme.sageGreen.withValues(alpha: 0.4),
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
                            : GreenTheme.textMuted,
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
                color: GreenTheme.backgroundWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: GreenTheme.shadowColor.withValues(alpha: 0.1),
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
                    color: GreenTheme.borderLight,
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
                  color: GreenTheme.borderMedium,
                  width: 2,
                ),
                color: GreenTheme.backgroundWhite,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: GreenTheme.sageGreen,
                size: 18,
              ),
            ),
          ),
          const Spacer(),
          // Progress indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: GreenTheme.sageGreenLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: GreenTheme.sageGreen,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  'Pilih tugas lain',
                  style: TextStyle(
                    fontSize: 12,
                    color: GreenTheme.sageGreen,
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
      'assets/images/energirendah/energi_rendah_alternative.png',
      width: double.infinity,
      height: 200,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback jika asset tidak ditemukan
        return Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: GreenTheme.sageGreenLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.spa_rounded,
                size: 60,
                color: GreenTheme.sageGreen,
              ),
              const SizedBox(height: 8),
              const Text(
                '☁️ Mindy siap membantu!',
                style: TextStyle(
                  fontSize: 16,
                  color: GreenTheme.sageGreen,
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