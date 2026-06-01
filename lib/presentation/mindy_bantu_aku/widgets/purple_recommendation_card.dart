import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/purple_theme.dart';

/// Purple Recommendation Card Widget
class PurpleRecommendationCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onConfirm;
  final VoidCallback onTryAnother;

  const PurpleRecommendationCard({
    super.key,
    required this.task,
    required this.onConfirm,
    required this.onTryAnother,
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
      case 'online':
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
      decoration: BoxDecoration(
        color: PurpleTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: PurpleTheme.borderLight,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: PurpleTheme.shadowColor,
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
              color: PurpleTheme.primaryPurplePale,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bolt,
                  color: PurpleTheme.primaryPurple,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Hari ini coba kamu fokus ke:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: PurpleTheme.primaryPurple,
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
                    color: PurpleTheme.primaryPurplePale,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _taskIcon,
                    color: PurpleTheme.primaryPurple,
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
                    color: PurpleTheme.textDark,
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
                    color: PurpleTheme.textGrey,
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
                    // Try Another Button (Outline)
                    Expanded(
                      child: _PurpleOutlineButton(
                        text: 'Coba tugas lain',
                        onTap: onTryAnother,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Confirm Button (Solid Purple)
                    Expanded(
                      child: _PurpleSolidButton(
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
        color: PurpleTheme.backgroundCream,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: PurpleTheme.textLightGrey,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: PurpleTheme.textLightGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _PurpleOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _PurpleOutlineButton({
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
            color: PurpleTheme.primaryPurple,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: PurpleTheme.primaryPurple,
            ),
          ),
        ),
      ),
    );
  }
}

class _PurpleSolidButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _PurpleSolidButton({
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
          gradient: PurpleTheme.solidPurpleGradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: PurpleTheme.primaryPurple.withValues(alpha: 0.4),
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