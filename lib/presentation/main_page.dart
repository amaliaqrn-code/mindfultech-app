import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/core/constants/colors.dart';
import 'package:mindfultech_app/data/repositories/auth_repository.dart';
import 'package:mindfultech_app/presentation/homepage/pages/homepage_page.dart';
import 'package:mindfultech_app/presentation/journey/pages/journey_page.dart';
import 'package:mindfultech_app/presentation/streak/pages/streak_page.dart';
import 'package:mindfultech_app/presentation/profile/pages/profile_page.dart';
import 'package:mindfultech_app/presentation/timer/pages/setup_timer_page.dart';
import 'package:mindfultech_app/presentation/timer/bloc/timer/timer_bloc.dart';

/// ============================================================
/// MAIN PAGE - Base Shell dengan Bottom Navigation Bar
///
/// Pattern: Shell Page
/// - Membungkus halaman dengan Scaffold + BottomNavBar
/// - Content berubah berdasarkan tab yang dipilih menggunakan IndexedStack
/// - Setiap tab menjaga state-nya saat berpindah
/// ============================================================

class MainPage extends StatefulWidget {
  const MainPage({super.key, required AuthRepository authRepository});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentNavIndex = 0;

  /// List halaman pages - urutan harus sesuai dengan BottomNavigationBar items
  /// 0: Beranda (HomepagePage)
  /// 1: Fokus (SetupTimerPage) - tab Fokus menggunakan halaman ini
  /// 2: Journey (JourneyPage)
  /// 3: Streak (StreakPage)
  /// 4: Profil (ProfileScreen)
  final List<Widget> _pages = [
    const HomepagePage(),
    BlocProvider(
      create: (_) => TimerBloc(),
      child: const SetupTimerPage(task: null),
    ),
    const JourneyPage(),
    const StreakPage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _currentNavIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

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
                onTap: () => _onNavTap(0),
              ),
              _buildNavItem(
                icon: Icons.timer_outlined,
                label: 'Fokus',
                isActive: _currentNavIndex == 1,
                onTap: () => _onNavTap(1),
              ),
              _buildNavItem(
                icon: Icons.map_outlined,
                label: 'Journey',
                isActive: _currentNavIndex == 2,
                onTap: () => _onNavTap(2),
              ),
              _buildNavItem(
                icon: Icons.local_fire_department_outlined,
                label: 'Streak',
                isActive: _currentNavIndex == 3,
                onTap: () => _onNavTap(3),
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                label: 'Profil',
                isActive: _currentNavIndex == 4,
                onTap: () => _onNavTap(4),
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

  void _onNavTap(int index) {
    // Tab Fokus (index 1) sekarang menggunakan SetupTimerPage yang sudah ada di IndexedStack
    // Tidak perlu navigasi via named route lagi
    setState(() => _currentNavIndex = index);
  }
}
