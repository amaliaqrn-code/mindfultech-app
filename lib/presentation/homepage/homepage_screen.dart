import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/core/constants/colors.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final userName = storage.read('userName') ?? 'Aluna';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ================= MAIN CONTENT AREA =================
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // ================= HEADER =================
                    _buildHeader(userName),

                    const SizedBox(height: 20),

                    // ================= BANNER MASCOT CARD =================
                    _buildBannerCard(),

                    const SizedBox(height: 20),

                    // ================= STATISTICS SECTION =================
                    _buildStatisticsSection(),

                    const SizedBox(height: 20),

                    // ================= MAIN ACTION BUTTON =================
                    _buildMainActionButton(),

                    const SizedBox(height: 24),

                    // ================= TASKS SECTION TITLE =================
                    _buildTasksSectionTitle(),

                    const SizedBox(height: 14),

                    // ================= TASK LIST =================
                    _buildTaskCard(
                      iconPath: 'assets/icon/homepage/belajar.png',
                      title: 'Belajar',
                      duration: '20 Menit Fokus',
                      category: 'Belajar',
                      categoryColor: AppColors.primary,
                    ),

                    const SizedBox(height: 12),

                    _buildTaskCard(
                      iconPath: 'assets/icon/homepage/olahraga.png',
                      title: 'Olahraga Lari',
                      duration: '15 Menit Fokus',
                      category: 'Kesehatan',
                      categoryColor: const Color(0xff4CAF50),
                    ),

                    const SizedBox(height: 12),

                    _buildTaskCard(
                      iconPath: 'assets/icon/homepage/menonton.png',
                      title: 'Menonton Film',
                      duration: '20 Menit Fokus',
                      category: 'Pribadi',
                      categoryColor: const Color(0xffFF9800),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ================= BOTTOM NAVIGATION BAR =================
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(String userName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
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
                'Hari ini, mari bertumbuh bersama mindy.',
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
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: const ClipOval(
            child: Image(
              image: AssetImage('assets/images/profile.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  // ================= BANNER MASCOT CARD =================
  Widget _buildBannerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffEAF0FA),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Yuk mulai hari',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'produktif bareng',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Mindy!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Image.asset(
            'assets/images/homepage/awan.png',
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  // ================= STATISTICS SECTION =================
  Widget _buildStatisticsSection() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          // Background Mountain Image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.asset(
                'assets/images/homepage/background.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay Cards
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Row(
              children: [
                // Left Card - Streak
                Expanded(
                  child: _buildStatCard(
                    iconPath: 'assets/icon/homepage/streak.png',
                    title: 'Streak hari ini',
                    value: '5',
                    suffix: '/ 30 hari',
                  ),
                ),
                const SizedBox(width: 12),
                // Right Card - Journey
                Expanded(
                  child: _buildStatCard(
                    iconPath: 'assets/icon/homepage/perjalanan.png',
                    title: 'Perjalananmu',
                    value: 'LEVEL 01',
                    isTextValue: true,
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
    required String iconPath,
    required String title,
    required String value,
    String? suffix,
    bool isTextValue = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
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
              Image.asset(
                iconPath,
                width: 22,
                height: 22,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (isTextValue)
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            )
          else
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  if (suffix != null)
                    TextSpan(
                      text: suffix,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ================= MAIN ACTION BUTTON =================
  Widget _buildMainActionButton() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.journey);
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [
              Color(0xff4597E6),
              Color(0xff83DFC6),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Image(
                  image: AssetImage('assets/icon/homepage/play.png'),
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Mulai Fokus',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= TASKS SECTION TITLE =================
  Widget _buildTasksSectionTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Tugas hari ini',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            '3 tugas',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 26,
                height: 26,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  duration,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: categoryColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: categoryColor,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= BOTTOM NAVIGATION BAR =================
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: 'Beranda',
                isActive: _currentNavIndex == 0,
                onTap: () => setState(() => _currentNavIndex = 0),
              ),
              _buildNavItem(
                icon: Icons.timer_outlined,
                label: 'Fokus',
                isActive: _currentNavIndex == 1,
                onTap: () {
                  setState(() => _currentNavIndex = 1);
                  Get.toNamed(AppRoutes.timer);
                },
              ),
              _buildNavItem(
                icon: Icons.map_outlined,
                label: 'Journey',
                isActive: _currentNavIndex == 2,
                onTap: () {
                  setState(() => _currentNavIndex = 2);
                  Get.toNamed(AppRoutes.journey);
                },
              ),
              _buildNavItem(
                icon: Icons.local_fire_department_outlined,
                label: 'Streak',
                isActive: _currentNavIndex == 3,
                onTap: () => setState(() => _currentNavIndex = 3),
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                label: 'Profil',
                isActive: _currentNavIndex == 4,
                onTap: () => setState(() => _currentNavIndex = 4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 26,
              color: isActive ? AppColors.primary : Colors.grey.shade400,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? AppColors.primary : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}