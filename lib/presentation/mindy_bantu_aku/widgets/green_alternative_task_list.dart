import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import '../theme/green_theme.dart';

/// Green Alternative Task List Widget
class GreenAlternativeTaskList extends StatelessWidget {
  final List<TaskModel> tasks;
  final TaskModel? selectedTask;
  final Function(TaskModel) onTaskSelected;

  const GreenAlternativeTaskList({
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
        return GreenAlternativeTaskCard(
          task: task,
          isSelected: isSelected,
          onTap: () => onTaskSelected(task),
        );
      },
    );
  }
}

class GreenAlternativeTaskCard extends StatelessWidget {
  final TaskModel task;
  final bool isSelected;
  final VoidCallback onTap;

  const GreenAlternativeTaskCard({
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
          color: isSelected ? GreenTheme.sageGreenFaded : GreenTheme.sageGreenPale,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: GreenTheme.sageGreen, // full hijau solid
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                task.kategori.iconPath,
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  Colors.white, // icon putih seperti gambar
                  BlendMode.srcIn,
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
                      color: isSelected ? GreenTheme.textDark : GreenTheme.textDark,
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
                          ? GreenTheme.textGrey
                          : GreenTheme.textGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 12,
                        color: isSelected
                            ? GreenTheme.textLightGrey
                            : GreenTheme.textLightGrey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '~${task.estimasiWaktu} menit',
                        style: TextStyle(
                          fontSize: 11,
                          color: isSelected
                              ? GreenTheme.textLightGrey
                              : GreenTheme.textLightGrey,
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
        color: isSelected ? GreenTheme.sageGreenDark : Colors.white,
      ),
    );
  }
}