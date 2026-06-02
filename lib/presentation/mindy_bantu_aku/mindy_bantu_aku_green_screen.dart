import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';

/// ============================================================
/// Mindy Bantu Aku - Dynamic Energy Theme Screen
/// ============================================================
/// Layar pemilihan kategori dengan tema dinamis berdasarkan
/// tingkat energi pengguna:
///   - Hijau  (#6A9859) → Energi Rendah
///   - Biru   (#4597E6) → Energi Sedang
///   - Ungu   (#8871C6) → Energi Tinggi
///
/// Layout vertikal (atas ke bawah):
///   1. Judul Utama (Title)
///   2. Subjudul (Subtitle)
///   3. Gambar Maskot Awan (Image)
///   4. Grid Kategori (2x3)
///   5. Tombol Lanjut (Primary Button)
///   6. Bottom Navigation Bar
/// ============================================================

// ─────────────────────────────────────────────────────────────
// ENERGY THEME DATA MODEL
// ─────────────────────────────────────────────────────────────

/// Konfigurasi warna untuk setiap level energi
class EnergyThemeData {
  final Color primary;
  final Color primaryDark;
  final Color primaryLight;
  final Color cardBg;
  final Color subtitleColor;
  final Color navActiveColor;
  final LinearGradient buttonGradient;
  final List<Color> decorationColors;
  final IconData decorationIcon;

  const EnergyThemeData({
    required this.primary,
    required this.primaryDark,
    required this.primaryLight,
    required this.cardBg,
    required this.subtitleColor,
    required this.navActiveColor,
    required this.buttonGradient,
    required this.decorationColors,
    required this.decorationIcon,
  });

