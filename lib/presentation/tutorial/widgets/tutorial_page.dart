import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/constants/styles.dart';
import 'package:mindfultech_app/presentation/tutorial/widgets/energy_card.dart';
import 'package:mindfultech_app/presentation/tutorial/widgets/focus_card.dart';
import 'package:mindfultech_app/presentation/tutorial/widgets/journey_card.dart';
import 'package:mindfultech_app/presentation/tutorial/widgets/task_card.dart';

import '../models/tutorial_model.dart';

import '../../../core/constants/colors.dart';

class TutorialPage extends StatelessWidget {
  final TutorialModel data;
  final int index;

  const TutorialPage({
    super.key,
    required this.data,
    required this.index,
  });

  Widget buildCard() {
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
    return Padding(
      padding: const EdgeInsets.all(24),

      child: Column(
        children: [

          const SizedBox(height: 40),

          // TITLE
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.heading.copyWith(
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 14),

          // DESCRIPTION
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.subHeading,
          ),

          const SizedBox(height: 30),

          // CLOUD CHARACTER
          Image.asset(
            "assets/tutorial/cloud.png",
            height: 160,
          ),

          const SizedBox(height: 30),

          // CARD BERUBAH SESUAI PAGE
          buildCard(),

          const Spacer(),
        ],
      ),
    );
  }
}