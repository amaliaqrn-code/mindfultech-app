import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import '../theme/purple_theme.dart';

/// Purple Alternative Task List Widget
class PurpleAlternativeTaskList extends StatelessWidget {
  final List<TaskModel> tasks;
  final TaskModel? selectedTask;
  final Function(TaskModel) onTaskSelected;

  const PurpleAlternativeTaskList({
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
        return PurpleAlternativeTaskCard(
          task: task,
          isSelected: isSelected,
          onTap: () => onTaskSelected(task),
        );
      },
    );
  }
}
class PurpleAlternativeTaskCard extends StatelessWidget {
  final TaskModel task;
  final bool isSelected;
  final VoidCallback onTap;

  const PurpleAlternativeTaskCard({
    super.key,
    required this.task,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? PurpleTheme.primaryPurple : PurpleTheme.primaryPurplePale,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? PurpleTheme.primaryPurple.withValues(alpha: 0.3)
                  : PurpleTheme.shadowColor,
              blurRadius: isSelected ? 10 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isSelected
                    ? PurpleTheme.primaryPurplePale
                    : PurpleTheme.primaryPurpleDark,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset(
                  task.kategori.iconPath,
                  width: 30,
                  height: 30,
                  color: isSelected
                    ? PurpleTheme.primaryPurpleDark
                    : PurpleTheme.primaryPurplePale,
                  ),
                ),
              ),
    
            const SizedBox(width: 16),

            // Task Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.namaTugas,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : PurpleTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.kategori.displayName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.9)
                          : PurpleTheme.textGrey,
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
                            : PurpleTheme.textLightGrey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '~${task.estimasiWaktu} menit',
                        style: TextStyle(
                          fontSize: 11,
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.8)
                              : PurpleTheme.textLightGrey,
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
        color: isSelected ? PurpleTheme.primaryPurplePale : PurpleTheme.primaryPurplePale,
        border: Border.all(
          color: isSelected ? Colors.white : PurpleTheme.borderMedium,
          width: 2,
        ),
      ),
    );
  }
}