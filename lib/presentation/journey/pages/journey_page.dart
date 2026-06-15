import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_cubit.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_state.dart';

class JourneyPage extends StatefulWidget {
  const JourneyPage({super.key});

  @override
  State<JourneyPage> createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage> {
  int animatedLevel = 1;
  // Koordinat presisi meliuk dari bawah (level 1) menuju atas (level 6) sesuai alur denah asli
  final List<Map<String, double>> _levelPositions = [
    {'x': 0.31, 'y': 0.79}, // Level 1 (Dekat rumah mulai awal)
    {'x': 0.50, 'y': 0.68}, // Level 2 (Area Grassland / Setelah Jembatan)
    {'x': 0.65, 'y': 0.58}, // Level 3 (Tikungan bawah Sunny Hill)
    {'x': 0.48, 'y': 0.46}, // Level 4 (Area Calm Lake / Tengah)
    {'x': 0.62, 'y': 0.34}, // Level 5 (Menanjak Focus Mountain)
    {'x': 0.78, 'y': 0.22}, // Level 6 (Puncak Kastil Ketenangan)
  ];

  void _animateMindyToNode(int level) {
    setState(() {
      animatedLevel = level;
    });
  }

  @override
Widget build(BuildContext context) {
  return BlocListener<JourneyCubit, JourneyState>(
    listenWhen: (prev, curr) => prev.currentLevel != curr.currentLevel,
    listener: (context, state) {
    _animateMindyToNode(state.currentLevel.level);
    },
    child: BlocBuilder<JourneyCubit, JourneyState>(
      buildWhen: (previous, current) {
        return previous.currentLevel.level != current.currentLevel.level ||
               previous.totalDays != current.totalDays ||
               previous.isLoading != current.isLoading;
      },
      builder: (context, state) {
        final currentLevel = state.currentLevel.level.clamp(1, 6);
        final cubit = context.read<JourneyCubit>();

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(state, cubit),
                Expanded(child: _buildMapArea(state, currentLevel)),
              ],
            ),
          ),
        );
      },
    ),
  );
}

  Widget _buildHeader(JourneyState state, JourneyCubit cubit) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Text(
                'Journey Map',
                style: GoogleFonts.merriweather(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF5CA3E6),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 10),
          _buildProgressCard(state, cubit),
        ],
      ),
    );
  }

  Widget _buildProgressCard(JourneyState state, JourneyCubit cubit) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25),
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFF5CA3E6),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.flag_rounded, color: Colors.black, size: 28),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Progress\nPerjalananmu',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text(
                              '${state.totalDays}', // Menggunakan totalDays langsung dari state
                              style: GoogleFonts.inter(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF5CA3E6),
                              ),
                            ),
                            Text(
                              ' / ${JourneyData.maxDays} hari',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 45,
                color: Colors.grey.shade300,
                margin: const EdgeInsets.symmetric(horizontal: 12),
              ),
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.card_giftcard_rounded, color: Colors.black, size: 26),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hadiah Spesial\nMenantimu',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              height: 1.2,
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
        ),
        Positioned(
          top: -24,
          right: 20,
          // ✅ FIX TYPO: Mengubah nama method menjadi getMotivationalMessage sesuai di Cubit
          child: _buildMindyHeaderBubble(cubit.getMotivationalMessage()),
        ),
      ],
    );
  }

  Widget _buildMindyHeaderBubble(String message) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF5CA3E6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message,
                style: GoogleFonts.inter(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 12,
              child: CustomPaint(
                size: const Size(8, 6),
                painter: _TrianglePainter(color: const Color(0xFF5CA3E6), invert: true),
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
        Image.asset(
          'assets/images/journey/awan.png',
          width: 65,
          height: 55,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Text('☁️', style: TextStyle(fontSize: 32)),
        ),
      ],
    );
  }

  Widget _buildMapArea(JourneyState state, int currentLevel) {
    final double saturationProgress = (state.totalDays / JourneyData.maxDays).clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Stack(
            children: [
              Positioned.fill(
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: saturationProgress),
                  duration: const Duration(milliseconds: 1000),
                  builder: (context, saturation, child) {
                    final double invSat = 1 - saturation;
                    final double r = 0.2126 * invSat;
                    final double g = 0.7152 * invSat;
                    final double b = 0.0722 * invSat;

                    return ColorFiltered(
                      colorFilter: ColorFilter.matrix([
                        r + saturation, g, b, 0, 0,
                        r, g + saturation, b, 0, 0,
                        r, g, b + saturation, 0, 0,
                        0, 0, 0, 1, 0,
                      ]),
                      child: Image.asset(
                        'assets/images/journey/journey_map.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFE8F4FD),
                            child: const Center(
                              child: Text('Journey Map', style: TextStyle(fontSize: 24)),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              ..._buildLevelNodes(constraints, currentLevel, state),
              _buildAnimatedMascot(constraints, animatedLevel),
              _buildTreasureChestCard(constraints, currentLevel),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildLevelNodes(BoxConstraints constraints, int currentLevel, JourneyState state) {
    final nodes = <Widget>[];
    for (int i = 0; i < _levelPositions.length; i++) {
      final pos = _levelPositions[i];
      final level = i + 1;

      // ✅ LOGIC FIX: Menggunakan rumus kelipatan 5 hari untuk kelulusan level.
      // Level 1 lulus jika hari >= 5, Level 2 lulus jika hari >= 10, dst.
      final isCompleted = state.totalDays >= (level * 5);
      final isCurrent = level == currentLevel;

      nodes.add(
        Positioned(
          left: pos['x']! * constraints.maxWidth - 18,
          top: pos['y']! * constraints.maxHeight - 40,
          child: GestureDetector(
            onTap: () {
              if (level <= currentLevel) {
                Navigator.pushNamed(context, AppRoutes.chooseEnergy);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Selesaikan level sebelumnya terlebih dahulu!'),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
            child: _buildMapPin(
              level: level,
              isCompleted: isCompleted,
              isCurrent: isCurrent,
            ),
          ),
        ),
      );
    }
    return nodes;
  }

  Widget _buildMapPin({required int level, required bool isCompleted, required bool isCurrent}) {
    Color pinColor = const Color(0xFF9E9E9E); 
    if (isCompleted) {
      pinColor = const Color(0xFF4CAF50); // Hijau jika level sudah tuntas (lewat 5 hari)
    } else if (isCurrent) {
      pinColor = const Color(0xFF81C784); // Hijau muda jika level ini sedang aktif dimainkan
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: pinColor,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$level',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        CustomPaint(
          size: const Size(10, 6),
          painter: _TrianglePainter(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildAnimatedMascot(BoxConstraints constraints, int animatedLevel) {
    int activeIndex = animatedLevel.clamp(1, 6);
    final pinPos = _levelPositions[activeIndex - 1];

    final double targetLeft = (pinPos['x']! * constraints.maxWidth) - 65;
    final double targetTop = (pinPos['y']! * constraints.maxHeight) - 15;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      left: targetLeft,
      top: targetTop,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/journey/awan1.png',
            width: 42,
            height: 32,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Text('☁️', style: TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              "Jangan berhenti\ndisini, ya.",
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreasureChestCard(BoxConstraints constraints, int currentLevel) {
    final isTreasureUnlocked = currentLevel >= 6 && JourneyData.maxDays >= 30;

    return Positioned(
      left: 16,
      top: constraints.maxHeight * 0.48,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 110,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hadiah Spesial',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFC67D3D),
                  ),
                ),
                const SizedBox(height: 6),
                Image.asset(
                  'assets/images/journey/hartaKarun.png',
                  width: 48,
                  height: 40,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.inventory_2, color: Colors.amber, size: 36),
                ),
                const SizedBox(height: 6),
                Text(
                  isTreasureUnlocked
                      ? 'Selamat!\nKlaim hadiahmu!'
                      : 'Mulai Fokus Hari\nIni, Raih Hadiah\ndi Hari ke-30!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2B69A9),
                    height: 1.3,
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
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: const Icon(Icons.lock_outline_rounded, size: 14, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  final bool invert;
  _TrianglePainter({required this.color, this.invert = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();

    if (invert) {
      path.moveTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Navigation handled by MainPage

