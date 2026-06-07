import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey_cubit.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey_state.dart';
import '../data/journey_data.dart';

class JourneyPage extends StatefulWidget {
  const JourneyPage({super.key});

  @override
  State<JourneyPage> createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage> {
  int _currentNavIndex = 2;

  // Koordinat presisi berdasarkan gambar "Journey Map 2.png" dari bawah ke atas
  final List<Map<String, double>> _levelPositions = [
    {'x': 0.31, 'y': 0.79}, // Level 1 (Dekat rumah biru bawah)
    {'x': 0.56, 'y': 0.65}, // Level 2 (Setelah jembatan cokelat)
    {'x': 0.68, 'y': 0.56}, // Level 3 (Tikungan tengah bukit hijau)
    {'x': 0.70, 'y': 0.49}, // Level 4 (Awal jalan kelabu menanjak)
    {'x': 0.74, 'y': 0.43}, // Level 5 (Tengah tanjakan kelabu)
    {'x': 0.82, 'y': 0.39}, // Level 6 (Dekat gerbang kastil atas)
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JourneyCubit, JourneyState>(
      builder: (context, state) {
        final cubit = context.read<JourneyCubit>();
        final currentCycle = cubit.currentCycle; // Level aktif saat ini (1-6)

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(state, cubit),
                Expanded(child: _buildMapArea(state, currentCycle)),
                _buildBottomNavBar(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(JourneyState state, JourneyCubit cubit) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        children: [
          Row(
            children: [
              _buildBackButton(),
              const Spacer(),
              Text(
                'Journey Map',
                style: GoogleFonts.merriweather(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF5CA3E6), // Warna biru soft sesuai gambar
                ),
              ),
              const Spacer(),
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: 10),
          _buildProgressCard(state),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF5CA3E6),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }

  Widget _buildProgressCard(JourneyState state) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Kartu Utama
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
              // Kolom Kiri: Progress Perjalanan
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
                              '${state.totalDays}',
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
              // Garis Pembatas Tengah
              Container(
                width: 1,
                height: 45,
                color: Colors.grey.shade300,
                margin: const EdgeInsets.symmetric(horizontal: 12),
              ),
              // Kolom Kanan: Hadiah Spesial
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
        // Maskot Mindy & Balon Teks di Atas Kartu (Presisi Kanan Atas)
        Positioned(
          top: -24,
          right: 20,
          child: _buildMindyHeaderBubble(context.read<JourneyCubit>().getMotivationalMessage()),
        ),
      ],
    );
  }

  Widget _buildMindyHeaderBubble(String message) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      children: [
        // Balon Percakapan Biru Mini
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
            // Ekor balon percakapan kecil
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
        // Awan Mindy Lucu
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

  Widget _buildMapArea(JourneyState state, int currentCycle) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Stack(
            children: [
              // Gambar Latar Denah Peta Petualangan
              Positioned.fill(
                child: Image.asset(
                  'assets/images/journey/denah.png', 
                  fit: BoxFit.cover,
                ),
              ),
              // Render Semua Node Pin (1 sampai 6)
              ..._buildLevelNodes(constraints, currentCycle),
              // Render Maskot Bergerak & Balon Teks Statis di Atas Map
              _buildCurrentLevelMascot(constraints, currentCycle),
              // Render Kotak Peti Harta Karun Samping
              _buildTreasureChestCard(constraints, currentCycle),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildLevelNodes(BoxConstraints constraints, int currentCycle) {
    final nodes = <Widget>[];
    for (int i = 0; i < _levelPositions.length; i++) {
      final pos = _levelPositions[i];
      final level = i + 1;
      
      final isCompleted = level < currentCycle;
      final isCurrent = level == currentCycle;

      nodes.add(
        Positioned(
          left: pos['x']! * constraints.maxWidth - 18,
          top: pos['y']! * constraints.maxHeight - 40,
          child: GestureDetector(
            onTap: () {
              if (level <= currentCycle) {
                Navigator.pushNamed(context, AppRoutes.chooseEnergy);
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
    // Menyesuaikan warna pin dengan gambar "Journey Map 2.png"
    Color pinColor = const Color(0xFF9E9E9E); // Abu-abu default (terkunci)
    if (isCompleted) {
      pinColor = const Color(0xFF4CAF50); // Hijau sukses
    } else if (isCurrent) {
      pinColor = const Color(0xFF81C784); // Hijau muda pin aktif saat ini
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
                color: Colors.black.withValues(alpha: 0.15),
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
        // Kaki segitiga pin penunjuk peta
        CustomPaint(
          size: const Size(10, 6),
          painter: _TrianglePainter(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildCurrentLevelMascot(BoxConstraints constraints, int currentCycle) {
    if (currentCycle < 1 || currentCycle > _levelPositions.length) return const SizedBox.shrink();
    
    final pinPos = _levelPositions[currentCycle - 1];

    // Mengatur posisi relatif Maskot Awan agar berdiri tepat di sisi kiri Pin Aktif
    return Positioned(
      left: (pinPos['x']! * constraints.maxWidth) - 65,
      top: (pinPos['y']! * constraints.maxHeight) - 15,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Maskot Awan Kecil Berjalan
          Image.asset(
            'assets/images/journey/awan1.png', 
            width: 42, 
            height: 32, 
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Text('☁️'),
          ),
          const SizedBox(width: 4),
          // Balon Dialog Putih Berisi Ajakan
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
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

  Widget _buildTreasureChestCard(BoxConstraints constraints, int currentCycle) {
    final isTreasureUnlocked = currentCycle >= 6;

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
                  color: Colors.black.withValues(alpha: 0.1),
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
                    color: const Color(0xFFC67D3D), // Warna teks cokelat jingga hangat
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
                    color: const Color(0xFF2B69A9), // Warna biru info teks bawah
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          // Indikator Gembok Lingkaran di Atas Kartu Hadiah
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

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_rounded, 'Beranda', _currentNavIndex == 0, () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homepage, (route) => false);
            }),
            _buildNavItem(Icons.timer_outlined, 'Fokus', _currentNavIndex == 1, () {
              Navigator.pushNamed(context, AppRoutes.timer);
            }),
            _buildNavItem(Icons.map_rounded, 'Journey', true, () {}),
            _buildNavItem(Icons.local_fire_department_outlined, 'Streak', _currentNavIndex == 3, () {}),
            _buildNavItem(Icons.person_outline, 'Profil', _currentNavIndex == 4, () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? const Color(0xFF5CA3E6) : Colors.grey.shade400,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              color: isActive ? const Color(0xFF5CA3E6) : Colors.grey.shade500,
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