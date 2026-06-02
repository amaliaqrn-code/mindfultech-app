import 'package:flutter/material.dart';
import '../models/streak_models.dart';
import '../widgets/streak_widgets.dart';

/// ============================================================
/// STREAK SCREEN - Main page for Streak feature
///
/// Folder: lib/presentation/streak/screens/
///
/// Aset yang dibutuhkan:
/// - assets/images/streak/mindyStreak.png
/// ============================================================

class StreakScreen extends StatefulWidget {
  const StreakScreen({super.key});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> with SingleTickerProviderStateMixin {
  // ============================================================
  // STATE MANAGEMENT
  // ============================================================

  /// Ubah nilai ini untuk testing different streak levels
  /// Coba: 5, 10, 15, 20, 25, 30
  int _currentStreak = 5;

  int _selectedTabIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  StreakTheme get _theme => StreakTheme(streakDays: _currentStreak);
  List<AchievementLevel> get _achievements => AchievementLevel.getAchievements(_currentStreak);

  // ============================================================
  // BUILD METHOD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            StreakAppBar(
              theme: _theme,
              onBackPressed: () => Navigator.pop(context),
            ),

            // Custom Tab Bar
            StreakTabBar(
              selectedIndex: _selectedTabIndex,
              theme: _theme,
              onTabChanged: (index) => _tabController.animateTo(index),
            ),

            // Content
            Expanded(
              child: _selectedTabIndex == 0
                  ? _buildStreakSummary()
                  : _buildAchievementsList(),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TAB 1: STREAK SUMMARY
  // ============================================================

  Widget _buildStreakSummary() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Mindy Asset with Torch
          MindySection(theme: _theme),

          const SizedBox(height: 24),

          // Streak Info
          StreakInfo(
            currentStreak: _currentStreak,
            theme: _theme,
          ),

          const SizedBox(height: 24),

          // Progress Bar
          StreakProgressBar(
            theme: _theme,
            currentStreak: _currentStreak,
          ),

          const SizedBox(height: 32),

          // Action Button
          StreakActionButton(
            theme: _theme,
            text: 'Lihat Pencapaian',
            onPressed: () => _tabController.animateTo(1),
          ),

          const SizedBox(height: 16),

          // Debug Info (untuk testing)
          StreakDebugControls(
            currentStreak: _currentStreak,
            theme: _theme,
            onStreakChanged: (days) => setState(() => _currentStreak = days),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TAB 2: ACHIEVEMENTS LIST
  // ============================================================

  Widget _buildAchievementsList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      itemCount: _achievements.length,
      itemBuilder: (context, index) {
        final achievement = _achievements[index];
        return AchievementCard(
          achievement: achievement,
          isUnlocked: achievement.isUnlocked,
          index: index,
        );
      },
    );
  }
}