import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/blue_theme.dart';

/// Blue Alternative Task List Widget
class BlueAlternativeTaskList extends StatelessWidget {
  final List<TaskModel> tasks;
  final TaskModel? selectedTask;
  final Function(TaskModel) onTaskSelected;

  const BlueAlternativeTaskList({
    super.key,
    required this.tasks,
    required this.selectedTask,
    required this.onTaskSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final task = tasks[index];
        final isSelected = selectedTask?.id == task.id;
        return BlueAlternativeTaskCard(
          task: task,
          isSelected: isSelected,
          onTap: () => onTaskSelected(task),
        );
      },
    );
  }
}

class BlueAlternativeTaskCard extends StatelessWidget {
  final TaskModel task;
  final bool isSelected;
  final VoidCallback onTap;

  const BlueAlternativeTaskCard({
    super.key,
    required this.task,
    required this.isSelected,
    required this.onTap,
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
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? BlueTheme.primaryBlue : BlueTheme.backgroundWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? BlueTheme.primaryBlue : BlueTheme.borderLight,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? BlueTheme.primaryBlue.withValues(alpha: 0.3)
                  : BlueTheme.shadowColor,
              blurRadius: isSelected ? 10 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? BlueTheme.primaryBlueLight.withValues(alpha: 0.3)
                    : BlueTheme.primaryBluePale,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _taskIcon,
                color: isSelected ? Colors.white : BlueTheme.primaryBlue,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Task Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : BlueTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.9)
                          : BlueTheme.textGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 12,
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.8)
                            : BlueTheme.textLightGrey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '~${task.estimatedMinutes} menit',
                        style: TextStyle(
                          fontSize: 11,
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.8)
                              : BlueTheme.textLightGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Radio Button Indicator
            _buildRadioIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioIndicator() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.white : Colors.transparent,
        border: Border.all(
          color: isSelected ? Colors.white : BlueTheme.borderMedium,
          width: 2,
        ),
      ),
      child: isSelected
          ? Icon(
              Icons.check,
              color: BlueTheme.primaryBlue,
              size: 18,
            )
          : null,
    );
  }
}