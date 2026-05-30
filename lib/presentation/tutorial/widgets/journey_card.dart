import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';

class JourneyCard extends StatelessWidget {
  const JourneyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ================= STATISTICS TABS ROW =================
        Row(
          children: [
            _buildStatTab(
              iconPath: "assets/images/tutorial/streak.png",
              label: "Streak",
              isActive: true,
            ),
            const SizedBox(width: 10),
            _buildStatTab(
              iconPath: "assets/images/tutorial/journey.png",
              label: "Journey",
              isActive: false,
            ),
            const SizedBox(width: 10),
            _buildStatTab(
              iconPath: "assets/images/tutorial/reward.png",
              label: "Reward",
              isActive: false,
            ),
          ],
        ),

        const SizedBox(height: 12),

        // ================= JOURNEY MAP ILLUSTRATION =================
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              "assets/images/tutorial/journeymap.png",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                debugPrint("Error loading journey map: $error");
                return Container(
                  color: AppColors.secondary.withValues(alpha: 0.1),
                  child: const Center(
                    child: Icon(
                      Icons.map_outlined,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 12),

        // ================= REFLECTION SECTION =================
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              // Reflection Icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE082).withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  "assets/images/tutorial/refleksiharian.png",
                  width: 26,
                  height: 26,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(width: 12),

              // Reflection Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Refleksi hal ini",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Ceritakan pengalamanmu hari ini",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow Icon
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildStatTab({
    required String iconPath,
    required String label,
    required bool isActive,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isActive
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 32,
              height: 32,
              fit: BoxFit.contain,
              color: isActive ? Colors.white : AppColors.primary,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.star,
                  size: 28,
                  color: isActive ? Colors.white : AppColors.primary,
                );
              },
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTextStyles.smallText.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}