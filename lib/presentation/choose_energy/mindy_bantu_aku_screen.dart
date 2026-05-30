import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/task_model.dart';
import 'controllers/choose_energy_controller.dart';
import 'widgets/mascot_widget.dart';
import 'widgets/category_grid_widget.dart';
import 'widgets/recommendation_card.dart';
import 'widgets/alternative_task_list.dart';
import 'widgets/confirmation_card.dart';
import 'widgets/main_action_button.dart';
import 'theme/green_theme.dart';

/// Layar "Mindy Bantu Aku" - Sistem Filter & Rekomendasi Tugas
/// Menggunakan nuansa hijau (Sage Green theme)
class MindyBantuAkuScreen extends StatelessWidget {
  const MindyBantuAkuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(ChooseEnergyController());

    // Get energy level from arguments
    final args = Get.arguments;
    if (args != null && args['energy'] != null) {
      final energyValue = args['energy'] as int;
      final energy = EnergyLevelExtension.fromValue(energyValue);
      controller.initializeWithEnergy(energy);
    }

    return Scaffold(
      backgroundColor: GreenTheme.backgroundPage,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and progress
            _buildHeader(controller),

            // Main content (scrollable)
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),

                    // Mascot
                    const MascotWidget(size: 100),
                    const SizedBox(height: 24),

                    // Dynamic content based on step
                    Obx(() => _buildDynamicContent(controller)),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom action button
            Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
              child: Obx(() => MainActionButton(
                text: controller.buttonText,
                isEnabled: controller.isButtonEnabled,
                onPressed: () => _handleMainAction(controller),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ChooseEnergyController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Row(
        children: [
          GreenBackButton(onTap: () => controller.goBack()),
          const Spacer(),
          // Progress indicator
          Obx(() => _buildProgressIndicator(controller.currentStep.value)),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(ChooseEnergyStep step) {
    final stepIndex = ChooseEnergyStep.values.indexOf(step);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(ChooseEnergyStep.values.length, (index) {
        final isActive = index <= stepIndex;
        return Container(
          width: isActive ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isActive ? GreenTheme.sageGreen : GreenTheme.borderLight,
          ),
        );
      }),
    );
  }

  Widget _buildDynamicContent(ChooseEnergyController controller) {
    switch (controller.currentStep.value) {
      case ChooseEnergyStep.categorySelection:
        return _buildCategorySelectionContent(controller);
      case ChooseEnergyStep.recommendation:
        return _buildRecommendationContent(controller);
      case ChooseEnergyStep.alternative:
        return _buildAlternativeContent(controller);
      case ChooseEnergyStep.confirmation:
        return _buildConfirmationContent(controller);
    }
  }

  // Step 1: Category Selection
  Widget _buildCategorySelectionContent(ChooseEnergyController controller) {
    return Column(
      children: [
        // Header
        const Text(
          'Pilih Kategori',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: GreenTheme.textDark,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Kategori apa yang ingin kamu kerjakan saat ini?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: GreenTheme.textGrey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),

        // Category Grid
        CategoryGridWidget(
          selectedCategory: controller.selectedCategory.value,
          onCategorySelected: (category) {
            controller.selectCategory(category);
          },
        ),
      ],
    );
  }

  // Step 2: Recommendation
  Widget _buildRecommendationContent(ChooseEnergyController controller) {
    if (controller.recommendedTask.value == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        // Header
        const Text(
          'Rekomendasi untukmu',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: GreenTheme.textDark,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Aku punya saran nih untukmu',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: GreenTheme.textGrey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),

        // Recommendation Card
        RecommendationCard(
          task: controller.recommendedTask.value!,
          onConfirm: () => controller.confirmRecommendedTask(),
          onTryAnother: () => controller.showAlternativeTasks(),
        ),
      ],
    );
  }

  // Step 3: Alternative Task Selection
  Widget _buildAlternativeContent(ChooseEnergyController controller) {
    return Column(
      children: [
        // Header
        const Text(
          'Pilih Tugas Lain',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: GreenTheme.textDark,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Pilih tugas yang sesuai selera kamu',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: GreenTheme.textGrey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),

        // Alternative Task List
        AlternativeTaskList(
          tasks: controller.alternativeTasks,
          selectedTask: controller.selectedAlternativeTask.value,
          onTaskSelected: (task) {
            controller.selectAlternativeTask(task);
          },
        ),
      ],
    );
  }

  // Step 4: Confirmation
  Widget _buildConfirmationContent(ChooseEnergyController controller) {
    if (controller.confirmedTask.value == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const SizedBox(height: 16),

        // Confirmation Card
        ConfirmationCard(
          task: controller.confirmedTask.value!,
          onConfirm: () => controller.proceedToFocusSession(),
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  void _handleMainAction(ChooseEnergyController controller) {
    switch (controller.currentStep.value) {
      case ChooseEnergyStep.categorySelection:
        // Category is already selected, proceed
        break;
      case ChooseEnergyStep.recommendation:
        controller.confirmRecommendedTask();
        break;
      case ChooseEnergyStep.alternative:
        controller.confirmAlternativeTask();
        break;
      case ChooseEnergyStep.confirmation:
        controller.proceedToFocusSession();
        break;
    }
  }
}
