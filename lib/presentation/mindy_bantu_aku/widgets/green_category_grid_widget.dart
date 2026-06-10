import 'package:flutter/material.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import '../theme/green_theme.dart';

/// Green Category Grid Widget - Grid 2x3 dengan Green Theme
class GreenCategoryGridWidget extends StatelessWidget {
  final TaskCategory? selectedCategory;
  final Function(TaskCategory) onCategorySelected;

  const GreenCategoryGridWidget({
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
        return GreenCategoryCard(
          category: category,
          isSelected: isSelected,
          onTap: () => onCategorySelected(category),
        );
      },
    );
  }
}

class GreenCategoryCard extends StatelessWidget {
  final TaskCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const GreenCategoryCard({
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
      case TaskCategory.pribadi:
        return Icons.person_rounded;
      case TaskCategory.belajar:
        return Icons.menu_book_rounded;
      case TaskCategory.lainnya:
        return Icons.auto_awesome_rounded;
      case TaskCategory.kesehatan:
        return Icons.favorite_rounded;
    }
  }

  Color get _backgroundColor {
    switch (category) {
      case TaskCategory.pekerjaan:
        return const Color(0xFFD8F3DC);
      case TaskCategory.belajar:
        return const Color(0xFFC7E7A6);
      case TaskCategory.kesehatan:
        return const Color(0xFFA7D7A7);
      case TaskCategory.lainnya:
        return const Color(0xFFB7E4C7);
      case TaskCategory.rumah:
        return GreenTheme.sageGreenLight;
      case TaskCategory.pribadi:
        return const Color(0xFFC9F0D6);
    }
  }

  Color get _iconColor {
    switch (category) {
      case TaskCategory.pekerjaan:
        return const Color(0xFF2F8F6A);
      case TaskCategory.belajar:
        return const Color(0xFF3A8C47);
      case TaskCategory.kesehatan:
        return const Color(0xFF257A4B);
      case TaskCategory.lainnya:
        return const Color(0xFF4C956C);
      case TaskCategory.rumah:
        return GreenTheme.sageGreen;
      case TaskCategory.pribadi:
        return const Color(0xFF5DAE82);
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