import 'package:flutter/material.dart';
import '../models/streak_models.dart';

class StreakTabBar extends StatelessWidget {
  final int selectedIndex;
  final StreakTheme theme;
  final TabController tabController;

  const StreakTabBar({
    super.key,
    required this.selectedIndex,
    required this.theme,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTabItem('Streak', 0)),
          Expanded(child: _buildTabItem('Pencapaian', 1)),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, int index) {
    final isSelected = selectedIndex == index;
    
    // Terapkan dekorasi warna atau gradient sesuai pilihan figma
    BoxDecoration decoration = const BoxDecoration();
    if (isSelected) {
      if (index == 0) {
        decoration = BoxDecoration(
          color: const Color(0xFF64B5F6).withValues(alpha: 0.2), // Pendekatan soft blue untuk tab streak biasa
          borderRadius: BorderRadius.circular(20),
        );
      } else {
        decoration = BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF42A5F5), Color(0xFF26A69A)], // Gradient Cyan-Toska khas figma pencapaian
          ),
          borderRadius: BorderRadius.circular(20),
        );
      }
    }

    return GestureDetector(
      onTap: () => tabController.animateTo(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.all(4),
        decoration: decoration,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected 
                  ? (index == 1 ? Colors.white : const Color(0xFF1E88E5)) 
                  : const Color(0xFF9CA3AF),
            ),
          ),
        ),
      ),
    );
  }
}

class StreakMindySection extends StatelessWidget {
  final StreakTheme theme;

  const StreakMindySection({super.key, required this.theme});

  String get _streakImagePath {
    if (theme.streakDays >= 30) return 'assets/images/streak/streak_legend.png';
    if (theme.streakDays >= 25) return 'assets/images/streak/streak_hebat.png';
    if (theme.streakDays >= 20) return 'assets/images/streak/streak_fokus.png';
    if (theme.streakDays >= 15) return 'assets/images/streak/streak_bersemangat.png';
    if (theme.streakDays >= 10) return 'assets/images/streak/streak_konsisten.png';
    return 'assets/images/streak/streak_pemula.png';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Gambar Mindy langsung mengambang transparan (Tanpa container lingkaran putih kaku)
          Image.asset(
            _streakImagePath,
            width: 150,
            height: 150,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.cloud_queue_rounded,
                color: theme.mainColor,
                size: 120,
              );
            },
          ),
          // Bintang ornamen kecil di sekitar Mindy
          Positioned(
            left: 40, top: 20,
            child: Icon(Icons.star_rounded, color: theme.mainColor.withValues(alpha: 0.6), size: 16),
          ),
          Positioned(
            right: 40, bottom: 30,
            child: Icon(Icons.star_rounded, color: theme.mainColor.withValues(alpha: 0.5), size: 20),
          ),
        ],
      ),
    );
  }
}

class StreakInfo extends StatelessWidget {
  final int currentStreak;
  final StreakTheme theme;

  const StreakInfo({super.key, required this.currentStreak, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Streak kamu saat ini',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4B5563),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '$currentStreak',
              style: TextStyle(
                fontSize: 64, // Lebih besar menyerupai Figma
                fontWeight: FontWeight.bold,
                color: theme.mainColor, // Warna teks berubah sesuai level!
                height: 1,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Hari',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class StreakProgressBar extends StatelessWidget {
  final StreakTheme theme;

  const StreakProgressBar({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Sisi slider/bar utama
        Container(
          height: 14,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFE5E7EB),
            borderRadius: BorderRadius.circular(7),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWith = constraints.maxWidth;
              final currentWidth = maxWith * theme.progressPercent.clamp(0.0, 1.0);
              
              return Stack(
                alignment: Alignment.centerLeft,
                clipBehavior: Clip.none,
                children: [
                  // Isian Bar Gradient Dinamis
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: currentWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: theme.progressGradient),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  // Icon Api Di Ujung Progress Bar Berwarna Senada
                  Positioned(
                    left: currentWidth - 6 < 0 ? 0 : currentWidth - 6,
                    child: Icon(
                      Icons.local_fire_department_rounded,
                      size: 18,
                      color: theme.mainColor,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class StreakActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StreakActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4FC3F7), Color(0xFF4DB6AC)], // Gradasi tombol utama di figma
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4DB6AC).withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Lihat Pencapaian',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

class AchievementCard extends StatelessWidget {
  final AchievementLevel achievement;
  final bool isUnlocked;

  const AchievementCard({super.key, required this.achievement, required this.isUnlocked});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        children: [
          // Warna Api sesuai kategori masing-masing di Figma
          Icon(
            Icons.local_fire_department_rounded,
            size: 36,
            color: isUnlocked ? achievement.activeColor : const Color(0xFFD1D5DB),
          ),
          const SizedBox(width: 16),
          
          // Informasi teks teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? const Color(0xFF1F2937) : const Color(0xFF9CA3AF),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  achievement.description,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                ),
              ],
            ),
          ),
          
          // Kunci status gembok/lock
          Icon(
            isUnlocked ? Icons.check_circle_rounded : Icons.lock_rounded,
            size: 18,
            color: isUnlocked ? const Color(0xFF10B981) : const Color(0xFF9CA3AF),
          ),
        ],
      ),
    );
  }
}