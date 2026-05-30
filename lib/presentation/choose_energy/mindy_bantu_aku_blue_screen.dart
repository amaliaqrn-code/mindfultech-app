import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/task_model.dart';
import 'controllers/choose_energy_controller.dart';
import 'widgets/blue_mascot_widget.dart';
import 'widgets/blue_category_grid_widget.dart';
import 'widgets/blue_recommendation_card.dart';
import 'widgets/blue_alternative_task_list.dart';
import 'widgets/blue_confirmation_card.dart';
import 'widgets/blue_action_button.dart';
import 'theme/blue_theme.dart';

/// Layar "Mindy Bantu Aku - Energi Sedang" dengan Blue Theme
class MindyBantuAkuBlueScreen extends StatelessWidget {
  const MindyBantuAkuBlueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(ChooseEnergyController());

    // Get energy level from arguments (medium = 1)
    final args = Get.arguments;
    if (args != null && args['energy'] != null) {
      final energyValue = args['energy'] as int;
      final energy = EnergyLevelExtension.fromValue(energyValue);
      controller.initializeWithEnergy(energy);
    } else {
      // Default to medium energy if not specified
      controller.initializeWithEnergy(EnergyLevel.medium);
    }

    return Scaffold(
      backgroundColor: BlueTheme.backgroundPage,
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

                    // Blue Mascot with stars
                    const BlueMascotWidget(size: 100),
                    const SizedBox(height: 24),

                    // Dynamic content based on step
                    Obx(() => _buildDynamicContent(controller)),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom action button with gradient
            Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
              child: Obx(() => _buildActionButton(controller)),
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
          BlueBackButton(onTap: () => controller.goBack()),
          const Spacer(),
          // Progress indicator (blue)
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
            color: isActive ? BlueTheme.primaryBlue : BlueTheme.borderLight,
          ),
        );
      }),
    );
  }

  Widget _buildActionButton(ChooseEnergyController controller) {
    final step = controller.currentStep.value;
    String text;
    bool useGradient = true;

    switch (step) {
      case ChooseEnergyStep.categorySelection:
        text = 'Lanjut';
        useGradient = true;
        break;
      case ChooseEnergyStep.recommendation:
        text = 'Aku siap fokus!';
        useGradient = false; // Solid blue for this step
        break;
      case ChooseEnergyStep.alternative:
        text = 'Yay, Lanjut Fokus!';
        useGradient = true;
        break;
      case ChooseEnergyStep.confirmation:
        text = 'Yay, Lanjut Fokus!';
        useGradient = true;
        break;
    }

    return BlueMainActionButton(
      text: text,
      isEnabled: controller.isButtonEnabled,
      onPressed: () => _handleMainAction(controller),
      useGradient: useGradient,
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
            color: BlueTheme.textDark,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Kategori apa yang ingin kamu kerjakan saat ini?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: BlueTheme.textGrey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),

        // Category Grid
        BlueCategoryGridWidget(
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
            color: BlueTheme.textDark,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Aku punya saran nih untukmu',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: BlueTheme.textGrey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),

        // Recommendation Card
        BlueRecommendationCard(
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
            color: BlueTheme.textDark,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Pilih tugas yang sesuai selera kamu',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: BlueTheme.textGrey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),

        // Alternative Task List
        BlueAlternativeTaskList(
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
        BlueConfirmationCard(
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