  /// Hijau - Energi Rendah
  static final green = EnergyThemeData(
    primary: const Color(0xFF6A9859),
    primaryDark: const Color(0xFF4A7A3D),
    primaryLight: const Color(0xFFA8C99B),
    cardBg: const Color(0xFFF0F5EC),
    subtitleColor: const Color(0xFF8FA88B),
    navActiveColor: const Color(0xFF6A9859),
    buttonGradient: const LinearGradient(
      colors: [Color(0xFF6A9859), Color(0xFF4A7A3D)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    decorationColors: const [Color(0xFF6A9859), Color(0xFFA8C99B)],
    decorationIcon: Icons.eco_rounded,
  );

  /// Biru - Energi Sedang
  static final blue = EnergyThemeData(
    primary: const Color(0xFF4597E6),
    primaryDark: const Color(0xFF2D6DB5),
    primaryLight: const Color(0xFF83C3FF),
    cardBg: const Color(0xFFEBF3FD),
    subtitleColor: const Color(0xFF7AADDA),
    navActiveColor: const Color(0xFF4597E6),
    buttonGradient: const LinearGradient(
      colors: [Color(0xFF4597E6), Color(0xFF83DFC6)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    decorationColors: const [Color(0xFF4597E6), Color(0xFF83C3FF)],
    decorationIcon: Icons.auto_awesome_rounded,
  );

  /// Ungu - Energi Tinggi
  static final purple = EnergyThemeData(
    primary: const Color(0xFF8871C6),
    primaryDark: const Color(0xFF6B54A8),
    primaryLight: const Color(0xFFB8A4E0),
    cardBg: const Color(0xFFF0ECF7),
    subtitleColor: const Color(0xFFA896C9),
    navActiveColor: const Color(0xFF8871C6),
    buttonGradient: const LinearGradient(
      colors: [Color(0xFF8871C6), Color(0xFF6B54A8)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    decorationColors: const [Color(0xFF8871C6), Color(0xFFB8A4E0)],
    decorationIcon: Icons.bolt_rounded,
  );
}

// ─────────────────────────────────────────────────────────────
// CATEGORY DATA MODEL
// ─────────────────────────────────────────────────────────────

class _CategoryItem {
  final String name;
  final IconData icon;

  const _CategoryItem({required this.name, required this.icon});
}

const List<_CategoryItem> _categories = [
  _CategoryItem(name: 'Belajar', icon: Icons.menu_book_rounded),
  _CategoryItem(name: 'Pekerjaan', icon: Icons.work_rounded),
  _CategoryItem(name: 'Kesehatan', icon: Icons.favorite_rounded),
  _CategoryItem(name: 'Pribadi', icon: Icons.person_rounded),
  _CategoryItem(name: 'Rumah', icon: Icons.home_rounded),
  _CategoryItem(name: 'Lainnya', icon: Icons.auto_awesome_rounded),
];

// ─────────────────────────────────────────────────────────────
// BOTTOM NAV DATA
// ─────────────────────────────────────────────────────────────

class _NavItem {
  final String label;
  final IconData icon;
  final bool isActive;

  const _NavItem({
    required this.label,
    required this.icon,
    this.isActive = false,
  });
}

const List<_NavItem> _navItems = [
  _NavItem(label: 'Beranda', icon: Icons.home_rounded),
  _NavItem(label: 'Fokus', icon: Icons.pie_chart_rounded),
  _NavItem(label: 'Journey', icon: Icons.map_rounded, isActive: true),
  _NavItem(label: 'Streak', icon: Icons.local_fire_department_rounded),
  _NavItem(label: 'Profil', icon: Icons.person_rounded),
];

// ─────────────────────────────────────────────────────────────
// MAIN SCREEN WIDGET
// ─────────────────────────────────────────────────────────────

class MindyBantuAkuGreenScreen extends StatefulWidget {
  /// Level energi awal: 0 = rendah (hijau), 1 = sedang (biru), 2 = tinggi (ungu)
  final int initialEnergyLevel;

  const MindyBantuAkuGreenScreen({
    super.key,
    this.initialEnergyLevel = 0,
  });

  @override
  State<MindyBantuAkuGreenScreen> createState() =>
      _MindyBantuAkuGreenScreenState();
}

class _MindyBantuAkuGreenScreenState extends State<MindyBantuAkuGreenScreen>
    with TickerProviderStateMixin {
  /// 0 = hijau (rendah), 1 = biru (sedang), 2 = ungu (tinggi)
  late int _energyLevel;

  /// Index kategori terpilih. Default 1 = 'Pekerjaan' untuk tes.
  int _selectedCategoryIndex = 1;

  /// Controller untuk animasi transisi tema
  late AnimationController _themeAnimController;
  late Animation<double> _themeAnimation;

  /// Controller untuk animasi floating maskot
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  EnergyThemeData get _currentTheme {
    switch (_energyLevel) {
      case 1:
        return EnergyThemeData.blue;
      case 2:
        return EnergyThemeData.purple;
      default:
        return EnergyThemeData.green;
    }
  }

  @override
  void initState() {
    super.initState();
    _energyLevel = widget.initialEnergyLevel.clamp(0, 2);

    // Theme transition animation
    _themeAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _themeAnimation = CurvedAnimation(
      parent: _themeAnimController,
      curve: Curves.easeInOut,
    );
    _themeAnimController.value = 1.0;

    // Floating mascot animation
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: -4, end: 4).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _themeAnimController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  /// Ganti tema energi secara dinamis
  void _switchEnergy(int level) {
    if (level == _energyLevel) return;
    _themeAnimController.forward(from: 0).then((_) {
      setState(() {
        _energyLevel = level.clamp(0, 2);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = _currentTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Scrollable Content ──
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    // ── Energy Switcher (untuk demo / tes) ──
                    _buildEnergySwitcher(theme),

                    const SizedBox(height: 20),

                    // 1. JUDUL UTAMA
                    _buildTitle(theme),

                    const SizedBox(height: 8),

                    // 2. SUBJUDUL
                    _buildSubtitle(theme),

                    const SizedBox(height: 24),

                    // 3. GAMBAR MASKOT AWAN
                    _buildMascotSection(theme, screenWidth),

                    const SizedBox(height: 28),

                    // 4. GRID KATEGORI (2x3)
                    _buildCategoryGrid(theme),

                    const SizedBox(height: 28),

                    // 5. TOMBOL LANJUT
                    _buildLanjutButton(theme),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // 6. BOTTOM NAVIGATION BAR
            _buildBottomNavBar(theme, bottomPad),
          ],
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────
  // ENERGY SWITCHER (demo/tes tombol ganti tema)
  // ───────────────────────────────────────────────────────────
  Widget _buildEnergySwitcher(EnergyThemeData theme) {
    final labels = ['🍃 Rendah', '💧 Sedang', '⚡ Tinggi'];
    final themes = [
      EnergyThemeData.green,
      EnergyThemeData.blue,
      EnergyThemeData.purple,
    ];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: List.generate(3, (index) {
          final isActive = _energyLevel == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => _switchEnergy(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: themes[index]
                                .primary
                                .withValues(alpha: 0.18),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    labels[index],
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight:
                          isActive ? FontWeight.w700 : FontWeight.w500,
                      color: isActive
                          ? themes[index].primary
                          : Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────
  // 1. TITLE
  // ───────────────────────────────────────────────────────────
  Widget _buildTitle(EnergyThemeData theme) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        'Mau fokus\nkategori apa?',
        key: ValueKey('title_$_energyLevel'),
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: theme.primary,
          height: 1.2,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────
  // 2. SUBTITLE
  // ───────────────────────────────────────────────────────────
  Widget _buildSubtitle(EnergyThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Text(
          'Pilih kategori agar Mindy bisa\nmembantumu memilih tugas terbaik',
          key: ValueKey('subtitle_$_energyLevel'),
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: theme.subtitleColor,
            height: 1.6,
          ),
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────
  // 3. MASCOT SECTION
  // ───────────────────────────────────────────────────────────
  Widget _buildMascotSection(EnergyThemeData theme, double screenWidth) {
    return SizedBox(
      height: 160,
      width: screenWidth,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Decorative elements
          ..._buildDecorations(theme),

          // Floating mascot
          AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _floatAnimation.value),
                child: child,
              );
            },
            child: Image.asset(
              'assets/images/energirendah/mindy.png',
              width: 150,
              height: 130,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => _buildMascotFallback(theme),
            ),
          ),
        ],
      ),
    );
  }

  /// Dekorasi berbeda tiap tema
  List<Widget> _buildDecorations(EnergyThemeData theme) {
    final icon = theme.decorationIcon;
    final c1 = theme.decorationColors[0].withValues(alpha: 0.35);
    final c2 = theme.decorationColors[1].withValues(alpha: 0.25);

    return [
      // Top-left
      Positioned(
        left: 10,
        top: 10,
        child: _animatedDecoration(
          child: Icon(icon, size: 26, color: c1),
          delay: 0,
        ),
      ),
      // Top-right
      Positioned(
        right: 20,
        top: 5,
        child: _animatedDecoration(
          child: Icon(icon, size: 20, color: c2),
          delay: 400,
        ),
      ),
      // Bottom-left
      Positioned(
        left: 30,
        bottom: 15,
        child: _animatedDecoration(
          child: Icon(icon, size: 16, color: c2),
          delay: 200,
        ),
      ),
      // Right-middle
      Positioned(
        right: 10,
        top: 55,
        child: _animatedDecoration(
          child: Icon(icon, size: 14, color: c1.withValues(alpha: 0.2)),
          delay: 600,
        ),
      ),
    ];
  }

  Widget _animatedDecoration({required Widget child, required int delay}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      curve: Curves.easeOut,
      builder: (context, value, ch) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.5 + 0.5 * value,
            child: ch,
          ),
        );
      },
      child: child,
    );
  }

  /// Fallback jika gambar maskot tidak ditemukan
  Widget _buildMascotFallback(EnergyThemeData theme) {
    return Container(
      width: 130,
      height: 100,
      decoration: BoxDecoration(
        color: theme.cardBg,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: theme.primary.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _energyLevel == 0
                  ? '😴'
                  : _energyLevel == 1
                      ? '📖'
                      : '⚡',
              style: const TextStyle(fontSize: 36),
            ),
            const SizedBox(height: 4),
            Text(
              'Mindy',
              style: GoogleFonts.montserrat(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: theme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────
  // 4. CATEGORY GRID (2 kolom x 3 baris)
  // ───────────────────────────────────────────────────────────
  Widget _buildCategoryGrid(EnergyThemeData theme) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.85,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final cat = _categories[index];
        final isSelected = _selectedCategoryIndex == index;
        return _buildCategoryCard(cat, isSelected, theme, index);
      },
    );
  }

  Widget _buildCategoryCard(
    _CategoryItem category,
    bool isSelected,
    EnergyThemeData theme,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : theme.primary.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(18),
          border: isSelected
              ? Border.all(color: theme.primary, width: 2)
              : Border.all(color: Colors.transparent, width: 2),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.primary.withValues(alpha: 0.18),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Container
            Expanded(
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.primary.withValues(alpha: 0.1)
                      : theme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Icon(
                    category.icon,
                    size: 28,
                    color: theme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Label
            Text(
              category.name,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: theme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────
  // 5. TOMBOL LANJUT
  // ───────────────────────────────────────────────────────────

  // Helper untuk get task title berdasarkan kategori
  String _getTaskForCategory(String category) {
    final tasks = {
      'Belajar': 'Baca buku 5 menit',
      'Pekerjaan': 'Baca email',
      'Kesehatan': 'Stretching ringan',
      'Pribadi': 'Journaling',
      'Rumah': 'Rapikan meja',
      'Lainnya': 'Update to-do list',
    };
    return tasks[category] ?? 'Task default';
  }

  // Helper untuk get duration berdasarkan kategori
  String _getDurationForCategory(String category) {
    final durations = {
      'Belajar': '5 menit',
      'Pekerjaan': '10 menit',
      'Kesehatan': '5 menit',
      'Pribadi': '10 menit',
      'Rumah': '5 menit',
      'Lainnya': '5 menit',
    };
    return durations[category] ?? '5 menit';
  }

  Widget _buildLanjutButton(EnergyThemeData theme) {
    final canProceed = _selectedCategoryIndex >= 0;

    return GestureDetector(
      onTap: canProceed
          ? () {
              // Navigasi ke halaman task recommendation Mindy
              final selectedCategory = _categories[_selectedCategoryIndex];
              Get.toNamed(
                AppRoutes.mindyTaskRecommendation,
                arguments: {
                  'taskTitle': _getTaskForCategory(selectedCategory.name),
                  'taskDuration': _getDurationForCategory(selectedCategory.name),
                  'taskCategory': selectedCategory.name,
                },
              );
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: canProceed ? theme.buttonGradient : null,
          color: canProceed ? null : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
          boxShadow: canProceed
              ? [
                  BoxShadow(
                    color: theme.primary.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ikon "..." untuk tema ungu (sesuai desain)
              if (_energyLevel == 2) ...[
                Icon(
                  Icons.more_horiz_rounded,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 20,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                'Lanjut',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: canProceed ? Colors.white : Colors.grey.shade500,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────
  // 6. BOTTOM NAVIGATION BAR
  // ───────────────────────────────────────────────────────────
  Widget _buildBottomNavBar(EnergyThemeData theme, double bottomPad) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
          top: 10,
          bottom: bottomPad + 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _navItems.map((item) {
            return _buildNavItem(item, theme);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNavItem(_NavItem item, EnergyThemeData theme) {
    final color = item.isActive ? theme.navActiveColor : Colors.grey.shade400;

    return GestureDetector(
      onTap: () {
        // Navigasi bottom nav (placeholder)
      },
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: GoogleFonts.montserrat(
                fontSize: 10,
                fontWeight:
                    item.isActive ? FontWeight.w700 : FontWeight.w400,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}