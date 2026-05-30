import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/blue_theme.dart';

/// Blue Recommendation Card Widget
class BlueRecommendationCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onConfirm;
  final VoidCallback onTryAnother;

  const BlueRecommendationCard({
    super.key,
    required this.task,
    required this.onConfirm,
    required this.onTryAnother,
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
        color: BlueTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: BlueTheme.borderLight,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: BlueTheme.shadowColor,
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
              color: BlueTheme.primaryBluePale,
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
                  color: BlueTheme.primaryBlue,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Hari ini coba kamu fokus ke:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: BlueTheme.primaryBlue,
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
                    color: BlueTheme.primaryBluePale,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _taskIcon,
                    color: BlueTheme.primaryBlue,
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
                    color: BlueTheme.textDark,
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
                    color: BlueTheme.textGrey,
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
                      child: _BlueOutlineButton(
                        text: 'Coba tugas lain',
                        onTap: onTryAnother,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Confirm Button (Solid Blue)
                    Expanded(
                      child: _BlueSolidButton(
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
        color: BlueTheme.backgroundCream,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: BlueTheme.textLightGrey,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: BlueTheme.textLightGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _BlueOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _BlueOutlineButton({
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
            color: BlueTheme.primaryBlue,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: BlueTheme.primaryBlue,
            ),
          ),
        ),
      ),
    );
  }
}

class _BlueSolidButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _BlueSolidButton({
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
          gradient: BlueTheme.solidBlueGradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: BlueTheme.primaryBlue.withValues(alpha: 0.4),
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