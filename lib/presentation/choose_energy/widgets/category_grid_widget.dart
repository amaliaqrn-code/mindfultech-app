import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/green_theme.dart';

/// Grid Kategori - 2 kolom x 3 baris
class CategoryGridWidget extends StatelessWidget {
  final TaskCategory? selectedCategory;
  final Function(TaskCategory) onCategorySelected;

  const CategoryGridWidget({
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
        return _CategoryCard(
          category: category,
          isSelected: isSelected,
          onTap: () => onCategorySelected(category),
        );
      },
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final TaskCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryCard({
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
        return Icons.accessibility_new_rounded;
    }
  }

  Color get _backgroundColor {
    switch (category) {
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

  Color get _iconColor {
    switch (category) {
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
        decoration: BoxDecoration(
          color: isSelected ? GreenTheme.sageGreenLight : _backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? GreenTheme.sageGreen : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? GreenTheme.sageGreen.withValues(alpha: 0.3)
                  : GreenTheme.shadowColor,
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
                color: isSelected ? GreenTheme.sageGreen : _iconColor,
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
                color: isSelected ? GreenTheme.sageGreen : GreenTheme.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
