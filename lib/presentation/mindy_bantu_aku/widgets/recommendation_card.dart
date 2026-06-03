import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/green_theme.dart';

/// Kartu Rekomendasi Tugas dengan desain besar dan rounded
class RecommendationCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onConfirm;
  final VoidCallback onTryAnother;

  const RecommendationCard({
    super.key,
    required this.task,
    required this.onConfirm,
    required this.onTryAnother,
  });

  IconData get _taskIcon {
    switch (task.iconName) {
      case 'desk':
        return Icons.desk;
      case 'edit_note':
        return Icons.edit_note;
      case 'local_laundry_service':
        return Icons.local_laundry_service;
      case 'local_florist':
        return Icons.local_florist;
      case 'cleaning_services':
        return Icons.cleaning_services;
      case 'king_bed':
        return Icons.king_bed;
      case 'restaurant':
        return Icons.restaurant;
      case 'bathroom':
        return Icons.bathroom;
      case 'warehouse':
        return Icons.warehouse;
      case 'self_improvement':
        return Icons.self_improvement;
      case 'local_cafe':
        return Icons.local_cafe;
      case 'accessibility_new':
        return Icons.accessibility_new;
      case 'face':
        return Icons.face;
      case 'bathtub':
        return Icons.bathtub;
      case 'spa':
        return Icons.spa;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'menu_book':
        return Icons.menu_book;
      case 'translate':
        return Icons.translate;
      case 'play_circle':
        return Icons.play_circle;
      case 'assignment':
        return Icons.assignment;
      case 'school':
        return Icons.school;
      case 'computer':
        return Icons.computer;
      case 'construction':
        return Icons.construction;
      case 'chat':
        return Icons.chat;
      case 'text_fields':
        return Icons.text_fields;
      case 'call':
        return Icons.call;
      case 'pets':
        return Icons.pets;
      case 'family_restroom':
        return Icons.family_restroom;
      case 'groups':
        return Icons.groups;
      case 'brush':
        return Icons.brush;
      case 'music_note':
        return Icons.music_note;
      case 'restaurant_menu':
        return Icons.restaurant_menu;
      case 'create':
        return Icons.create;
      case 'palette':
        return Icons.palette;
      case 'videocam':
        return Icons.videocam;
      case 'medication':
        return Icons.medication;
      case 'favorite':
        return Icons.favorite;
      case 'book':
        return Icons.book;
      case 'directions_walk':
        return Icons.directions_walk;
      case 'sports':
        return Icons.sports;
      case 'pool':
        return Icons.pool;
      case 'hiking':
        return Icons.hiking;
      default:
        return Icons.task_alt;
    }
  }

  Color get _categoryIconColor {
    switch (task.category) {
      case TaskCategory.rumah:
        return GreenTheme.categoryIconColors['rumah']!;
      case TaskCategory.pekerjaan:
        return GreenTheme.sageGreen;
      case TaskCategory.selfCare:
        return GreenTheme.categoryIconColors['selfCare']!;
      case TaskCategory.belajar:
        return GreenTheme.categoryIconColors['belajar']!;
      case TaskCategory.hubungan:
        return GreenTheme.categoryIconColors['hubungan']!;
      case TaskCategory.kesehatan:
        return GreenTheme.categoryIconColors['kesehatan']!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: GreenTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: GreenTheme.borderLight,
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
          // Top Badge
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              color: GreenTheme.sageGreenLight,
              borderRadius: BorderRadius.only(
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
                // Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _categoryIconColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _taskIcon,
                    color: _categoryIconColor,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),

                // Task Title
                Text(
                  task.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: GreenTheme.textDark,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),

                // Task Description
                Text(
                  task.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: GreenTheme.textGrey,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Meta info
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildMetaChip(
                      icon: Icons.category_rounded,
                      label: task.category.displayName,
                    ),
                    const SizedBox(width: 12),
                    _buildMetaChip(
                      icon: Icons.timer_outlined,
                      label: '~${task.estimatedMinutes} menit',
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  children: [
                    // Try Another Button
                    Expanded(
                      child: _OutlineButton(
                        text: 'Coba tugas lain',
                        onTap: onTryAnother,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Confirm Button
                    Expanded(
                      child: _SolidButton(
                        text: 'Aku siap fokus!',
                        onTap: onConfirm,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: GreenTheme.backgroundCream,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: GreenTheme.textLightGrey,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: GreenTheme.textLightGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _OutlineButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: GreenTheme.sageGreen,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: GreenTheme.sageGreen,
            ),
          ),
        ),
      ),
    );
  }
}

class _SolidButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _SolidButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          gradient: GreenTheme.primaryButtonGradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: GreenTheme.sageGreen.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
