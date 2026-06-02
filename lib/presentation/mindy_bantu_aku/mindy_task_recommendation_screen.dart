import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';

/// Layar "Task yang Mindy Pilih" - Rekomendasi Tugas
/// Tema: Hijau Hutan dengan nuansa menenangkan
///
/// Alur:
/// Pilih Kategori → Task Recommendation → Timer
class MindyTaskRecommendationScreen extends StatelessWidget {
  const MindyTaskRecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get data from arguments
    final args = Get.arguments as Map<String, dynamic>?;
    final taskTitle = args?['taskTitle'] as String? ?? 'Baca buku 5 menit';
    final taskDuration = args?['taskDuration'] as String? ?? '5 menit';
    final taskCategory = args?['taskCategory'] as String? ?? 'Belajar';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Main content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    _buildHeader(),
                    const SizedBox(height: 32),
                    _buildTaskCard(
                      title: taskTitle,
                      duration: taskDuration,
                      category: taskCategory,
                    ),
                    const SizedBox(height: 32),
                    _buildMotivationText(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // Bottom button
            _buildBottomButton(context),
          ],
        ),
      ),
    );
  }

  /// ===== HEADER SECTION =====
  Widget _buildHeader() {
    return Column(
      children: [
        // Mindy mascot with decoration
        SizedBox(
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Floating leaves decoration
              Positioned(
                left: 10,
                top: 20,
                child: Transform.rotate(
                  angle: -0.4,
                  child: Image.asset(
                    'assets/images/tutorial/daun.png',
                    width: 26,
                    height: 26,
                    color: const Color(0xFF5D8A57).withValues(alpha: 0.5),
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.eco_rounded,
                      size: 26,
                      color: const Color(0xFF5D8A57).withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 15,
                child: Transform.rotate(
                  angle: 0.3,
                  child: Image.asset(
                    'assets/images/tutorial/daun.png',
                    width: 22,
                    height: 22,
                    color: const Color(0xFF5D8A57).withValues(alpha: 0.4),
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.eco_rounded,
                      size: 22,
                      color: const Color(0xFF5D8A57).withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ),
              // Mindy mascot
              Image.asset(
                'assets/images/energirendah/awanmindy2.png',
                width: 120,
                height: 110,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Container(
                  width: 100,
                  height: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3EFE0),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF5D8A57).withValues(alpha: 0.15),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('😴', style: TextStyle(fontSize: 40)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Title
        const Text(
          'Task yang Mindy pilih',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D8A57),
            height: 1.3,
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Ini task yang cocok untuk energimu hari ini',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8FA88B),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  /// ===== TASK CARD =====
  Widget _buildTaskCard({
    required String title,
    required String duration,
    required String category,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE3EFE0),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5D8A57).withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Task row
          Row(
            children: [
              // Task icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  _getCategoryIcon(category),
                  color: const Color(0xFF5D8A57),
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // Task info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 16,
                          color: const Color(0xFF8FA88B),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          duration,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8FA88B),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF5D8A57).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            category,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF5D8A57),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Star icon
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF5D8A57), Color(0xFF8FBC8F)],
                  ),
                ),
                child: const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Belajar': return Icons.menu_book_rounded;
      case 'Kerja':
      case 'Pekerjaan': return Icons.work_rounded;
      case 'Kesehatan': return Icons.favorite_rounded;
      case 'Pribadi': return Icons.person_rounded;
      case 'Rumah': return Icons.home_rounded;
      default: return Icons.auto_awesome_rounded;
    }
  }

  /// ===== MOTIVATION TEXT =====
  Widget _buildMotivationText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3EFE0).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite_rounded,
            color: const Color(0xFF5D8A57).withValues(alpha: 0.7),
            size: 20,
          ),
          const SizedBox(width: 10),
          const Text(
            'Yuk mulai! Semangat ya!\nKamu pasti bisa',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF5D8A57),
              height: 1.4,
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            Icons.favorite_rounded,
            color: const Color(0xFF5D8A57).withValues(alpha: 0.7),
            size: 20,
          ),
        ],
      ),
    );
  }

  /// ===== BOTTOM BUTTON =====
  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).padding.bottom + 16,
        top: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.timer),
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            color: const Color(0xFF5D8A57),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF5D8A57).withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Mulai',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}