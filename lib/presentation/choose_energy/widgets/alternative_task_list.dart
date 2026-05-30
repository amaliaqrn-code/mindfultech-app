import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/green_theme.dart';

/// Alternative Task List with Radio Button selection
class AlternativeTaskList extends StatelessWidget {
  final List<TaskModel> tasks;
  final TaskModel? selectedTask;
  final Function(TaskModel) onTaskSelected;

  const AlternativeTaskList({
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
        return AlternativeTaskCard(
          task: task,
          isSelected: isSelected,
          onTap: () => onTaskSelected(task),
        );
      },
    );
  }
}

class AlternativeTaskCard extends StatelessWidget {
  final TaskModel task;
  final bool isSelected;
  final VoidCallback onTap;

  const AlternativeTaskCard({
    super.key,
    required this.task,
    required this.isSelected,
    required this.onTap,
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

  Color get _categoryBackgroundColor {
    switch (task.category) {
      case TaskCategory.rumah:
        return GreenTheme.categoryColors['rumah']!;
      case TaskCategory.pekerjaan:
        return GreenTheme.sageGreenPale;
      case TaskCategory.selfCare:
        return GreenTheme.categoryColors['selfCare']!;
      case TaskCategory.belajar:
        return GreenTheme.categoryColors['belajar']!;
      case TaskCategory.hubungan:
        return GreenTheme.categoryColors['hubungan']!;
      case TaskCategory.kreativitas:
        return GreenTheme.categoryColors['kreativitas']!;
      case TaskCategory.kesehatan:
        return GreenTheme.categoryColors['kesehatan']!;
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
      case TaskCategory.kreativitas:
        return GreenTheme.categoryIconColors['kreativitas']!;
      case TaskCategory.kesehatan:
        return GreenTheme.categoryIconColors['kesehatan']!;
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
          color: isSelected ? GreenTheme.sageGreenLight : GreenTheme.backgroundWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? GreenTheme.sageGreen : GreenTheme.borderLight,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? GreenTheme.sageGreen.withValues(alpha: 0.2)
                  : GreenTheme.shadowColor,
              blurRadius: isSelected ? 10 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Category Color Indicator
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _categoryBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _taskIcon,
                color: _categoryIconColor,
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
                      color: isSelected ? GreenTheme.sageGreen : GreenTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: GreenTheme.textGrey,
                    ),
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
        color: isSelected ? GreenTheme.sageGreen : Colors.transparent,
        border: Border.all(
          color: isSelected ? GreenTheme.sageGreen : GreenTheme.borderMedium,
          width: 2,
        ),
      ),
      child: isSelected
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 18,
            )
          : null,
    );
  }
}
