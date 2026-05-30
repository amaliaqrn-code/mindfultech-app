import 'package:flutter/material.dart';
import '../models/task_model.dart';
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
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.0,
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

  IconData get _icon {
    switch (category) {
      case TaskCategory.rumah:
        return Icons.home_rounded;
      case TaskCategory.pekerjaan:
        return Icons.work_rounded;
      case TaskCategory.selfCare:
        return Icons.favorite_rounded;
      case TaskCategory.belajar:
        return Icons.menu_book_rounded;
      case TaskCategory.hubungan:
        return Icons.people_rounded;
      case TaskCategory.kreativitas:
        return Icons.palette_rounded;
      case TaskCategory.kesehatan:
        return Icons.fitness_center_rounded;
    }
  }

  Color get _backgroundColor {
    switch (category) {
      case TaskCategory.kesehatan:
        return PurpleTheme.categoryColors['kesehatan']!;
      case TaskCategory.kreativitas:
        return PurpleTheme.categoryColors['kreativitas']!;
      case TaskCategory.pekerjaan:
        return PurpleTheme.categoryColors['pekerjaan']!;
      case TaskCategory.belajar:
        return PurpleTheme.categoryColors['belajar']!;
      case TaskCategory.hubungan:
        return PurpleTheme.categoryColors['hubungan']!;
      case TaskCategory.rumah:
        return PurpleTheme.backgroundCream;
      case TaskCategory.selfCare:
        return PurpleTheme.categoryColors['kesehatanMental']!;
    }
  }

  Color get _iconColor {
    switch (category) {
      case TaskCategory.kesehatan:
        return PurpleTheme.categoryIconColors['kesehatan']!;
      case TaskCategory.kreativitas:
        return PurpleTheme.categoryIconColors['kreativitas']!;
      case TaskCategory.pekerjaan:
        return PurpleTheme.categoryIconColors['pekerjaan']!;
      case TaskCategory.belajar:
        return PurpleTheme.categoryIconColors['belajar']!;
      case TaskCategory.hubungan:
        return PurpleTheme.categoryIconColors['hubungan']!;
      case TaskCategory.rumah:
        return PurpleTheme.primaryPurple;
      case TaskCategory.selfCare:
        return PurpleTheme.categoryIconColors['kesehatanMental']!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? PurpleTheme.primaryPurplePale : _backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? PurpleTheme.primaryPurple : Colors.transparent,
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
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected ? PurpleTheme.primaryPurple : _iconColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              category.displayName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? PurpleTheme.primaryPurple : PurpleTheme.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}