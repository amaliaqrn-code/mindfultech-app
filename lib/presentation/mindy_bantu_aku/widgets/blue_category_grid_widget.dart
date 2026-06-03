import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/blue_theme.dart';

/// Blue Category Grid Widget - Grid 2x3 dengan Blue Theme
class BlueCategoryGridWidget extends StatelessWidget {
  final TaskCategory? selectedCategory;
  final Function(TaskCategory) onCategorySelected;

  const BlueCategoryGridWidget({
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
        return BlueCategoryCard(
          category: category,
          isSelected: isSelected,
          onTap: () => onCategorySelected(category),
        );
      },
    );
  }
}

class BlueCategoryCard extends StatelessWidget {
  final TaskCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const BlueCategoryCard({
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
        return Icons.person_rounded;
      case TaskCategory.belajar:
        return Icons.menu_book_rounded;
      case TaskCategory.hubungan:
        return Icons.auto_awesome_rounded;
      case TaskCategory.kesehatan:
        return Icons.favorite_rounded;
    }
  }

  Color get _backgroundColor {
    switch (category) {
      case TaskCategory.pekerjaan:
        return BlueTheme.categoryColors['pekerjaan']!;
      case TaskCategory.belajar:
        return BlueTheme.categoryColors['belajar']!;
      case TaskCategory.kesehatan:
        return BlueTheme.categoryColors['kesehatan']!;
      case TaskCategory.hubungan:
        return BlueTheme.categoryColors['hubungan']!;
      case TaskCategory.rumah:
        return BlueTheme.backgroundCream;
      case TaskCategory.selfCare:
        return BlueTheme.categoryColors['kesehatanMental']!;
    }
  }

  Color get _iconColor {
    switch (category) {
      case TaskCategory.pekerjaan:
        return BlueTheme.categoryIconColors['pekerjaan']!;
      case TaskCategory.belajar:
        return BlueTheme.categoryIconColors['belajar']!;
      case TaskCategory.kesehatan:
        return BlueTheme.categoryIconColors['kesehatan']!;
      case TaskCategory.hubungan:
        return BlueTheme.categoryIconColors['hubungan']!;
      case TaskCategory.rumah:
        return BlueTheme.primaryBlue;
      case TaskCategory.selfCare:
        return BlueTheme.categoryIconColors['kesehatanMental']!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? BlueTheme.primaryBluePale : _backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? BlueTheme.primaryBlue : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? BlueTheme.primaryBlue.withValues(alpha: 0.3)
                  : BlueTheme.shadowColor,
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
                color: isSelected ? BlueTheme.primaryBlue : _iconColor,
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
                color: isSelected ? BlueTheme.primaryBlue : BlueTheme.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
