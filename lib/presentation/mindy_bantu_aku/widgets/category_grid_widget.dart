import 'package:flutter/material.dart';
import '../models/task_model.dart';

/// Grid Kategori - 3 kolom x 2 baris
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
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.9,
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

  // Colors from spec
  static const Color primaryColor = Color(0xFF5D8A57);
  static const Color cardBg = Color(0xFFE3EFE0);

  const _CategoryCard({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  String get _displayName {
    switch (category) {
      case TaskCategory.rumah:
        return 'Rumah';
      case TaskCategory.pekerjaan:
        return 'Pekerjaan';
      case TaskCategory.selfCare:
        return 'Pribadi';
      case TaskCategory.belajar:
        return 'Belajar';
      case TaskCategory.hubungan:
        return 'Lainnya';
      case TaskCategory.kesehatan:
        return 'Kesehatan';
    }
  }

  String get _imagePath {
    switch (category) {
      case TaskCategory.rumah:
        return 'assets/images/pilihenergi/rumah.png';
      case TaskCategory.pekerjaan:
        return 'assets/images/pilihenergi/pekerjaan.png';
      case TaskCategory.selfCare:
        return 'assets/images/pilihenergi/pribadi.png';
      case TaskCategory.belajar:
        return 'assets/images/pilihenergi/belajar.png';
      case TaskCategory.hubungan:
        return 'assets/images/pilihenergi/lainnya.png';
      case TaskCategory.kesehatan:
        return 'assets/images/pilihenergi/kesehatan.png';
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : cardBg,
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? Border.all(color: primaryColor, width: 1.5) : null,
          boxShadow: isSelected
              ? [BoxShadow(color: primaryColor.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 2))]
              : [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                _imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return _buildFallbackIcon();
                },
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _displayName,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? primaryColor : primaryColor.withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackIcon() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _icon,
        color: primaryColor,
        size: 26,
      ),
    );
  }
}
