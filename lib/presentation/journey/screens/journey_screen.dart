import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/core/constants/colors.dart';

class JourneyMapScreen extends StatefulWidget {
  const JourneyMapScreen({super.key});

  @override
  State<JourneyMapScreen> createState() => _JourneyMapScreenState();
}

class _JourneyMapScreenState extends State<JourneyMapScreen> {
  int _currentNavIndex = 2;
  final int _currentLevel = 2;
  final int _totalDays = 10;
  final int _maxDays = 30;

  final List<Map<String, double>> _levelPositions = [
    {'x': 0.15, 'y': 0.85},
    {'x': 0.35, 'y': 0.70},
    {'x': 0.55, 'y': 0.55},
    {'x': 0.40, 'y': 0.40},
    {'x': 0.60, 'y': 0.25},
    {'x': 0.80, 'y': 0.12},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildMapArea()),
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        children: [
          Row(
            children: [
              _buildBackButton(),
              const Spacer(),
              Text(
                'Journey Map',
                style: GoogleFonts.merriweather(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              const SizedBox(width: 66),
            ],
          ),
          const SizedBox(height: 8),
          _buildProgressCard(),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _buildMindyWithBubble(),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                Image.asset('assets/images/journey/bendera.png', width: 22, height: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progress Perjalananmu',
                        style: GoogleFonts.merriweather(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            '$_totalDays',
                            style: GoogleFonts.merriweather(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                            ),
                          ),
                          Text(
                            ' / $_maxDays hari',
                            style: GoogleFonts.merriweather(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.grey.shade200,
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB74D).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset('assets/images/journey/hadiah.png', width: 22, height: 22),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hadiah Spesial',
                        style: GoogleFonts.merriweather(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Menantimu',
                        style: GoogleFonts.merriweather(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
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

  Widget _buildMindyWithBubble() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              "Terus\nfokus, ya!",
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.3,
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Image.asset('assets/images/journey/awan.png', width: 50, height: 40, fit: BoxFit.contain),
      ],
    );
  }

  Widget _buildMapArea() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset('assets/images/journey/denah.png', fit: BoxFit.cover),
              ),
              ..._buildLevelNodes(context, constraints),
              _buildCurrentLevelMascot(constraints),
              _buildTreasureChestCard(constraints),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildLevelNodes(BuildContext context, BoxConstraints constraints) {
    final nodes = <Widget>[];
    for (int i = 0; i < _levelPositions.length; i++) {
      final pos = _levelPositions[i];
      final level = i + 1;
      final isCompleted = level < _currentLevel;
      final isCurrent = level == _currentLevel;
      final isUnlocked = level <= _currentLevel;

      nodes.add(
        Positioned(
          left: pos['x']! * constraints.maxWidth - 20,
          top: pos['y']! * constraints.maxHeight - 44,
          child: GestureDetector(
            onTap: () => _onLevelTapped(context, level),
            child: _buildLevelNode(
              level: level,
              isCompleted: isCompleted,
              isCurrent: isCurrent,
              isUnlocked: isUnlocked,
            ),
          ),
        ),
      );
    }
    return nodes;
  }

  void _onLevelTapped(BuildContext context, int level) {
    if (level <= _currentLevel) {
      Navigator.pushNamed(context, AppRoutes.chooseEnergy);
    }
  }

  Widget _buildLevelNode({
    required int level,
    required bool isCompleted,
    required bool isCurrent,
    required bool isUnlocked,
  }) {
    Color bgColor;
    Color borderColor;
    Color textColor;

    if (isCompleted) {
      bgColor = const Color(0xFF4CAF50);
      borderColor = Colors.white;
      textColor = Colors.white;
    } else if (isCurrent) {
      bgColor = Colors.transparent;
      borderColor = Colors.transparent;
      textColor = Colors.transparent;
    } else {
      bgColor = Colors.grey.shade400;
      borderColor = Colors.grey.shade400;
      textColor = Colors.white;
    }

    if (isCurrent) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor,
            border: Border.all(color: borderColor, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$level',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
        CustomPaint(
          size: const Size(14, 8),
          painter: _TrianglePainter(color: borderColor),
        ),
      ],
    );
  }

  Widget _buildCurrentLevelMascot(BoxConstraints constraints) {
    if (_currentLevel < 1 || _currentLevel > _levelPositions.length) {
      return const SizedBox();
    }
    final pos = _levelPositions[_currentLevel - 1];

    return Positioned(
      left: pos['x']! * constraints.maxWidth - 25,
      top: pos['y']! * constraints.maxHeight - 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/journey/awan1.png', width: 50, height: 36, fit: BoxFit.contain),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Text(
              "Jangan berhenti di sini, ya.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreasureChestCard(BoxConstraints constraints) {
    final isTreasureUnlocked = _currentLevel >= 6;

    return Positioned(
      left: 10,
      top: constraints.maxHeight * 0.45,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hadiah Spesial',
                  style: GoogleFonts.merriweather(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Image.asset('assets/images/journey/hartaKarun.png', width: 44, height: 36, fit: BoxFit.contain),
                const SizedBox(height: 4),
                Text(
                  isTreasureUnlocked
                      ? 'Selamat!\nKlaim hadiahmu!'
                      : 'Mulai Fokus Hari\nIni, Raih Hadiah\ndi Level 6!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          if (!isTreasureUnlocked)
            Positioned(
              top: -8,
              right: -8,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.lock, size: 14, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
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
                context: context,
                icon: Icons.home_rounded,
                label: 'Beranda',
                isActive: _currentNavIndex == 0,
                onTap: () {
                  setState(() => _currentNavIndex = 0);
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homepage, (route) => false);
                },
              ),
              _buildNavItem(
                context: context,
                icon: Icons.timer_outlined,
                label: 'Fokus',
                isActive: _currentNavIndex == 1,
                onTap: () {
                  setState(() => _currentNavIndex = 1);
                  Navigator.pushNamed(context, AppRoutes.timer);
                },
              ),
              _buildNavItem(
                context: context,
                icon: Icons.map_outlined,
                label: 'Journey',
                isActive: true,
                onTap: () {},
              ),
              _buildNavItem(
                context: context,
                icon: Icons.local_fire_department_outlined,
                label: 'Streak',
                isActive: _currentNavIndex == 3,
                onTap: () => setState(() => _currentNavIndex = 3),
              ),
              _buildNavItem(
                context: context,
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
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
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
