import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import '../theme/blue_theme.dart';

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
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.95,
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

  Color get _backgroundColor =>
      BlueTheme.primaryBlue.withValues(alpha: 0.12);

  Color get _contentColor => const Color(0xFF2F6FDB);

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
            color:
                isSelected ? BlueTheme.primaryBlue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              category.iconPath, // 🔥 dari TaskCategory (SAMA seperti Green)
              width: 34,
              height: 34,
              colorFilter: ColorFilter.mode(
                _contentColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              category.displayName, // 🔥 dari TaskCategory
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _contentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}