import 'package:flutter/material.dart';

/// ============================================================
/// STREAK PAGE - Aplikasi MindfulTech
///
/// Aset yang dibutuhkan:
/// - assets/images/streak/mindyStreak.png (Mindy memegang obor)
/// - assets/images/streak/torch_flame.png (untuk animasi api)
///
/// Struktur:
/// - Tab 1: Ringkasan Streak (progress hari)
/// - Tab 2: Daftar Pencapaian (Achievements)
/// ============================================================

// ============================================================
// DATA MODEL - Achievement Level
// ============================================================

class AchievementLevel {
  final String name;
  final String description;
  final int requiredDays;
  final Color torchColor;
  final IconData icon;
  final bool isUnlocked;

  const AchievementLevel({
    required this.name,
    required this.description,
    required this.requiredDays,
    required this.torchColor,
    required this.icon,
    required this.isUnlocked,
  });

  static List<AchievementLevel> getAchievements(int currentStreak) {
    return [
      AchievementLevel(
        name: 'Pemula',
        description: 'Mulai perjalananmu',
        requiredDays: 5,
        torchColor: const Color(0xFFFFC107), // Yellow
        icon: Icons.local_fire_department_rounded,
        isUnlocked: currentStreak >= 5,
      ),
      AchievementLevel(
        name: 'Konsisten',
        description: 'Terus berlatih ya!',
        requiredDays: 10,
        torchColor: const Color(0xFFFF9800), // Orange
        icon: Icons.local_fire_department_rounded,
        isUnlocked: currentStreak >= 10,
      ),
      AchievementLevel(
        name: 'Bersemangat',
        description: 'Semangatmu luar biasa!',
        requiredDays: 15,
        torchColor: const Color(0xFFFF5722), // Deep Orange
        icon: Icons.local_fire_department_rounded,
        isUnlocked: currentStreak >= 15,
      ),
      AchievementLevel(
        name: 'Fokus',
        description: 'Kamu sangat fokus!',
        requiredDays: 20,
        torchColor: const Color(0xFF9C27B0), // Purple
        icon: Icons.local_fire_department_rounded,
        isUnlocked: currentStreak >= 20,
      ),
      AchievementLevel(
        name: 'Master',
        description: 'Kamu sangat konsisten!',
        requiredDays: 25,
        torchColor: const Color(0xFF3F51B5), // Indigo
        icon: Icons.local_fire_department_rounded,
        isUnlocked: currentStreak >= 25,
      ),
      AchievementLevel(
        name: 'Legend',
        description: 'Legenda MindfulTech!',
        requiredDays: 30,
        torchColor: const Color(0xFF00BCD4), // Cyan
        icon: Icons.local_fire_department_rounded,
        isUnlocked: currentStreak >= 30,
      ),
    ];
  }
}

// ============================================================
// STREAK THEME - Warna dinamis berdasarkan level
// ============================================================

class StreakTheme {
  final int streakDays;
  final Color primaryColor;
  final Color secondaryColor;
  final Color flameColor;
  final List<Color> progressGradient;

  StreakTheme({required this.streakDays})
      : primaryColor = _getPrimaryColor(streakDays),
        secondaryColor = _getSecondaryColor(streakDays),
        flameColor = _getFlameColor(streakDays),
        progressGradient = _getProgressGradient(streakDays);

  static Color _getPrimaryColor(int days) {
    if (days >= 25) return const Color(0xFF00BCD4); // Cyan
    if (days >= 20) return const Color(0xFF3F51B5); // Indigo
    if (days >= 15) return const Color(0xFF9C27B0); // Purple
    if (days >= 10) return const Color(0xFFFF5722); // Deep Orange
    if (days >= 5) return const Color(0xFFFF9800); // Orange
    return const Color(0xFFFFC107); // Yellow
  }

  static Color _getSecondaryColor(int days) {
    if (days >= 25) return const Color(0xFF00E5FF);
    if (days >= 20) return const Color(0xFF7986CB);
    if (days >= 15) return const Color(0xFFBA68C8);
    if (days >= 10) return const Color(0xFFFF7043);
    if (days >= 5) return const Color(0xFFFFB74D);
    return const Color(0xFFFFD54F);
  }

