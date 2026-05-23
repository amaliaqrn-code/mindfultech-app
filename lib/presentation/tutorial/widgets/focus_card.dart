import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/constants/styles.dart';
import '../../../core/constants/colors.dart';

class FocusCard extends StatelessWidget {
  const FocusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),

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

          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.secondary
                      .withOpacity(0.15),
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.menu_book_outlined,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Belajar UI/UX dasar",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "2 jam fokus",
                      style:
                          AppTextStyles.smallText,
                    ),
                  ],
                ),
              ),

              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient:
                      AppColors.primaryGradient,
                ),
                child: const Icon(
                  Icons.star,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        Container(
          width: double.infinity,
          height: 58,

          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(18),
          ),

          child: const Center(
            child: Text(
              "Mulai Fokus Sekarang",
              style: AppTextStyles.buttonText,
            ),
          ),
        ),
      ],
    );
  }
}