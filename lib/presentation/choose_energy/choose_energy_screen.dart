import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import 'models/energy_option_model.dart';
import 'data/choose_energy_data.dart';
import 'widgets/energy_card.dart';

class ChooseEnergyScreen extends StatefulWidget {
  const ChooseEnergyScreen({super.key});

  @override
  State<ChooseEnergyScreen> createState() => _ChooseEnergyScreenState();
}

class _ChooseEnergyScreenState extends State<ChooseEnergyScreen> {
  int selectedEnergy = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 24),
              _buildTitle(),
              const SizedBox(height: 40),
              _buildEnergyList(),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primary,
              size: 18,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Center(
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color(0xff4597E6),
                Color(0xff83DFC6),
              ],
            ).createShader(bounds),
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.3,
                ),
                children: const [
                  TextSpan(text: 'Hai, Bagaimana '),
                  TextSpan(text: 'energimu', style: TextStyle(color: Color(0xFFFFFBF0))),
                  TextSpan(text: ' hari ini?'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          ChooseEnergyData.subtitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.subHeading.copyWith(
            fontSize: 16,
            color: const Color(0xff858794),
          ),
        ),
      ],
    );
  }

  Widget _buildEnergyList() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: EnergyOption.options.map((option) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: EnergyCard(
              option: option,
              isSelected: selectedEnergy == option.index,
              onTap: () {
                setState(() {
                  selectedEnergy = option.index;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: selectedEnergy >= 0
              ? const LinearGradient(
                  colors: [
                    Color(0xff4597E6),
                    Color(0xff83DFC6),
                  ],
                )
              : null,
          color: selectedEnergy >= 0 ? null : Colors.grey.shade300,
        ),
        child: ElevatedButton(
          onPressed: selectedEnergy >= 0
              ? () {
                  Get.toNamed(ChooseEnergyData.nextRoute, arguments: {
                    'energy': selectedEnergy,
                  });
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            disabledBackgroundColor: Colors.grey.shade300,
          ),
          child: Text(
            ChooseEnergyData.continueButtonText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: selectedEnergy >= 0
                  ? Colors.white
                  : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}