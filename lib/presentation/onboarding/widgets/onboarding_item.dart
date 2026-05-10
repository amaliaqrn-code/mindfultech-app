import 'package:flutter/material.dart';
import '../onboarding_model.dart';

class OnBoardingItem extends StatelessWidget {
  final OnBoardingModel data;

  const OnBoardingItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(data.image, height: 250),
        const SizedBox(height: 30),

        Text(
          data.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        Text(
          data.desc,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}