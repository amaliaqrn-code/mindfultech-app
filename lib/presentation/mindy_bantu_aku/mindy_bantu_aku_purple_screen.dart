import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';

/// Layar "Mindy Bantu Aku" - Pemilihan Kategori ENERGI TINGGI
/// Tema: Ungu dengan nuansa semangat
///
/// Alur:
/// 1. Pilih Kategori → 2. Pilih Task → 3. Timer
class MindyBantuAkuPurpleScreen extends StatefulWidget {
  const MindyBantuAkuPurpleScreen({super.key});

  @override
  State<MindyBantuAkuPurpleScreen> createState() => _MindyBantuAkuPurpleScreenState();
}

class _MindyBantuAkuPurpleScreenState extends State<MindyBantuAkuPurpleScreen> {
  // Current step: 0 = category, 1 = task selection
  int _currentStep = 0;
  int _selectedCategoryIndex = -1;
  int _selectedTaskIndex = -1;

  // Categories for high energy
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Belajar', 'image': 'assets/images/pilihenergi/belajar.png'},
    {'name': 'Pekerjaan', 'image': 'assets/images/pilihenergi/pekerjaan.png'},
    {'name': 'Kesehatan', 'image': 'assets/images/pilihenergi/kesehatan.png'},
    {'name': 'Pribadi', 'image': 'assets/images/pilihenergi/pribadi.png'},
    {'name': 'Rumah', 'image': 'assets/images/pilihenergi/rumah.png'},
    {'name': 'Lainnya', 'image': 'assets/images/pilihenergi/lainnya.png'},
  ];

  // Task recommendations based on category (High Energy)
  final Map<String, List<Map<String, dynamic>>> _tasksByCategory = {
    'Belajar': [
      {'title': 'Belajar UI/UX design', 'duration': '3 jam', 'category': 'Belajar', 'color': const Color(0xFF9C27B0)},
      {'title': 'Kerjakan project coding', 'duration': '4 jam', 'category': 'Belajar', 'color': const Color(0xFF9C27B0)},
      {'title': 'Baca dokumentasi tech', 'duration': '2 jam', 'category': 'Belajar', 'color': const Color(0xFF9C27B0)},
    ],
    'Pekerjaan': [
      {'title': 'Bahas email klien', 'duration': '2 jam', 'category': 'Kerja', 'color': const Color(0xFFE91E63)},
      {'title': 'Meeting project', 'duration': '2 jam', 'category': 'Kerja', 'color': const Color(0xFFE91E63)},
      {'title': 'Buat presentasi', 'duration': '2 jam', 'category': 'Kerja', 'color': const Color(0xFFE91E63)},
    ],
    'Kesehatan': [
      {'title': 'Jogging 30 menit', 'duration': '45 menit', 'category': 'Kesehatan', 'color': const Color(0xFF4CAF50)},
      {'title': 'Gym session', 'duration': '1.5 jam', 'category': 'Kesehatan', 'color': const Color(0xFF4CAF50)},
    ],
    'Pribadi': [
      {'title': 'Buat side project', 'duration': '3 jam', 'category': 'Pribadi', 'color': const Color(0xFF7BBEFF)},
      {'title': 'Learning skill baru', 'duration': '2 jam', 'category': 'Pribadi', 'color': const Color(0xFF7BBEFF)},
    ],
    'Rumah': [
      {'title': 'Deep clean rumah', 'duration': '3 jam', 'category': 'Rumah', 'color': const Color(0xFFFF9800)},
      {'title': 'Renovasi kecil', 'duration': '2 jam', 'category': 'Rumah', 'color': const Color(0xFFFF9800)},
    ],
    'Lainnya': [
      {'title': 'Kerja project besar', 'duration': '4 jam', 'category': 'Lainnya', 'color': const Color(0xFF607D8B)},
      {'title': 'Launch product baru', 'duration': '3 jam', 'category': 'Lainnya', 'color': const Color(0xFF607D8B)},
    ],
  };

  // Colors - Ungu Energy
  static const Color primaryColor = Color(0xFF7C4DFF);
  static const Color secondaryColor = Color(0xFFB388FF);
  static const Color cardBg = Color(0xFFF3E5F5);
  static const Color subtitleColor = Color(0xFF9C27B0);

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
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    if (_currentStep == 0) ...[
                      _buildMascot(),
                      const SizedBox(height: 32),
                      _buildCategoryGrid(),
                    ] else ...[
                      _buildTaskList(),
                    ],
                    const SizedBox(height: 32),
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
              const SizedBox(width: 6),
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
          // Lightning decorations for high energy
          Positioned(
            left: 30,
            top: 35,
            child: Icon(Icons.bolt_rounded, color: secondaryColor.withValues(alpha: 0.4), size: 26),
          ),
          Positioned(
            right: 25,
            top: 25,
            child: Icon(Icons.bolt_rounded, color: primaryColor.withValues(alpha: 0.3), size: 20),
          ),
          Positioned(
            left: 15,
            top: 65,
            child: Icon(Icons.bolt_rounded, color: secondaryColor.withValues(alpha: 0.25), size: 16),
          ),
          // Main mascot
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
          'assets/images/energitinggi/mindy.png',
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
                child: Text('⚡', style: TextStyle(fontSize: 40)),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        // Title below mascot
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF7C4DFF), Color(0xFFB388FF)],
          ).createShader(bounds),
          child: const Text(
            'Mau fokus kategori apa?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
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
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF7C4DFF), Color(0xFFB388FF)],
          ).createShader(bounds),
          child: const Text(
            'Mau fokus kategori apa?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Pilih kategori agar Mindy bisa membantumu memilih cara terbaik',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: subtitleColor,
          ),
        ),
        const SizedBox(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.9,
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : cardBg,
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? Border.all(color: primaryColor, width: 1.5) : null,
          boxShadow: isSelected
              ? [BoxShadow(color: primaryColor.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 2))]
              : [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(imagePath, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => _buildFallbackIcon(label)),
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
      width: 50, height: 50,
      decoration: BoxDecoration(color: Color(0xFF8871C6).withValues(alpha: 0.15), shape: BoxShape.circle),
      child: Icon(icon, color: Color(0xFF8871C6), size: 26),
    );
  }

  /// ===== STEP 2: TASK LIST =====

  Widget _buildTaskList() {
    final selectedCategoryName = _categories[_selectedCategoryIndex]['name'] as String;
    final tasks = _tasksByCategory[selectedCategoryName] ?? [];

    return Column(
      children: [
        // Header title
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF7C4DFF), Color(0xFFB388FF)],
          ).createShader(bounds),
          child: const Text(
            'Task yang cocok untukmu',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Pilih task yang ingin kamu kerjakan',
          style: TextStyle(
            fontSize: 14,
            color: subtitleColor,
          ),
        ),
        const SizedBox(height: 24),

        // Mindy mascot
        SizedBox(
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: 0,
                top: 10,
                child: Image.asset(
                  'assets/images/energitinggi/mindy.png',
                  width: 80,
                  height: 70,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : cardBg,
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
          boxShadow: isSelected
              ? [BoxShadow(color: primaryColor.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 2))]
              : null,
        ),
        child: Row(
          children: [
            // Task icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                _getCategoryIcon(category),
                color: color,
                size: 26,
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
                      fontSize: 16,
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
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
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
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF7C4DFF), Color(0xFFB388FF)],
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
      padding: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.of(context).padding.bottom + 20),
      child: GestureDetector(
        onTap: canProceed ? () {
          if (_currentStep == 0) {
            setState(() {
              _currentStep = 1;
              _selectedTaskIndex = -1;
            });
          } else {
            Get.toNamed(AppRoutes.timer);
          }
        } : null,
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            gradient: canProceed
                ? const LinearGradient(
                    colors: [Color(0xFF7C4DFF), Color(0xFFB388FF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: canProceed ? null : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(100),
            boxShadow: canProceed
                ? [BoxShadow(color: primaryColor.withValues(alpha: 0.35), blurRadius: 12, offset: const Offset(0, 4))]
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