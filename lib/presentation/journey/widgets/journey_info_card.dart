import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../data/journey_data.dart';

class JourneyInfoCard extends StatelessWidget {
  final int totalDays;

  const JourneyInfoCard({
    super.key,
    required this.totalDays,
  });

  @override
  Widget build(BuildContext context) {
    final nextMilestone = JourneyData.getNextMilestone(totalDays);
    final nextMilestoneName = JourneyData.getNextMilestoneName(totalDays);
    final daysRemaining = nextMilestone - totalDays;

    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.explore,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Next Destination',
                  style: AppTextStyles.smallText.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              nextMilestoneName,
              style: AppTextStyles.heading.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$daysRemaining days remaining',
              style: AppTextStyles.buttonText.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}