import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class JourneyWaypoint extends StatelessWidget {
  final int dayNumber;
  final String level;
  final bool isUnlocked;
  final bool isCurrentDay;
  final bool isCompleted;
  final bool showCloud;
  final VoidCallback? onTap;

  const JourneyWaypoint({
    super.key,
    required this.dayNumber,
    required this.level,
    this.isUnlocked = false,
    this.isCurrentDay = false,
    this.isCompleted = false,
    this.showCloud = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Path line (vertical line connecting waypoints)
            if (dayNumber > 1)
              Positioned(
                top: 0,
                child: SizedBox(
                  width: 4,
                  height: 48,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppColors.mint
                          : isUnlocked
                              ? AppColors.primary.withValues(alpha: 0.3)
                              : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),

            // Waypoint circle
            Positioned(
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getCircleColor(),
                  border: Border.all(
                    color: isCurrentDay
                        ? AppColors.primary
                        : isCompleted
                            ? AppColors.mint
                            : isUnlocked
                                ? Colors.white
                                : Colors.grey.shade400,
                    width: isCurrentDay ? 4 : 2,
                  ),
                  boxShadow: isCurrentDay
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: isUnlocked
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (showCloud) ...[
                              const Text(
                                '☁️',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                '$dayNumber',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isCurrentDay
                                      ? AppColors.primary
                                      : AppColors.textDark,
                                ),
                              ),
                            ] else
                              Text(
                                '$dayNumber',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted
                                      ? Colors.white
                                      : isCurrentDay
                                          ? AppColors.primary
                                          : AppColors.textDark,
                                ),
                              ),
                          ],
                        )
                      : const Icon(
                          Icons.lock,
                          color: Colors.grey,
                          size: 24,
                        ),
                ),
              ),
            ),

            // Path line below
            if (dayNumber < 60)
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: 4,
                  height: 48,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppColors.mint
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),

            // Level label (only show on day 1 of each level)
            if (_isFirstDayOfLevel(dayNumber))
              Positioned(
                left: 80,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Text(
                    level,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

            // Current day indicator
            if (isCurrentDay)
              Positioned(
                right: 80,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'HARI INI',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getCircleColor() {
    if (isCompleted) {
      return AppColors.mint;
    } else if (isCurrentDay) {
      return Colors.white;
    } else if (isUnlocked) {
      return Colors.white;
    } else {
      return Colors.grey.shade200;
    }
  }

  bool _isFirstDayOfLevel(int day) {
    return day == 1 || day == 8 || day == 15 || day == 31 || day == 61;
  }
}