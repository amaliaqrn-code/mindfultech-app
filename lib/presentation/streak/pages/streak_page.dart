import 'package:flutter/material.dart';
import '../models/streak_models.dart';
import '../widgets/streak_widgets.dart';

class StreakPage extends StatefulWidget {
  const StreakPage({super.key});

  @override
  State<StreakPage> createState() => _StreakPageState();
}

class _StreakPageState extends State<StreakPage> with SingleTickerProviderStateMixin {
  int _currentStreak = 5; // Default testing
  int _selectedTabIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() => _selectedTabIndex = _tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  StreakTheme get _theme => StreakTheme(streakDays: _currentStreak);
  List<AchievementLevel> get _achievements => AchievementLevel.getAchievements();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // Latar Biru Cerah Sesuai Figma canvas
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            StreakTabBar(
              selectedIndex: _selectedTabIndex,
              theme: _theme,
              tabController: _tabController,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF9FAFB), // Putih susu lembut untuk area konten dasar
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildStreakSummary(),
                    _buildAchievementsTab(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          ),
          const Text(
            'Streak',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(width: 40), // Spasi penyeimbang back button
        ],
      ),
    );
  }

  Widget _buildStreakSummary() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: Column(
        children: [
          StreakMindySection(theme: _theme),
          const SizedBox(height: 16),
          StreakInfo(currentStreak: _currentStreak, theme: _theme),
          const SizedBox(height: 32),
          StreakProgressBar(theme: _theme),
          const SizedBox(height: 12),
          Text(
            _theme.getNextLevelInfo(),
            style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563), fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 40),
          StreakActionButton(onPressed: () => _tabController.animateTo(1)),
          const SizedBox(height: 32),
          _buildDebugControls(),
        ],
      ),
    );
  }

  Widget _buildAchievementsTab() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      itemCount: _achievements.length,
      itemBuilder: (context, index) {
        final achievement = _achievements[index];
        final isUnlocked = _currentStreak >= achievement.requiredDays;
        return AchievementCard(achievement: achievement, isUnlocked: isUnlocked);
      },
    );
  }

  Widget _buildDebugControls() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          const Text('Simulasi Pengujian Hari:', style: TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: [5, 10, 15, 20, 25, 30].map((days) {
              final active = _currentStreak == days;
              return ChoiceChip(
                label: Text('$days Hari'),
                selected: active,
                onSelected: (_) => setState(() => _currentStreak = days),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}