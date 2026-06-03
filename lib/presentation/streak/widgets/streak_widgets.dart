import 'package:flutter/material.dart';
import '../models/streak_models.dart';

/// Streak Widgets - Reusable UI components

class StreakAppBar extends StatelessWidget {
  final StreakTheme theme;
  final VoidCallback onBackPressed;

  const StreakAppBar({super.key, required this.theme, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildIconButton(Icons.arrow_back_ios_new_rounded, theme.primaryColor, onBackPressed),
          const Spacer(),
          const Text('Streak', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Spacer(),
          _buildIconButton(Icons.calendar_today_rounded, theme.primaryColor, () {}),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))]),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
}

class StreakTabBar extends StatelessWidget {
  final int selectedIndex;
  final StreakTheme theme;
  final TabController tabController;

  const StreakTabBar({super.key, required this.selectedIndex, required this.theme, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]),
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
    return GestureDetector(
      onTap: () => tabController.animateTo(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: isSelected ? theme.primaryColor.withValues(alpha: 0.1) : Colors.transparent, borderRadius: BorderRadius.circular(12)),
        child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isSelected ? theme.primaryColor : Colors.grey.shade400)),
      ),
    );
  }
}

class StreakMindySection extends StatelessWidget {
  final StreakTheme theme;

  const StreakMindySection({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(left: 20, top: 30, child: _buildDecorStar(12, theme.primaryColor.withValues(alpha: 0.3))),
          Positioned(right: 30, top: 20, child: _buildDecorStar(8, theme.secondaryColor.withValues(alpha: 0.4))),
          Positioned(left: 50, bottom: 40, child: _buildDecorStar(10, theme.primaryColor.withValues(alpha: 0.25))),
          Positioned(right: 50, bottom: 30, child: _buildDecorStar(6, theme.secondaryColor.withValues(alpha: 0.35))),
          Image.asset('assets/images/streak/mindyStreak.png', height: 180, fit: BoxFit.contain, errorBuilder: (_, __, ___) => Container(width: 160, height: 180, decoration: BoxDecoration(color: theme.primaryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(80)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.cloud_rounded, size: 60, color: theme.primaryColor), const SizedBox(height: 8), Text('Mindy Streak', style: TextStyle(fontSize: 12, color: theme.primaryColor, fontWeight: FontWeight.w600))]))),
        ],
      ),
    );
  }

  Widget _buildDecorStar(double size, Color color) => Container(width: size, height: size, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}

class StreakInfo extends StatelessWidget {
  final int currentStreak;
  final StreakTheme theme;

  const StreakInfo({super.key, required this.currentStreak, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text('$currentStreak', style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: theme.primaryColor, height: 1)),
            const SizedBox(width: 8),
            Text('Hari', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: theme.secondaryColor)),
          ],
        ),
        const SizedBox(height: 8),
        const Text('Terus pertahankan streakmu!', style: TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: theme.primaryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
          child: Text('${(theme.progressPercent * 100).toInt()}%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.primaryColor)),
        ),
      ],
    );
  }
}

class StreakProgressBar extends StatelessWidget {
  final StreakTheme theme;
  final int currentStreak;

  const StreakProgressBar({super.key, required this.theme, required this.currentStreak});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Progress ke level selanjutnya', style: TextStyle(fontSize: 13, color: Colors.grey)),
            Text('$currentStreak/30 Hari', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: theme.primaryColor)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 16,
          decoration: BoxDecoration(color: theme.primaryColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
          child: Stack(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: theme.progressPercent.clamp(0.0, 1.0)),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) => FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: value,
                  child: Container(
                    decoration: BoxDecoration(gradient: LinearGradient(colors: theme.progressGradient), borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: theme.primaryColor.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 2))]),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_fire_department_rounded, size: 16, color: theme.flameColor),
            const SizedBox(width: 4),
            Text(theme.getNextLevelInfo(), style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}

class StreakActionButton extends StatelessWidget {
  final StreakTheme theme;
  final VoidCallback onPressed;

  const StreakActionButton({super.key, required this.theme, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity, height: 52,
        decoration: BoxDecoration(gradient: LinearGradient(colors: theme.progressGradient, begin: Alignment.centerLeft, end: Alignment.centerRight), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: theme.primaryColor.withValues(alpha: 0.35), blurRadius: 12, offset: const Offset(0, 4))]),
        child: const Center(child: Text('Lihat Pencapaian', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
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
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Row(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(color: isUnlocked ? achievement.torchColor.withValues(alpha: 0.15) : Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.local_fire_department_rounded, size: 28, color: isUnlocked ? achievement.torchColor : Colors.grey.shade400),
                if (!isUnlocked)
                  Positioned(
                    right: 0, bottom: 0,
                    child: Container(
                      width: 20, height: 20,
                      decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                      child: const Icon(Icons.lock_rounded, size: 12, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(achievement.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: isUnlocked ? Colors.black87 : Colors.grey)),
                const SizedBox(height: 4),
                Text(achievement.description, style: TextStyle(fontSize: 13, color: isUnlocked ? Colors.grey.shade500 : Colors.grey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: isUnlocked ? achievement.torchColor.withValues(alpha: 0.15) : Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.local_fire_department_rounded, size: 14, color: isUnlocked ? achievement.torchColor : Colors.grey),
                const SizedBox(width: 4),
                Text('${achievement.requiredDays}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isUnlocked ? achievement.torchColor : Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
