import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../models/tutorial_model.dart';
import '../widgets/energy_card.dart';
import '../widgets/task_card.dart';
import '../widgets/focus_card.dart';
import '../widgets/journey_card.dart';

class TutorialPage extends StatelessWidget {
  final TutorialModel data;
  final int index;

  const TutorialPage({
    super.key,
    required this.data,
    required this.index,
  });

  Widget _buildCard() {
    switch (index) {
      case 0:
        return const EnergyCard();
      case 1:
        return const TaskCard();
      case 2:
        return const FocusCard();
      case 3:
        return const JourneyCard();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ================= HEADER SECTION =================
        const SizedBox(height: 24),

        // Title
        Text(
          data.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xff1A3B7C),
            height: 1.2,
          ),
        ),

        const SizedBox(height: 8),

        // Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            data.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.subHeading.copyWith(
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // ================= ILLUSTRATION SECTION =================
        // Mindy Cloud illustration with stars
        SizedBox(
          height: 180,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Mindy Cloud Image
              Image.asset(
                data.image,
                height: 160,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint("Error loading image: $data.image - $error");
                  return Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.cloud,
                      size: 80,
                      color: AppColors.primary,
                    ),
                  );
                },
              ),

              // Small stars around
              Positioned(
                top: 20,
                right: 60,
                child: _buildStar(size: 16),
              ),
              Positioned(
                top: 40,
                left: 50,
                child: _buildStar(size: 12),
              ),
              Positioned(
                bottom: 30,
                right: 40,
                child: _buildStar(size: 10),
              ),
              Positioned(
                bottom: 50,
                left: 60,
                child: _buildStar(size: 14),
              ),
            ],
          ),
        ),

        // ================= DYNAMIC CONTENT CARD =================
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildCard(),
          ),
        ),

        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildStar({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xffFFD700).withValues(alpha: 0.8),
      ),
      child: const Icon(
        Icons.star,
        size: 10,
        color: Colors.white,
      ),
    );
  }
}