import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/constants/styles.dart';
import '../../../core/constants/colors.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  Widget taskItem(
    String title,
    String time,
    String category,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.folder_copy_outlined,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  time,
                  style: AppTextStyles.smallText,
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              style: AppTextStyles.smallText,
            ),
          ),
        ],
      ),
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            "Tugas hari ini",
            style: AppTextStyles.smallText,
          ),

          const SizedBox(height: 20),

          taskItem(
            "Bersihkan kamar",
            "30 menit",
            "Rumah",
          ),

          taskItem(
            "Balas email klien",
            "45 menit",
            "Kerja",
          ),

          taskItem(
            "Tugas Poster",
            "45 menit",
            "Kuliah",
          ),
        ],
      ),
    );
  }
}