  static Color _getFlameColor(int days) {
    if (days >= 25) return const Color(0xFF00E5FF);
    if (days >= 20) return const Color(0xFF5C6BC0);
    if (days >= 15) return const Color(0xFFE040FB);
    if (days >= 10) return const Color(0xFFFF5252);
    if (days >= 5) return const Color(0xFFFFAB40);
    return const Color(0xFFFFD740);
  }

  static List<Color> _getProgressGradient(int days) {
    if (days >= 25) return [const Color(0xFF00E5FF), const Color(0xFF00BCD4)];
    if (days >= 20) return [const Color(0xFF7986CB), const Color(0xFF3F51B5)];
    if (days >= 15) return [const Color(0xFFE040FB), const Color(0xFF9C27B0)];
    if (days >= 10) return [const Color(0xFFFF5252), const Color(0xFFFF5722)];
    if (days >= 5) return [const Color(0xFFFFAB40), const Color(0xFFFF9800)];
    return [const Color(0xFFFFD740), const Color(0xFFFFC107)];
  }

  String get streakLabel {
    if (streakDays >= 30) return '30+ Hari';
    return '$streakDays Hari';
  }

  double get progressPercent {
    if (streakDays >= 30) return 1.0;
    return streakDays / 30.0;
  }
}

// ============================================================
// MAIN PAGE
// ============================================================

class StreakPage extends StatefulWidget {
  const StreakPage({super.key});

  @override
  State<StreakPage> createState() => _StreakPageState();
}

class _StreakPageState extends State<StreakPage> with SingleTickerProviderStateMixin {
  // ============================================================
  // STATE MANAGEMENT
  // ============================================================

  // Ubah nilai ini untuk testing different streak levels
  // Coba: 5, 10, 15, 20, 25, 30
  int _currentStreak = 5;

  int _selectedTabIndex = 0; // 0 = Ringkasan, 1 = Pencapaian
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
            _buildAppBar(),

