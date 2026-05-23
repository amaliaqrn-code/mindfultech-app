import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../models/journey_level_model.dart';

class JourneyNode extends StatelessWidget {
  final JourneyLevelModel level;
  final bool isUnlocked;
  final bool isCurrentLevel;
  final bool isCompleted;
  final VoidCallback? onTap;

  const JourneyNode({
    super.key,
    required this.level,
    this.isUnlocked = false,
    this.isCurrentLevel = false,
    this.isCompleted = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUnlocked ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _getNodeColor(),
          border: isCurrentLevel
              ? Border.all(color: AppColors.primary, width: 3)
              : null,
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              level.emoji,
              style: TextStyle(
                fontSize: isUnlocked ? 32 : 24,
              ),
            ),
            if (isUnlocked)
              Text(
                'Lv.${level.level}',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isCurrentLevel
                      ? AppColors.primary
                      : AppColors.textGrey,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getNodeColor() {
    if (isCompleted) {
      return AppColors.mint.withValues(alpha: 0.3);
    } else if (isUnlocked) {
      return Colors.white;
    } else {
      return Colors.grey.shade300;
    }
  }
}