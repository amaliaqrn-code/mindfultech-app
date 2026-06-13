import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/core/constants/colors.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import '../models/energy_option_model.dart';
import '../data/choose_energy_data.dart';
import '../widgets/energy_card.dart';

class ChooseEnergyPage extends StatefulWidget {
  const ChooseEnergyPage({super.key});

  @override
  State<ChooseEnergyPage> createState() => _ChooseEnergyPageState();
}

class _ChooseEnergyPageState extends State<ChooseEnergyPage> {
  int _selectedEnergy = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTitle(),
              const SizedBox(height: 32),
              Expanded(child: _buildEnergyList()),
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
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primary,
              size: 16,
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
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xff4597E6),
              Color(0xff83DFC6),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 1.4,
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: 'Hai, Bagaimana ',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'energimu',
                  style: TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: ' hari ini?',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            ChooseEnergyData.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnergyList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: EnergyOption.options.map((option) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: EnergyCard(
            option: option,
            isSelected: _selectedEnergy == option.index,
            onTap: () {
              setState(() {
                _selectedEnergy = option.index;
              });
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: GestureDetector(
        onTap: _selectedEnergy >= 0 ? _onContinue : null,
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: _selectedEnergy >= 0
                ? const LinearGradient(
                    colors: [
                      Color(0xff4597E6),
                      Color(0xff83DFC6),
                    ],
                  )
                : null,
            color: _selectedEnergy >= 0 ? null : Colors.grey.shade300,
          ),
          child: Center(
            child: Text(
              ChooseEnergyData.continueButtonText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _selectedEnergy >= 0
                    ? Colors.white
                    : Colors.grey.shade500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onContinue() {
  // Ambil nilai enum berdasarkan indeks pilihan user (0: rendah, 1: sedang, 2: tinggi)
  final energyLevel = EnergyLevel.values[_selectedEnergy];

  // Navigasi ke halaman TaskCategoryPage yang menampilkan 3 CategoryGridWidget
  Navigator.pushNamed(
    context,
    AppRoutes.taskCategory,
    arguments: {'energyLevel': energyLevel},
  );
}
}