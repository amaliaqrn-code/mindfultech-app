import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../models/journey_level_model.dart';
import '../data/journey_data.dart';

class JourneyLevelCard extends StatelessWidget {
  final JourneyLevelModel level;
  final int totalDays;

  const JourneyLevelCard({
    super.key,
    required this.level,
    required this.totalDays,
  });

  @override
  Widget build(BuildContext context) {
    final progress = JourneyData.getOverallProgress(totalDays);
    final daysInLevel = JourneyData.getCurrentLevelProgress(totalDays);
    final daysToNext = _getDaysToNextLevel();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Level header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  level.emoji,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      level.areaName,
                      style: AppTextStyles.heading.copyWith(fontSize: 22),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Level ${level.level} • ${level.requiredDays} days',
                      style: AppTextStyles.smallText,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Progress bar
          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            lineHeight: 12,
            percent: progress,
            backgroundColor: Colors.grey.shade100,
            linearGradient: AppColors.primaryGradient,
            barRadius: const Radius.circular(10),
            animation: true,
            animationDuration: 800,
          ),

          const SizedBox(height: 12),

          // Progress info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$totalDays days total',
                style: AppTextStyles.smallText.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              Text(
                '$daysToNext days to next',
                style: AppTextStyles.smallText,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Level indicator
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildDayIndicators(daysInLevel),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDayIndicators(int currentDay) {
    final indicators = <Widget>[];
    for (int i = 1; i <= JourneyData.totalDaysInLevel; i++) {
      final isActive = i <= currentDay;
      indicators.add(
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.mint : Colors.white,
            border: Border.all(
              color: isActive ? AppColors.mint : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              '$i',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : AppColors.textGrey,
              ),
            ),
          ),
        ),
      );
    }
    return indicators;
  }

  int _getDaysToNextLevel() {
    final levels = JourneyData.getLevels();
    for (var l in levels) {
      if (totalDays < l.requiredDays) {
        return l.requiredDays - totalDays;
      }
    }
    return 0;
  }
}