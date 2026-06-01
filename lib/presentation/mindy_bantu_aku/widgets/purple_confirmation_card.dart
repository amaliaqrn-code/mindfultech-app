import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/purple_theme.dart';

/// Purple Confirmation Card Widget
class PurpleConfirmationCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onConfirm;

  const PurpleConfirmationCard({
    super.key,
    required this.task,
    required this.onConfirm,
  });

  IconData get _taskIcon {
    switch (task.iconName) {
      case 'fitness_center':
        return Icons.fitness_center;
      case 'directions_run':
        return Icons.directions_run;
      case 'pool':
        return Icons.pool;
      case 'sports':
        return Icons.sports;
      case 'directions_bike':
        return Icons.directions_bike;
      case 'self_improvement':
        return Icons.self_improvement;
      case 'school':
        return Icons.school;
      case 'checkroom':
        return Icons.checkroom;
      case 'edit_document':
        return Icons.edit_document;
      case 'assignment':
        return Icons.assignment;
      case 'code':
        return Icons.code;
      case 'computer':
        return Icons.computer;
      case 'palette':
        return Icons.palette;
      case 'videocam':
        return Icons.videocam;
      case 'music_note':
        return Icons.music_note;
      case 'camera_alt':
        return Icons.camera_alt;
      case 'article':
        return Icons.article;
      case 'menu_book':
        return Icons.menu_book;
      case 'cast_for_education':
        return Icons.cast_for_education;
      case 'family_restroom':
        return Icons.family_restroom;
      case 'groups':
        return Icons.groups;
      case 'volunteer_activism':
        return Icons.volunteer_activism;
      case 'favorite':
        return Icons.favorite;
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
            PurpleTheme.backgroundWhite,
            PurpleTheme.violetAccentLight,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: PurpleTheme.primaryPurple,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: PurpleTheme.primaryPurple.withValues(alpha: 0.25),
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
              gradient: PurpleTheme.primaryButtonGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: PurpleTheme.primaryPurple.withValues(alpha: 0.4),
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
              color: PurpleTheme.textGrey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            task.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: PurpleTheme.textDark,
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
              color: PurpleTheme.textGrey,
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
                color: PurpleTheme.primaryPurple,
              ),
              const SizedBox(width: 12),
              _buildMetaChip(
                icon: Icons.timer_outlined,
                label: '~${task.estimatedMinutes} menit',
                color: PurpleTheme.primaryPurple,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Encouragement
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: PurpleTheme.primaryPurplePale,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.bolt,
                  color: PurpleTheme.primaryPurple,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Siap conquering! Let\'s go!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: PurpleTheme.primaryPurple,
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