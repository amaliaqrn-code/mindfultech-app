import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';

/// Layar "Mindy Bantu Aku" - Pemilihan Kategori ENERGI RENDAH
/// Tema: Hijau Hutan dengan nuansa menenangkan
///
/// Alur:
/// 1. Pilih Kategori → 2. Pilih Task → 3. Timer
class MindyBantuAkuRendahScreen extends StatefulWidget {
  const MindyBantuAkuRendahScreen({super.key});

  @override
  State<MindyBantuAkuRendahScreen> createState() => _MindyBantuAkuRendahScreenState();
}

class _MindyBantuAkuRendahScreenState extends State<MindyBantuAkuRendahScreen> {
  // Current step: 0 = category, 1 = task selection
  int _currentStep = 0;
  int _selectedCategoryIndex = -1;
  int _selectedTaskIndex = -1;

  // Categories for low energy
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Belajar', 'image': 'assets/images/pilihenergi/belajar.png'},
    {'name': 'Pekerjaan', 'image': 'assets/images/pilihenergi/pekerjaan.png'},
    {'name': 'Kesehatan', 'image': 'assets/images/pilihenergi/kesehatan.png'},
    {'name': 'Pribadi', 'image': 'assets/images/pilihenergi/pribadi.png'},
    {'name': 'Rumah', 'image': 'assets/images/pilihenergi/rumah.png'},
    {'name': 'Lainnya', 'image': 'assets/images/pilihenergi/lainnya.png'},
  ];

  // Task recommendations based on category (Low Energy)
  final Map<String, List<Map<String, dynamic>>> _tasksByCategory = {
    'Belajar': [
      {'title': 'Baca buku 5 menit', 'duration': '5 menit', 'category': 'Belajar', 'color': const Color(0xFF5D8A57)},
      {'title': 'Belajar vocabulary baru', 'duration': '10 menit', 'category': 'Belajar', 'color': const Color(0xFF5D8A57)},
    ],
    'Pekerjaan': [
      {'title': 'Baca email', 'duration': '10 menit', 'category': 'Kerja', 'color': const Color(0xFF4597E6)},
    ],
    'Kesehatan': [
      {'title': 'Stretching ringan', 'duration': '5 menit', 'category': 'Kesehatan', 'color': const Color(0xFFE91E63)},
    ],
    'Pribadi': [
      {'title': 'Journaling', 'duration': '10 menit', 'category': 'Pribadi', 'color': const Color(0xFF9C27B0)},
      {'title': 'Meditasi singkat', 'duration': '5 menit', 'category': 'Pribadi', 'color': const Color(0xFF9C27B0)},
    ],
    'Rumah': [
      {'title': 'Rapikan meja', 'duration': '5 menit', 'category': 'Rumah', 'color': const Color(0xFFFF9800)},
    ],
    'Lainnya': [
      {'title': 'Update to-do list', 'duration': '5 menit', 'category': 'Lainnya', 'color': const Color(0xFF607D8B)},
    ],
  };

  // Colors - Hijau Hutan
  static const Color primaryColor = Color(0xFF5D8A57);
  static const Color cardBg = Color(0xFFE3EFE0);
  static const Color subtitleColor = Color(0xFF8FA88B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    if (_currentStep == 0) ...[
                      _buildMascot(),
                      const SizedBox(height: 24),
                      _buildCategoryGrid(),
                    ] else ...[
                      _buildTaskList(),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (_currentStep == 1) {
                setState(() {
                  _currentStep = 0;
                  _selectedTaskIndex = -1;
                });
              } else {
                Get.back();
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: primaryColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: primaryColor,
                size: 16,
              ),
            ),
          ),
          const Spacer(),
          // Progress indicator
          Row(
            children: [
              _buildProgressDot(isActive: true),
              const SizedBox(width: 8),
              _buildProgressDot(isActive: _currentStep >= 1),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressDot({required bool isActive}) {
    return Container(
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isActive ? primaryColor : Colors.grey.shade300,
      ),
    );
  }

  Widget _buildMascot() {
    return SizedBox(
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Floating leaves decoration
          Positioned(
            left: 20,
            top: 30,
            child: Transform.rotate(
              angle: -0.4,
              child: Image.asset(
                'assets/images/tutorial/daun.png',
                width: 28,
                height: 28,
                color: primaryColor.withValues(alpha: 0.5),
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.eco_rounded,
                  size: 28,
                  color: primaryColor.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            top: 20,
            child: Transform.rotate(
              angle: 0.3,
              child: Image.asset(
                'assets/images/tutorial/daun.png',
                width: 22,
                height: 22,
                color: primaryColor.withValues(alpha: 0.4),
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.eco_rounded,
                  size: 22,
                  color: primaryColor.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 60,
            child: Transform.rotate(
              angle: 0.5,
              child: Image.asset(
                'assets/images/tutorial/daun.png',
                width: 18,
                height: 18,
                color: primaryColor.withValues(alpha: 0.35),
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.eco_rounded,
                  size: 18,
                  color: primaryColor.withValues(alpha: 0.35),
                ),
              ),
            ),
          ),
          // Main mascot - Mindy sleepy
          _buildCloudMascot(),
        ],
      ),
    );
  }

  Widget _buildCloudMascot() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/energirendah/awanmindy1.png',
          width: 140,
          height: 120,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 120,
              height: 90,
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Center(
                child: Text('😴', style: TextStyle(fontSize: 40)),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        // Title below mascot
        const Text(
          'Mau fokus kategori apa?',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Pilih kategori agar Mindy bisa\nmembantumu memilih cara terbaik',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: subtitleColor,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryGrid() {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.88,
          ),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            final isSelected = _selectedCategoryIndex == index;
            return _buildCategoryCard(
              imagePath: category['image'] as String,
              label: category['name'] as String,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required String imagePath,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : cardBg,
          borderRadius: BorderRadius.circular(18),
          border: isSelected ? Border.all(color: primaryColor, width: 1.5) : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => _buildFallbackIcon(label),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? primaryColor : primaryColor.withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackIcon(String label) {
    IconData icon;
    switch (label) {
      case 'Belajar': icon = Icons.menu_book_rounded; break;
      case 'Pekerjaan': icon = Icons.work_rounded; break;
      case 'Kesehatan': icon = Icons.favorite_rounded; break;
      case 'Pribadi': icon = Icons.person_rounded; break;
      case 'Rumah': icon = Icons.home_rounded; break;
      default: icon = Icons.auto_awesome_rounded;
    }
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: primaryColor, size: 24),
    );
  }

  /// ===== STEP 2: TASK LIST =====

  Widget _buildTaskList() {
    final selectedCategoryName = _categories[_selectedCategoryIndex]['name'] as String;
    final tasks = _tasksByCategory[selectedCategoryName] ?? [];

    return Column(
      children: [
        // Mindy mascot at top
        SizedBox(
          height: 100,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Image.asset(
                'assets/images/energirendah/awanmindy1.png',
                width: 90,
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 70,
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Center(child: Text('😴', style: TextStyle(fontSize: 30))),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Header title
        const Text(
          'Task yang cocok untukmu',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Pilih task yang ingin kamu kerjakan',
          style: TextStyle(
            fontSize: 13,
            color: subtitleColor,
          ),
        ),
        const SizedBox(height: 20),

        // Task list
        ...List.generate(tasks.length, (index) {
          final task = tasks[index];
          return _buildTaskCard(
            title: task['title'] as String,
            duration: task['duration'] as String,
            category: task['category'] as String,
            color: task['color'] as Color,
            isSelected: _selectedTaskIndex == index,
            onTap: () {
              setState(() {
                _selectedTaskIndex = index;
              });
            },
          );
        }),

        const SizedBox(height: 16),

        // "Coba yang lain" button
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedTaskIndex = -1;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh_rounded, color: primaryColor, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Coba yang lain',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCard({
    required String title,
    required String duration,
    required String category,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : cardBg,
          borderRadius: BorderRadius.circular(18),
          border: isSelected ? Border.all(color: primaryColor, width: 1.5) : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Task icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                _getCategoryIcon(category),
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            // Task info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 14, color: subtitleColor),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: TextStyle(
                          fontSize: 12,
                          color: subtitleColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Star icon (favorite)
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF5D8A57), Color(0xFF8FBC8F)],
                ),
              ),
              child: const Icon(Icons.star, color: Colors.white, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Belajar': return Icons.menu_book_rounded;
      case 'Kerja': return Icons.work_rounded;
      case 'Kesehatan': return Icons.favorite_rounded;
      case 'Pribadi': return Icons.person_rounded;
      case 'Rumah': return Icons.home_rounded;
      default: return Icons.auto_awesome_rounded;
    }
  }

  Widget _buildBottomButton() {
    final bool canProceed = (_currentStep == 0)
        ? (_selectedCategoryIndex >= 0)
        : (_selectedTaskIndex >= 0);

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).padding.bottom + 20,
      ),
      child: GestureDetector(
        onTap: canProceed
            ? () {
                if (_currentStep == 0) {
                  setState(() {
                    _currentStep = 1;
                    _selectedTaskIndex = -1;
                  });
                } else {
                  Get.toNamed(AppRoutes.timer);
                }
              }
            : null,
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            color: canProceed ? primaryColor : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(100),
            boxShadow: canProceed
                ? [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              _currentStep == 0 ? 'Lanjut' : 'Yuk, mulai fokus!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: canProceed ? Colors.white : Colors.grey.shade500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}