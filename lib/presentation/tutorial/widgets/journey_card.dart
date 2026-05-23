import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/constants/styles.dart';
import '../../../core/constants/colors.dart';

class JourneyCard extends StatelessWidget {
  const JourneyCard({super.key});

  Widget topItem(
    IconData icon,
    String text,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.secondary,
          ),
        ),

        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
            ),

            const SizedBox(height: 8),

            Text(
              text,
              style: AppTextStyles.smallText,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            topItem(Icons.local_fire_department, "Streak"),
            topItem(Icons.route, "Journey"),
            topItem(Icons.star, "Reward"),
          ],
        ),

        const SizedBox(height: 24),

        Container(
          height: 180,
          width: double.infinity,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),

            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(0.05),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: const Center(
            child: Text(
              "Journey Map",
              style: AppTextStyles.heading,
            ),
          ),
        ),
      ],
    );
  }
}