import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';

class EnergyCard extends StatelessWidget {
  const EnergyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ================= ENERGY SELECTION BOX =================
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Box Title
              const Text(
                "Cek energimu hari ini",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 20),

              // Energy Options Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Low Energy
                  _buildEnergyOption(
                    iconPath: "assets/images/tutorial/daun.png",
                    label: "Low",
                    isSelected: false,
                  ),

                  // Medium Energy
                  _buildEnergyOption(
                    iconPath: "assets/images/tutorial/batrai.png",
                    label: "Medium",
                    isSelected: true,
                  ),

                  // High Energy
                  _buildEnergyOption(
                    iconPath: "assets/images/tutorial/petir.png",
                    label: "High",
                    isSelected: false,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildEnergyOption({
    required String iconPath,
    required String label,
    required bool isSelected,
  }) {
    return Column(
      children: [
        // Icon Container
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isSelected ? AppColors.primaryGradient : null,
            color: isSelected ? null : Colors.grey.shade100,
            border: isSelected
                ? null
                : Border.all(color: Colors.grey.shade300, width: 1),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: 28,
              height: 28,
              fit: BoxFit.contain,
              color: isSelected ? Colors.white : AppColors.primary,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Label
        Text(
          label,
          style: AppTextStyles.smallText.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 13,
            color: isSelected ? AppColors.primary : AppColors.textGrey,
          ),
        ),
      ],
    );
  }
}