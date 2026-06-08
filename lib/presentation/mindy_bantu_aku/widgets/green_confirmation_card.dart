import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/green_theme.dart';

/// Green Confirmation Card Widget
class GreenConfirmationCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onConfirm;

  const GreenConfirmationCard({
    super.key,
    required this.task,
    required this.onConfirm,
  });

  IconData get _taskIcon {
    switch (task.iconName) {
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
      case 'self_improvement':
        return Icons.self_improvement;
      case 'spa':
        return Icons.spa;
      case 'local_cafe':
        return Icons.local_cafe;
      case 'bed':
        return Icons.bed;
      case 'bathtub':
        return Icons.bathtub;
      case 'face':
        return Icons.face;
      default:
        return Icons.task_alt;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            GreenTheme.backgroundWhite,
            GreenTheme.sageGreenLight,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: GreenTheme.sageGreen,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: GreenTheme.sageGreen.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success Icon
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: GreenTheme.primaryButtonGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: GreenTheme.sageGreen.withValues(alpha: 0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 20),

          // Title
          const Text(
            'Tugas yang kamu pilih:',
            style: TextStyle(
              fontSize: 14,
              color: GreenTheme.textGrey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            task.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: GreenTheme.textDark,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            task.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: GreenTheme.textGrey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          // Meta Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMetaChip(
                icon: _taskIcon,
                label: task.category.displayName,
                color: GreenTheme.sageGreen,
              ),
              const SizedBox(width: 12),
              _buildMetaChip(
                icon: Icons.timer_outlined,
                label: '~${task.estimatedMinutes} menit',
                color: GreenTheme.sageGreen,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Encouragement
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: GreenTheme.sageGreenLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: GreenTheme.sageGreen,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Pilihan yang bagus! Ayo fokus!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: GreenTheme.sageGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}