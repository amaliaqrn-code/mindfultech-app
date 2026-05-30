import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../../homepage/homepage_screen.dart';

class JourneyMapScreen extends StatefulWidget {
  const JourneyMapScreen({super.key});

  @override
  State<JourneyMapScreen> createState() => _JourneyMapScreenState();
}

class _JourneyMapScreenState extends State<JourneyMapScreen> {
  // ================= DYNAMIC VARIABLES =================
  // Current level (set to 2 as example, can be adjusted dynamically)
  int currentLevel = 2;

  // Total progress days
  int totalDays = 10;

  // Maximum days in journey
  final int maxDays = 30;

  // ================= LEVEL POSITIONS ARRAY =================
  // Coordinates for 6 level nodes (x, y in percentage of map size)
  // Adjust these coordinates to match your map path
  final List<Map<String, double>> levelPositions = [
    {'x': 0.15, 'y': 0.85},  // Level 1 - Start (bottom left)
    {'x': 0.35, 'y': 0.70},  // Level 2 - First milestone
    {'x': 0.55, 'y': 0.55},  // Level 3 - Middle path
    {'x': 0.40, 'y': 0.40},  // Level 4 - Upper path
    {'x': 0.60, 'y': 0.25},  // Level 5 - Near top
    {'x': 0.80, 'y': 0.12},  // Level 6 - Top destination
  ];

  // ================= MOTIVATIONAL MESSAGES =================
  final List<String> motivationMessages = [
    "Tetap fokus, ya!",
    "Kamu hebat!",
    "Semangat terus!",
    "Hampir sampai!",
    "Keren sekali!",
    "Sampai tujuan! 🎉",
  ];

