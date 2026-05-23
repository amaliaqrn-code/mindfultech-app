import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/constants/styles.dart';
import '../../../core/constants/colors.dart';

class EnergyCard extends StatelessWidget {
  const EnergyCard({super.key});

  Widget energyItem(
    String imagePath,
    String text,
    bool selected,
  ) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient:
                selected ? AppColors.primaryGradient : null,
            color: selected
                ? null
                : Colors.grey.shade100,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              color: selected
                  ? Colors.white
                  : AppColors.primary,
            ),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          text,
          style: AppTextStyles.smallText.copyWith(
            fontWeight: FontWeight.w600,
            color: selected
                ? AppColors.primary
                : AppColors.textGrey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cek energimu hari ini",
            style: AppTextStyles.smallText,
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: [
              energyItem(
                "assets/images/tutorial/daun.png",
                "Low",
                false,
              ),

              energyItem(
                "assets/images/tutorial/batrai.png",
                "Medium",
                true,
              ),

              energyItem(
                "assets/images/tutorial/petir.png",
                "High",
                false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}