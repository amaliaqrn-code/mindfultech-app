import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/mindy_base_theme.dart';

/// ============================================================
/// MINDY WIDGETS - Reusable UI components
/// ============================================================

// ============================================================
// HEADER WIDGET
// ============================================================

class MindyHeader extends StatelessWidget {
  final MindyThemeColors theme;
  final int currentStep;
  final VoidCallback? onBack;

  const MindyHeader({
    super.key,
    required this.theme,
    required this.currentStep,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: onBack ??
                () {
                  if (currentStep == 1) {
                    Navigator.of(context).pop();
                  }
                },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.primary.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: theme.primary,
                size: 16,
              ),
            ),
          ),
          const Spacer(),
          // Progress indicator
          Row(
            children: [
              _buildProgressDot(isActive: true),
              const SizedBox(width: 8),
              _buildProgressDot(isActive: currentStep >= 1),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressDot({required bool isActive}) {
    return Container(
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isActive ? theme.primary : Colors.grey.shade300,
      ),
    );
  }
}

// ============================================================
// MASCOT SECTION WIDGET
// ============================================================

class MindyMascotSection extends StatelessWidget {
  final MindyThemeColors theme;
  final String title;
  final String subtitle;
  final bool useGradientTitle;

  const MindyMascotSection({
    super.key,
    required this.theme,
    required this.title,
    required this.subtitle,
    this.useGradientTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decoration based on theme
          ..._buildDecorations(),
          // Main mascot
          _buildMascotContent(),
        ],
      ),
    );
  }

  List<Widget> _buildDecorations() {
    final decorations = <Widget>[];

    // Position decorations based on theme icon type
    if (theme.decorationIcon == Icons.eco_rounded) {
      // Leaves for green (low energy)
      decorations.addAll([
        Positioned(
          left: 20,
          top: 30,
          child: Transform.rotate(
            angle: -0.4,
            child: Image.asset(
              'assets/images/tutorial/daun.png',
              width: 28,
              height: 28,
              color: theme.primary.withValues(alpha: 0.5),
              errorBuilder: (_, __, ___) => Icon(
                Icons.eco_rounded,
                size: 28,
                color: theme.primary.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
        Positioned(
          right: 30,
          top: 20,
          child: Transform.rotate(
            angle: 0.3,
            child: Image.asset(
              'assets/images/tutorial/daun.png',
              width: 22,
              height: 22,
              color: theme.primary.withValues(alpha: 0.4),
              errorBuilder: (_, __, ___) => Icon(
                Icons.eco_rounded,
                size: 22,
                color: theme.primary.withValues(alpha: 0.4),
              ),
            ),
          ),
        ),
      ]);
    } else if (theme.decorationIcon == Icons.star_rounded) {
      // Stars for blue (medium energy)
      decorations.addAll([
        Positioned(
          left: 25,
          top: 35,
          child: Icon(Icons.star_rounded, color: theme.primary.withValues(alpha: 0.25), size: 24),
        ),
        Positioned(
          right: 35,
          top: 25,
          child: Icon(Icons.star_rounded, color: theme.primary.withValues(alpha: 0.2), size: 18),
        ),
        Positioned(
          right: 15,
          top: 65,
          child: Icon(Icons.star_rounded, color: theme.primary.withValues(alpha: 0.15), size: 14),
        ),
      ]);
    } else {
      // Lightning for purple (high energy)
      decorations.addAll([
        Positioned(
          left: 30,
          top: 35,
          child: Icon(Icons.bolt_rounded, color: theme.primary.withValues(alpha: 0.4), size: 26),
        ),
        Positioned(
          right: 25,
          top: 25,
          child: Icon(Icons.bolt_rounded, color: theme.gradient[1].withValues(alpha: 0.3), size: 20),
        ),
      ]);
    }

    return decorations;
  }

  Widget _buildMascotContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Mascot Image
        Image.asset(
          theme.mascotAsset,
          width: 140,
          height: 120,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Container(
            width: 120,
            height: 90,
            decoration: BoxDecoration(
              color: theme.cardBg,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: theme.primary.withValues(alpha: 0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                theme.decorationIcon,
                size: 40,
                color: theme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Title
        useGradientTitle
            ? ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: theme.gradient,
                ).createShader(bounds),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            : Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: theme.primary,
                ),
              ),
        const SizedBox(height: 4),
        // Subtitle
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: theme.subtitle,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// CATEGORY GRID WIDGET
// ============================================================

class MindyCategoryGrid extends StatelessWidget {
  final MindyThemeColors theme;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const MindyCategoryGrid({
    super.key,
    required this.theme,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.88,
      ),
      itemCount: MindyCategory.categories.length,
      itemBuilder: (context, index) {
        final category = MindyCategory.categories[index];
        final isSelected = selectedIndex == index;
        return _MindyCategoryCard(
          category: category,
          isSelected: isSelected,
          theme: theme,
          onTap: () => onSelected(index),
        );
      },
    );
  }
}

class _MindyCategoryCard extends StatelessWidget {
  final MindyCategory category;
  final bool isSelected;
  final MindyThemeColors theme;
  final VoidCallback onTap;

  const _MindyCategoryCard({
    required this.category,
    required this.isSelected,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : theme.cardBg,
          borderRadius: BorderRadius.circular(18),
          border: isSelected ? Border.all(color: theme.primary, width: 1.5) : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.primary.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                category.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.primary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(category.fallbackIcon, color: theme.primary, size: 24),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? theme.primary : theme.primary.withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TASK LIST WIDGET
// ============================================================

class MindyTaskList extends StatelessWidget {
  final MindyThemeColors theme;
  final String mascotAsset;
  final int selectedTaskIndex;
  final List<Map<String, dynamic>> tasks;
  final ValueChanged<int> onTaskSelected;
  final VoidCallback onResetSelection;

  const MindyTaskList({
    super.key,
    required this.theme,
    required this.mascotAsset,
    required this.selectedTaskIndex,
    required this.tasks,
    required this.onTaskSelected,
    required this.onResetSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Mindy mascot at top
        SizedBox(
          height: 100,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Image.asset(
                mascotAsset,
                width: 90,
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Container(
                  width: 80,
                  height: 70,
                  decoration: BoxDecoration(color: theme.cardBg, borderRadius: BorderRadius.circular(32)),
                  child: Icon(theme.decorationIcon, size: 30, color: theme.primary),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Task list
        ...List.generate(tasks.length, (index) {
          final task = tasks[index];
          return _MindyTaskCard(
            title: task['title'] as String,
            duration: task['duration'] as String,
            category: task['category'] as String,
            color: task['color'] as Color,
            isSelected: selectedTaskIndex == index,
            theme: theme,
            onTap: () => onTaskSelected(index),
          );
        }),
        const SizedBox(height: 16),
        // "Coba yang lain" button
        GestureDetector(
          onTap: onResetSelection,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: theme.cardBg,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh_rounded, color: theme.primary, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Coba yang lain',
                  style: TextStyle(color: theme.primary, fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MindyTaskCard extends StatelessWidget {
  final String title;
  final String duration;
  final String category;
  final Color color;
  final bool isSelected;
  final MindyThemeColors theme;
  final VoidCallback onTap;

  const _MindyTaskCard({
    required this.title,
    required this.duration,
    required this.category,
    required this.color,
    required this.isSelected,
    required this.theme,
    required this.onTap,
  });

  IconData _getCategoryIcon() {
    switch (category) {
      case 'Belajar':
        return Icons.menu_book_rounded;
      case 'Kerja':
        return Icons.work_rounded;
      case 'Kesehatan':
        return Icons.favorite_rounded;
      case 'Pribadi':
        return Icons.person_rounded;
      case 'Rumah':
        return Icons.home_rounded;
      default:
        return Icons.auto_awesome_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : theme.cardBg,
          borderRadius: BorderRadius.circular(18),
          border: isSelected ? Border.all(color: theme.primary, width: 1.5) : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.primary.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Task icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(_getCategoryIcon(), color: color, size: 24),
            ),
            const SizedBox(width: 14),
            // Task info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 14, color: theme.subtitle),
                      const SizedBox(width: 4),
                      Text(duration, style: TextStyle(fontSize: 12, color: theme.subtitle)),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Star icon
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: theme.gradient),
              ),
              child: const Icon(Icons.star, color: Colors.white, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// BOTTOM BUTTON WIDGET
// ============================================================

class MindyBottomButton extends StatelessWidget {
  final MindyThemeColors theme;
  final bool isEnabled;
  final String text;
  final VoidCallback? onPressed;

  const MindyBottomButton({
    super.key,
    required this.theme,
    required this.isEnabled,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).padding.bottom + 20,
      ),
      child: GestureDetector(
        onTap: isEnabled ? onPressed : null,
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            color: isEnabled ? theme.primary : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(100),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: theme.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isEnabled ? Colors.white : Colors.grey.shade500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// BOTTOM NAVIGATION BAR WIDGET
// ============================================================

class MindyBottomNavBar extends StatelessWidget {
  final MindyThemeColors theme;
  final int activeIndex;

  const MindyBottomNavBar({
    super.key,
    required this.theme,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    final items = MindyNavItem.getItems(activeIndex, theme);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) => _buildNavItem(item, theme)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(MindyNavItem item, MindyThemeColors theme) {
    final color = item.isActive ? theme.primary : Colors.grey.shade400;

    return SizedBox(
      width: 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(item.icon, color: color, size: 24),
          const SizedBox(height: 4),
          if (item.isActive)
            Container(
              margin: const EdgeInsets.only(bottom: 2),
              height: 2,
              width: 20,
              decoration: BoxDecoration(
                color: theme.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          Text(
            item.label,
            style: GoogleFonts.nunito(
              fontSize: 10,
              fontWeight: item.isActive ? FontWeight.w800 : FontWeight.w500,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}