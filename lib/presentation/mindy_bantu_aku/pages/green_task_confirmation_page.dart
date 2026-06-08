import 'package:flutter/material.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/models/task_model.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/theme/green_theme.dart';

/// ============================================================
/// GREEN TASK CONFIRMATION SCREEN
/// Halaman konfirmasi tugas pilihan setelah memilih dari alternatif
/// ============================================================

class GreenTaskConfirmationPage extends StatelessWidget {
  final TaskModel selectedTask;

  const GreenTaskConfirmationPage({
    super.key,
    required this.selectedTask,
  });

  IconData get _taskIcon {
    switch (selectedTask.iconName) {
      case 'email':
        return Icons.email;
      case 'schedule':
        return Icons.schedule;
      case 'assignment':
        return Icons.assignment;
      case 'trending_up':
        return Icons.trending_up;
      case 'slideshow':
        return Icons.slideshow;
      case 'description':
        return Icons.description;
      case 'folder':
        return Icons.folder;
      case 'event_note':
        return Icons.event_note;
      case 'school':
        return Icons.school;
      case 'menu_book':
        return Icons.menu_book;
      case 'article':
        return Icons.article;
      case 'quiz':
        return Icons.quiz;
      case 'translate':
        return Icons.translate;
      case 'video_library':
        return Icons.video_library;
      case 'directions_walk':
        return Icons.directions_walk;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'restaurant':
        return Icons.restaurant;
      case 'health_and_safety':
        return Icons.health_and_safety;
      case 'medication':
        return Icons.medication;
      case 'palette':
        return Icons.palette;
      case 'camera_alt':
        return Icons.camera_alt;
      case 'edit':
        return Icons.edit;
      case 'restaurant_menu':
        return Icons.restaurant_menu;
      case 'movie':
        return Icons.movie;
      case 'groups':
        return Icons.groups;
      case 'family_restroom':
        return Icons.family_restroom;
      case 'call':
        return Icons.call;
      case 'pets':
        return Icons.pets;
      case 'favorite':
        return Icons.favorite;
      case 'work':
        return Icons.work;
      default:
        return Icons.task_alt;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GreenTheme.backgroundPage,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),

            // Title
            const Text(
              'Tugas Dipilih',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: GreenTheme.sageGreen,
              ),
            ),
            const SizedBox(height: 6),

            // Subtitle
            const Text(
              'Yuk, pastikan tugas yang kamu pilih ini\ndan siap untuk fokus!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: GreenTheme.textGrey,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),

            // Mascot Image - centered above card
            _buildMascotImage(),

            const SizedBox(height: 12),

            // Main Task Card
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Card - min height 340
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(minHeight: 340),
                      decoration: BoxDecoration(
                        color: GreenTheme.backgroundWhite,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: GreenTheme.sageGreen.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: GreenTheme.shadowColor,
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Badge Header - height 56
                          Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              color: GreenTheme.sageGreenLight,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.lightbulb_outline,
                                  color: GreenTheme.sageGreen,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Hari ini coba kamu fokus ke:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: GreenTheme.sageGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Content
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                // Task Icon -100x100
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: GreenTheme.sageGreenLight,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _taskIcon,
                                    color: GreenTheme.sageGreen,
                                    size: 50,
                                  ),
                                ),
                                const SizedBox(height: 32), // badge -> icon = 32

                                // Task Title
                                Text(
                                  selectedTask.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: GreenTheme.textDark,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 16), // icon -> title = 28 (with 12 already from icon)

                                // Task Description
                                Text(
                                  selectedTask.description,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: GreenTheme.textGrey,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 32), // description -> card bottom = 32
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24), // card -> primary button = 24

                    // Primary Button - "Yay, Lanjut Fokus!"
                    GestureDetector(
                      onTap: () {
                        // Navigate to timer
                      },
                      child: Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          color: GreenTheme.sageGreen,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: [
                            BoxShadow(
                              color: GreenTheme.sageGreen.withValues(alpha: 0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Yay, Lanjut Fokus!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16), // primary -> secondary = 16

                    // Secondary Button - "Buat Tugasmu Sendiri"
                    GestureDetector(
                      onTap: () {
                        // Navigate to create task screen
                      },
                      child: Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          color: GreenTheme.backgroundWhite,
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(
                            color: GreenTheme.sageGreen,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Buat Tugasmu Sendiri',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: GreenTheme.sageGreen,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMascotImage() {
    return Center(
      child: Image.asset(
        'assets/images/energirendah/energi_rendah_rekomendasi.png',
        width: 180,
        height: 90,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 180,
            height: 90,
            decoration: BoxDecoration(
              color: GreenTheme.sageGreenLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text('😴', style: TextStyle(fontSize: 50)),
            ),
          );
        },
      ),
    );
  }
}
