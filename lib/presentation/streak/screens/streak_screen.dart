import 'package:flutter/material.dart';
import '../models/streak_models.dart';
import '../widgets/streak_widgets.dart';

// Streak itu pake build listener karena melakukan update UI berdasarkan perubahan streak,
// misalnya dari streak 5 ke streak 6, maka UI nya akan berubah sesuai dengan tema yang sudah ditentukan untuk streak 6. Jadi setiap kali streak berubah, UI nya juga harus berubah untuk mencerminkan perubahan tersebut.
class StreakScreen extends StatefulWidget {
  const StreakScreen({super.key});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> with SingleTickerProviderStateMixin {
  int _currentStreak = 5;
  int _selectedTabIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
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
  List<AchievementLevel> get _achievements => AchievementLevel.getAchievements(_currentStreak);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      body: SafeArea(
        child: Column(
          children: [
            StreakAppBar(theme: _theme, onBackPressed: () => Navigator.pop(context)),
            StreakTabBar(selectedIndex: _selectedTabIndex, theme: _theme, tabController: _tabController),
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

  Widget _buildStreakSummary() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          StreakMindySection(theme: _theme),
          const SizedBox(height: 24),
          StreakInfo(currentStreak: _currentStreak, theme: _theme),
          const SizedBox(height: 24),
          StreakProgressBar(theme: _theme, currentStreak: _currentStreak),
          const SizedBox(height: 32),
          StreakActionButton(theme: _theme, onPressed: () => _tabController.animateTo(1)),
          const SizedBox(height: 24),
          _buildDebugControls(),
        ],
      ),
    );
  }

  Widget _buildDebugControls() {
    return Column(
      children: [
        const Text('Testing Controls', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [5, 10, 15, 20, 25, 30].map((days) {
            final isSelected = _currentStreak == days;
            return GestureDetector(
              onTap: () => setState(() => _currentStreak = days),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? _theme.primaryColor : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$days Hari',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : Colors.grey.shade600),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAchievementsList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      itemCount: _achievements.length,
      itemBuilder: (context, index) {
        final achievement = _achievements[index];
        final isActuallyUnlocked = index == 3 || achievement.isUnlocked;
        return AchievementCard(achievement: achievement, isUnlocked: isActuallyUnlocked);
      },
    );
  }
}
