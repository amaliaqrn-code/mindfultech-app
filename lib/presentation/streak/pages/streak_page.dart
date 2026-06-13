import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_cubit.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_state.dart';
import '../models/streak_models.dart';
import '../widgets/streak_widgets.dart';

class StreakPage extends StatefulWidget {
  const StreakPage({super.key});

  @override
  State<StreakPage> createState() => _StreakPageState();
}

class _StreakPageState extends State<StreakPage> with SingleTickerProviderStateMixin {
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

  List<AchievementLevel> get _achievements => AchievementLevel.getAchievements();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      body: SafeArea(
        child: BlocBuilder<JourneyCubit, JourneyState>(
          buildWhen: (previous, current) => previous.streakCount != current.streakCount,
          builder: (context, state) {
            // ✅ SAFE: All state access through BlocBuilder
            final currentStreak = state.streakCount;
            final theme = StreakTheme(streakDays: currentStreak);

            return Column(
              children: [
                _buildHeader(),
                StreakTabBar(
                  selectedIndex: _selectedTabIndex,
                  theme: theme, // ✅ Using theme from BlocBuilder state
                  tabController: _tabController,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildStreakSummary(currentStreak, theme),
                        _buildAchievementsTab(currentStreak),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Streak',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakSummary(int currentStreak, StreakTheme theme) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: Column(
        children: [
          StreakMindySection(theme: theme),
          const SizedBox(height: 16),
          StreakInfo(currentStreak: currentStreak, theme: theme),
          const SizedBox(height: 32),
          StreakProgressBar(theme: theme),
          const SizedBox(height: 12),
          Text(
            theme.getNextLevelInfo(),
            style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563), fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 40),
          StreakActionButton(onPressed: () => _tabController.animateTo(1)),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildAchievementsTab(int currentStreak) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      itemCount: _achievements.length,
      itemBuilder: (context, index) {
        final achievement = _achievements[index];
        final isUnlocked = currentStreak >= achievement.requiredDays;
        return AchievementCard(achievement: achievement, isUnlocked: isUnlocked);
      },
    );
  }
}