            // Tab Bar (Custom)
            _buildCustomTabBar(),

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
  // APP BAR
  // ============================================================

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: _theme.primaryColor,
                size: 18,
              ),
            ),
          ),

          const Spacer(),

          // Title
          Text(
            'Streak',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const Spacer(),

          // Calendar Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.calendar_today_rounded,
              color: _theme.primaryColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CUSTOM TAB BAR
  // ============================================================

  Widget _buildCustomTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Tab "Streak"
          Expanded(
            child: GestureDetector(
              onTap: () => _tabController.animateTo(0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTabIndex == 0
                      ? _theme.primaryColor.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Streak',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _selectedTabIndex == 0
                        ? _theme.primaryColor
                        : Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ),

          // Tab "Pencapaian"
          Expanded(
            child: GestureDetector(
              onTap: () => _tabController.animateTo(1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTabIndex == 1
                      ? _theme.primaryColor.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Pencapaian',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _selectedTabIndex == 1
                        ? _theme.primaryColor
                        : Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ),
        ],
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
          _buildMindySection(),

          const SizedBox(height: 24),

          // Streak Info
          _buildStreakInfo(),

          const SizedBox(height: 24),

          // Progress Bar
          _buildProgressBar(),

          const SizedBox(height: 32),

          // Action Button
          _buildActionButton(),

          const SizedBox(height: 16),

          // Debug Info (untuk testing)
          _buildDebugControls(),
        ],
      ),
    );
  }

  Widget _buildMindySection() {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative Stars
          Positioned(
            left: 20,
            top: 30,
            child: _buildDecorStar(12, _theme.primaryColor.withValues(alpha: 0.3)),
          ),
          Positioned(
            right: 30,
            top: 20,
            child: _buildDecorStar(8, _theme.secondaryColor.withValues(alpha: 0.4)),
          ),
          Positioned(
            left: 50,
            bottom: 40,
            child: _buildDecorStar(10, _theme.primaryColor.withValues(alpha: 0.25)),
          ),
          Positioned(
            right: 50,
            bottom: 30,
            child: _buildDecorStar(6, _theme.secondaryColor.withValues(alpha: 0.35)),
          ),

          // Mindy Asset
          Image.asset(
            'assets/images/streak/mindyStreak.png',
            height: 180,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 160,
                height: 180,
                decoration: BoxDecoration(
                  color: _theme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_rounded,
                      size: 60,
                      color: _theme.primaryColor,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mindy Streak',
                      style: TextStyle(
                        fontSize: 12,
                        color: _theme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDecorStar(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildStreakInfo() {
    return Column(
      children: [
        // Number of Days
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '$_currentStreak',
              style: TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                color: _theme.primaryColor,
                height: 1,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Hari',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: _theme.secondaryColor,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Subtitle
        Text(
          'Terus pertahankan streakmu!',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade500,
          ),
        ),

        const SizedBox(height: 8),

        // Percentage
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _theme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${(_theme.progressPercent * 100).toInt()}%',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _theme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        // Progress Label
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress ke level selanjutnya',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),
            Text(
              '$_currentStreak/30 Hari',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _theme.primaryColor,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Custom Progress Bar
        Container(
          height: 16,
          decoration: BoxDecoration(
            color: _theme.primaryColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              // Progress Fill
              AnimatedFractionallySizedBox(
                duration: const Duration(milliseconds: 500),
                widthFactor: _theme.progressPercent,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _theme.progressGradient,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: _theme.primaryColor.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Next level info
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_fire_department_rounded,
              size: 16,
              color: _theme.flameColor,
            ),
            const SizedBox(width: 4),
            Text(
              _getNextLevelInfo(),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getNextLevelInfo() {
    if (_currentStreak >= 30) return 'Level maksimal tercapai!';
    final nextDays = ((_currentStreak / 5 + 1) * 5).toInt();
    final daysLeft = nextDays - _currentStreak;
    return '$daysLeft hari lagi ke level selanjutnya';
  }

  Widget _buildActionButton() {
    return GestureDetector(
      onTap: () => _tabController.animateTo(1),
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _theme.progressGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _theme.primaryColor.withValues(alpha: 0.35),
              blurRadius: 12,
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDebugControls() {
    return Column(
      children: [
        Text(
          'Testing Controls',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w600,
          ),
        ),
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
                  color: isSelected
                      ? _theme.primaryColor
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$days Hari',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ============================================================
  // TAB 2: ACHIEVEMENTS LIST
  // ============================================================

  Widget _buildAchievementsList() {
    // Find the first unlocked achievement (or show last locked as example)
    final exampleUnlockedIndex = _achievements.indexWhere((a) => a.isUnlocked);
    final displayAchievements = exampleUnlockedIndex >= 0
        ? _achievements
        : _achievements;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      itemCount: displayAchievements.length,
      itemBuilder: (context, index) {
        final achievement = displayAchievements[index];
        final isUnlocked = achievement.isUnlocked;

        // Example: Make "Fokus" (level 4) always unlocked for demo
        final isActuallyUnlocked = index == 3 || isUnlocked;

        return _buildAchievementCard(
          achievement: achievement,
          isUnlocked: isActuallyUnlocked,
          index: index,
        );
      },
    );
  }

  Widget _buildAchievementCard({
    required AchievementLevel achievement,
    required bool isUnlocked,
    required int index,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Torch Icon Container
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isUnlocked
                  ? achievement.torchColor.withValues(alpha: 0.15)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.local_fire_department_rounded,
                  size: 28,
                  color: isUnlocked
                      ? achievement.torchColor
                      : Colors.grey.shade400,
                ),
                // Lock icon overlay if locked
                if (!isUnlocked)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_rounded,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isUnlocked ? Colors.black87 : Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  achievement.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: isUnlocked
                        ? Colors.grey.shade500
                        : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),

          // Days Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isUnlocked
                  ? achievement.torchColor.withValues(alpha: 0.15)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_fire_department_rounded,
                  size: 14,
                  color: isUnlocked
                      ? achievement.torchColor
                      : Colors.grey.shade400,
                ),
                const SizedBox(width: 4),
                Text(
                  '${achievement.requiredDays}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isUnlocked
                        ? achievement.torchColor
                        : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ANIMATED FRACTIONALLY SIZED BOX (Custom Widget)
// ============================================================

class AnimatedFractionallySizedBox extends StatelessWidget {
  final double widthFactor;
  final Duration duration;
  final Widget child;

  const AnimatedFractionallySizedBox({
    super.key,
    required this.widthFactor,
    required this.duration,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: widthFactor.clamp(0.0, 1.0)),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: value,
          child: child,
        );
      },
      child: child,
    );
  }
}