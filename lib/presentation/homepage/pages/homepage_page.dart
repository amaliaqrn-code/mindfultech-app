import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/core/constants/colors.dart';
import 'package:mindfultech_app/presentation/profile/pages/profile_page.dart';
import 'package:mindfultech_app/presentation/homepage/bloc/homepage/homepage_cubit.dart';
import 'package:mindfultech_app/presentation/homepage/bloc/homepage/homepage_state.dart';
import 'package:mindfultech_app/presentation/task/bloc/task/task_bloc.dart';
import 'package:mindfultech_app/presentation/task/bloc/task/task_event.dart';

class HomepagePage extends StatefulWidget {
  const HomepagePage({super.key});

  @override
  State<HomepagePage> createState() => _HomepagePageState();
}

class _HomepagePageState extends State<HomepagePage> {
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load user tasks from SQLite on page open
    context.read<TaskBloc>().add(const FetchTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final userName = storage.read('userName') ?? 'Aluna';

    return BlocBuilder<HomepageCubit, HomepageState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        _buildHeader(userName),
                        const SizedBox(height: 20),
                        _buildMindyGreetingCard(state.mascotGreeting),
                        const SizedBox(height: 16),
                        _buildStatisticsSection(state),
                        const SizedBox(height: 20),
                        _buildEmotionProgressSection(state),
                        const SizedBox(height: 20),
                        _buildTasksSection(state),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomNavBar(context),
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
          ),
        ],
      ),
    );
  }

  // ================= STATISTICS SECTION =================
  Widget _buildStatisticsSection(HomepageState state) {
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                state.backgroundImagePath,
                fit: BoxFit.cover,
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
                    value: state.streakText,
                    valueColor: const Color(0xFFFF6B35),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.map,
                    iconColor: AppColors.primary,
                    title: 'Perjalananmu',
                    value: state.levelText,
                    valueColor: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

  // ================= REKAPAN EMOSI DENGAN INDIKATOR LEVEL =================
  Widget _buildEmotionProgressSection(HomepageState state) {
    final int collectedEmotions = 1;
    const int totalLevels = 6;

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
                '$collectedEmotions dari $totalLevels level',
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
            children: List.generate(totalLevels, (index) {
              if (index < collectedEmotions) {
                return Image.asset(
                  'assets/images/homepage/awan.png',
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
      ],
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
  Widget _buildTasksSection(HomepageState state) {
    final tasks = state.currentTasks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tugas Hari Ini',
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
        if (tasks.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text('Belum ada tugas untuk hari ini.', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
          )
        else
          ...tasks.map((task) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildTaskCard(
                  iconPath: task.iconPath,
                  title: task.title,
                  duration: task.duration,
                  category: task.category,
                  categoryColor: task.categoryColor,
                ),
              )),
      ],
    );
  }

  // ================= TASK CARD =================
  Widget _buildTaskCard({
    required String iconPath,
    required String title,
    required String duration,
    required String category,
    required Color categoryColor,
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
            decoration: BoxDecoration(color: categoryColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(16)),
            child: Text(category, style: TextStyle(color: categoryColor, fontWeight: FontWeight.w600, fontSize: 11)),
          ),
        ],
      ),
    );
  }

  // ================= BOTTOM NAVIGATION BAR =================
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 20, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context: context, icon: Icons.home_rounded, label: 'Beranda', isActive: _currentNavIndex == 0, onTap: () => setState(() => _currentNavIndex = 0)),
              _buildNavItem(context: context, icon: Icons.timer_outlined, label: 'Fokus', isActive: _currentNavIndex == 1, onTap: () { setState(() => _currentNavIndex = 1); Navigator.pushNamed(context, AppRoutes.timer); }),
              _buildNavItem(context: context, icon: Icons.map_outlined, label: 'Journey', isActive: _currentNavIndex == 2, onTap: () { setState(() => _currentNavIndex = 2); Navigator.pushNamed(context, AppRoutes.journey); }),
              _buildNavItem(context: context, icon: Icons.local_fire_department_outlined, label: 'Streak', isActive: _currentNavIndex == 3, onTap: () { setState(() => _currentNavIndex = 3); Navigator.pushNamed(context, AppRoutes.streak); }),
              _buildNavItem(context: context, icon: Icons.person_outline, label: 'Profil', isActive: _currentNavIndex == 4, onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())); }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required BuildContext context, required IconData icon, required String label, required bool isActive, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 26, color: isActive ? AppColors.primary : Colors.grey.shade400),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 10, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal, color: isActive ? AppColors.primary : Colors.grey.shade500)),
          ],
        ),
      ),
    );
  }
}