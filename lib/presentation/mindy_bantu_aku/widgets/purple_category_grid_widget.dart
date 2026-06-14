import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import '../theme/purple_theme.dart';

/// Purple Category Grid Widget
class PurpleCategoryGridWidget extends StatelessWidget {
  final TaskCategory? selectedCategory;
  final Function(TaskCategory) onCategorySelected;

  const PurpleCategoryGridWidget({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.95,
      ),
      itemCount: TaskCategory.values.length,
      itemBuilder: (context, index) {
        final category = TaskCategory.values[index];
        final isSelected = selectedCategory == category;

        return PurpleCategoryCard(
          category: category,
          isSelected: isSelected,
          onTap: () => onCategorySelected(category),
        );
      },
    );
  }
}

class PurpleCategoryCard extends StatelessWidget {
  final TaskCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const PurpleCategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  Color get _backgroundColor =>
      PurpleTheme.primaryPurple.withValues(alpha: 0.12);

  Color get _contentColor => const Color(0xFF6D28D9);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : _backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? PurpleTheme.primaryPurple
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? PurpleTheme.primaryPurple.withValues(alpha: 0.3)
                  : PurpleTheme.shadowColor,
              blurRadius: isSelected ? 12 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              category.iconPath,
              width: 34,
              height: 34,
              colorFilter: ColorFilter.mode(
                isSelected
                    ? PurpleTheme.primaryPurple
                    : _contentColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              category.displayName, // 🔥 dari TaskCategory
              style: TextStyle(
                fontSize: 14,
                fontWeight:
                    isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected
                    ? PurpleTheme.primaryPurple
                    : _contentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}