  String get currentMessage => motivationMessages[currentLevel - 1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ================= TOP HEADER SECTION =================
            _buildHeader(),

            // ================= MAP AREA (STACK LAYOUT) =================
            Expanded(
              child: _buildMapArea(),
            ),

            // ================= BOTTOM NAVIGATION BAR =================
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  // ================= HEADER SECTION =================
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // Row: Back Button, Title, Mindy
          Row(
            children: [
              // Back Button
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Title
              const Expanded(
                child: Text(
                  'Journey Map',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),

              // Mindy with Speech Bubble
              _buildMindyWithBubble(),
            ],
          ),

          const SizedBox(height: 16),

          // ================= PROGRESS CARD (OVERLAPPING) =================
          _buildProgressCard(),
        ],
      ),
    );
  }

  // ================= MINDY MASCOT WITH SPEECH BUBBLE =================
  Widget _buildMindyWithBubble() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Speech Bubble
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            currentMessage,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(width: 6),

        // Mindy Cloud Image
        Image.asset(
          'assets/images/journey/awan.png',
          width: 70,
          height: 56,
          fit: BoxFit.contain,
        ),
      ],
    );
  }

  // ================= PROGRESS CARD =================
  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left: Progress Info
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/journey/bendera.png',
                    width: 24,
                    height: 24,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Progress Perjalananmu',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '$totalDays',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          TextSpan(
                            text: ' / $maxDays hari',
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
              ],
            ),
          ),

          // Divider
          Container(
            width: 1,
            height: 44,
            color: Colors.grey.shade200,
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),

          // Right: Reward Info
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB74D).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/journey/hadiah.png',
                    width: 24,
                    height: 24,
                    color: const Color(0xFFFF9800),
                  ),
                ),

                const SizedBox(width: 10),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hadiah Spesial',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFE65100),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Menantimu',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= MAP AREA (STACK LAYOUT) =================
  Widget _buildMapArea() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  // ================= BACKGROUND MAP =================
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/journey/denah.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  // ================= LEVEL NODES =================
                  ..._buildLevelNodes(constraints),

                  // ================= CURRENT LEVEL MASCOT =================
                  _buildCurrentLevelMascot(constraints),

                  // ================= FLOATING SPEECH BUBBLE =================
                  _buildFloatingSpeechBubble(constraints),

                  // ================= TREASURE CHEST CARD =================
                  _buildTreasureChestCard(constraints),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ================= LEVEL NODES =================
  List<Widget> _buildLevelNodes(BoxConstraints constraints) {
    final nodes = <Widget>[];

    for (int i = 0; i < levelPositions.length; i++) {
      final pos = levelPositions[i];
      final level = i + 1;
      final isCompleted = level < currentLevel;
      final isCurrent = level == currentLevel;
      final isUnlocked = level <= currentLevel;

      nodes.add(
        Positioned(
          left: pos['x']! * constraints.maxWidth - 22,
          top: pos['y']! * constraints.maxHeight - 48,
          child: _buildLevelNode(
            level: level,
            isCompleted: isCompleted,
            isCurrent: isCurrent,
            isUnlocked: isUnlocked,
          ),
        ),
      );
    }

    return nodes;
  }

  // ================= INDIVIDUAL LEVEL NODE =================
  Widget _buildLevelNode({
    required int level,
    required bool isCompleted,
    required bool isCurrent,
    required bool isUnlocked,
  }) {
    Color bgColor;
    Color borderColor;
    Color textColor;

    if (isCurrent) {
      // Current level - Primary blue
      bgColor = AppColors.primary;
      borderColor = Colors.white;
      textColor = Colors.white;
    } else if (isCompleted) {
      // Completed level - Green
      bgColor = const Color(0xFF4CAF50);
      borderColor = Colors.white;
      textColor = Colors.white;
    } else if (isUnlocked) {
      // Unlocked but not current - Light blue
      bgColor = const Color(0xFF81D4FA);
      borderColor = Colors.white;
      textColor = Colors.white;
    } else {
      // Locked level - Gray
      bgColor = Colors.grey.shade400;
      borderColor = Colors.grey.shade300;
      textColor = Colors.white;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Node Circle with Number
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor,
            border: Border.all(color: borderColor, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: isUnlocked
                ? Text(
                    '$level',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  )
                : Icon(
                    Icons.lock,
                    size: 18,
                    color: textColor,
                  ),
          ),
        ),

        // Pointer Triangle
        CustomPaint(
          size: const Size(16, 10),
          painter: _TrianglePainter(color: borderColor),
        ),
      ],
    );
  }

  // ================= CURRENT LEVEL MASCOT =================
  Widget _buildCurrentLevelMascot(BoxConstraints constraints) {
    if (currentLevel < 1 || currentLevel > levelPositions.length) {
      return const SizedBox();
    }

    final pos = levelPositions[currentLevel - 1];

    return Positioned(
      left: pos['x']! * constraints.maxWidth - 30,
      top: pos['y']! * constraints.maxHeight - 110,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Speech bubble above mascot
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Text(
              "Jangan berhenti\ndi sini, ya.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),

          const SizedBox(height: 4),

          // Mindy mascot image
          Image.asset(
            'assets/images/journey/awan1.png',
            width: 56,
            height: 40,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  // ================= FLOATING SPEECH BUBBLE =================
  Widget _buildFloatingSpeechBubble(BoxConstraints constraints) {
    return Positioned(
      left: constraints.maxWidth * 0.25,
      top: constraints.maxHeight * 0.75,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          "Mulai dari langkah\nkecil, ya",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  // ================= TREASURE CHEST CARD =================
  Widget _buildTreasureChestCard(BoxConstraints constraints) {
    // Check if current level has reached treasure threshold
    final isTreasureUnlocked = currentLevel >= 6;

    return Positioned(
      right: 12,
      top: constraints.maxHeight * 0.35,
      child: Container(
        width: 110,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lock icon (top right)
            if (!isTreasureUnlocked)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock,
                    size: 12,
                    color: Colors.grey,
                  ),
                ),
              ),

            // Title
            const Text(
              'Hadiah Spesial',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE53935),
              ),
            ),

            const SizedBox(height: 8),

            // Treasure chest image
            Image.asset(
              'assets/images/journey/hartaKarun.png',
              width: 50,
              height: 42,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 6),

            // Description text
            Text(
              isTreasureUnlocked
                  ? 'Selamat!\nKlaim hadiahmu!'
                  : 'Mulai Fokus Hari\nIni, Raih Hadiah\ndi Level 6!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
                height: 1.3,
              ),
            ),
          ],
        ),
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: 'Beranda',
                isActive: false,
                onTap: () {
                  Get.off(() => const HomepageScreen());
                },
              ),
              _buildNavItem(
                icon: Icons.timer_outlined,
                label: 'Fokus',
                isActive: false,
                onTap: () {},
              ),
              _buildNavItem(
                icon: Icons.map_outlined,
                label: 'Journey',
                isActive: true,
                onTap: () {},
              ),
              _buildNavItem(
                icon: Icons.local_fire_department_outlined,
                label: 'Streak',
                isActive: false,
                onTap: () {},
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                label: 'Profil',
                isActive: false,
                onTap: () {},
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

// ================= CUSTOM PAINTER FOR TRIANGLE =================
class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}