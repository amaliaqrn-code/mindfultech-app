import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/core/constants/colors.dart';
import 'package:mindfultech_app/presentation/homepage/bloc/homepage/homepage_cubit.dart';
import 'package:mindfultech_app/presentation/homepage/bloc/homepage/homepage_state.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_cubit.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_state.dart';
import 'package:mindfultech_app/presentation/task/bloc/task/task_bloc.dart';
import 'package:mindfultech_app/presentation/task/bloc/task/task_event.dart';
import 'package:mindfultech_app/presentation/task/bloc/task/task_state.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';

class HomepagePage extends StatefulWidget {
  const HomepagePage({super.key});

  @override
  State<HomepagePage> createState() => _HomepagePageState();
}

class _HomepagePageState extends State<HomepagePage> {
  @override
  void initState() {
    super.initState();
    // Load user tasks from SQLite on page open
    context.read<TaskBloc>().add(const FetchTasksEvent());
    // Load emotion data from database
    context.read<HomepageCubit>().loadEmotionData();
  }

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final userName = storage.read('userName') ?? 'Aluna';

    return BlocBuilder<HomepageCubit, HomepageState>(
      builder: (context, homeState) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<TaskBloc>().add(const FetchTasksEvent());
                      context.read<HomepageCubit>().loadEmotionData();
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          _buildHeader(userName),
                          const SizedBox(height: 20),
                          _buildMindyGreetingCard(homeState.mascotGreeting),
                          const SizedBox(height: 16),
                          _buildStatisticsSection(),
                          const SizedBox(height: 20),
                          _buildEmotionProgressSection(homeState),
                          const SizedBox(height: 20),
                          _buildTasksSection(),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(String userName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo, $userName! 👋',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Hari ini, mari bertumbuh bersama Mindy.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () async {
            // Await return from task creation flow so we can refresh on pop
            await Navigator.pushNamed(context, AppRoutes.createTaskCategory);
            // Re-fetch tasks when user returns, in case a new task was added
            if (mounted) {
              context.read<TaskBloc>().add(const FetchTasksEvent());
            }
          },
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.edit_outlined,
              color: Color.fromARGB(255, 16, 16, 16),
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  // ================= CARD SAPAAN MINDY =================
  Widget _buildMindyGreetingCard(String mascotGreeting) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xffEAF4FB),
            Color(0xffD4EDF7),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xffB8D4E8),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mascotGreeting,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.journey);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Mulai Sekarang',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Image.asset(
            'assets/images/homepage/awan.png',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.cloud, size: 80, color: AppColors.primary);
            },
          ),
        ],
      ),
    );
  }

  // ================= STATISTICS SECTION =================
  /// ✅ FIXED: Use data from JourneyCubit state directly
  Widget _buildStatisticsSection() {
    return BlocBuilder<JourneyCubit, JourneyState>(
      buildWhen: (previous, current) =>
          previous.totalDays != current.totalDays ||
          previous.streakCount != current.streakCount ||
          previous.currentLevel.level != current.currentLevel.level,
      builder: (context, journeyState) {
        // ✅ SAFE: Get data from JourneyCubit state with safe getters
        final streakText = '${journeyState.streakCount} / ${journeyState.totalDays} hari';
        final levelText = 'LEVEL ${journeyState.currentLevel.level.toString().padLeft(2, '0')}';

        return SizedBox(
          height: 180,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/homepage/background.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary.withValues(alpha: 0.1),
                              AppColors.primary.withValues(alpha: 0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.local_fire_department,
                        iconColor: const Color(0xFFFF6B35),
                        title: 'Streak hari ini',
                        value: streakText,
                        valueColor: const Color(0xFFFF6B35),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.map,
                        iconColor: AppColors.primary,
                        title: 'Perjalananmu',
                        value: levelText,
                        valueColor: AppColors.primary,
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

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

// 1. Deklarasikan list path emoji yang sama persis dengan yang ada di TimerFinishedPage
final List<String> _timerEmojis = [
  'assets/icon/timerpage/Cloud1.png',
  'assets/icon/timerpage/Cloud2.png',
  'assets/icon/timerpage/Cloud3.png',
  'assets/icon/timerpage/Cloud4.png',
  'assets/icon/timerpage/Cloud5.png',
  'assets/icon/timerpage/Cloud6.png',
];

// ================= REKAPAN EMOSI DENGAN INDIKATOR LEVEL =================
Widget _buildEmotionProgressSection(HomepageState homeState) {
  final int totalFocusSessions = homeState.totalFocusSessions;
  final List<int> savedEmojiIndices = homeState.savedEmojiIndices;
  const int totalSlots = 6;

  return BlocBuilder<JourneyCubit, JourneyState>(
    builder: (context, journeyState) {
      // ✅ FIX: Hitung currentSlot dengan formula yang BENAR
      //    currentSlot adalah slot yang AKAN dipakai untuk sesi berikutnya
      //    - totalDays = 0: currentSlot = 0 (slot pertama)
      //    - totalDays = 1: currentSlot = 1 (slot kedua, karena slot 0 sudah terisi)
      final int currentSlot = journeyState.totalDays % 6;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Rekapan Emosimu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F2FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Hari ${currentSlot + 1} dari $totalSlots',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2B92E4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F2FF),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(totalSlots, (index) {
                final int slotNumber = index; // Slot 0-5

                // ✅ FIX: Cek apakah ada emoji di slot ini
                //    savedEmojiIndices di-index berdasarkan dayNumber (0-5)
                //    Jika ada emoji di slot ini, tampilkan
                if (savedEmojiIndices.isNotEmpty && slotNumber < savedEmojiIndices.length) {
                  final emojiIndex = savedEmojiIndices[slotNumber];
                  return Image.asset(
                    _timerEmojis[emojiIndex],
                    width: 44,
                    height: 44,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.cloud_queue_rounded, color: AppColors.primary, size: 44);
                    },
                  );
                } else {
                  return _buildEmptyEmotionPlaceholder();
                }
              }),
            ),
          ),
          if (totalFocusSessions > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '$totalFocusSessions sesi fokus selesai',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
        ],
      );
    },
  );
}

  Widget _buildEmptyEmotionPlaceholder() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.cloud_rounded, size: 46, color: Colors.grey.shade300),
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Text('?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2B92E4))),
        ),
      ],
    );
  }

  // ================= TUGAS HARI INI =================
  Widget _buildTasksSection() {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, taskState) {
        // Sort tasks by priority: mendesak (0) -> penting (1) -> santai (2)
        final sortedTasks = List<TaskModel>.from(taskState.tasks)
          ..sort((a, b) => a.prioritas.value.compareTo(b.prioritas.value));

        // Take first 3 tasks for homepage display
        final displayTasks = sortedTasks.take(3).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tugas yang kamu punya',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.allTasks);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Lihat Semua',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (taskState.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else if (displayTasks.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.15), width: 1),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.inbox_outlined, size: 40, color: Colors.grey.shade400),
                      const SizedBox(height: 8),
                      Text(
                        'Belum ada tugas untuk hari ini',
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () async {
                          await Navigator.pushNamed(context, AppRoutes.createTaskCategory);
                          if (mounted) {
                            context.read<TaskBloc>().add(const FetchTasksEvent());
                          }
                        },
                        child: const Text('+ Tambah Tugas'),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...displayTasks.map((task) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTaskCard(
                      iconPath: _getCategoryIconPath(task.kategori),
                      title: task.namaTugas,
                      duration: task.formattedDuration,
                      category: task.kategori.displayName,
                    ),
                  )),
          ],
        );
      },
    );
  }

  String _getCategoryIconPath(TaskCategory category) {
    switch (category) {
      case TaskCategory.belajar:
        return 'assets/icon/homepage/belajar.png';
      case TaskCategory.pekerjaan:
        return 'assets/icon/homepage/belajar.png';
      case TaskCategory.kesehatan:
        return 'assets/icon/homepage/olahraga.png';
      case TaskCategory.pribadi:
        return 'assets/icon/homepage/menonton.png';
      case TaskCategory.rumah:
        return 'assets/icon/homepage/olahraga.png';
      case TaskCategory.lainnya:
        return 'assets/icon/homepage/menonton.png';
    }
  }

  // ================= TASK CARD =================
  Widget _buildTaskCard({
    required String iconPath,
    required String title,
    required String duration,
    required String category,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15), width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Image.asset(iconPath, width: 28, height: 28, errorBuilder: (context, error, stackTrace) => const Icon(Icons.assignment, color: AppColors.primary)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3748))),
                const SizedBox(height: 2),
                Text(duration, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(16)),
            child: Text(category, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
