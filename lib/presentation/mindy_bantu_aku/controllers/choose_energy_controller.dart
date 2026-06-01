import 'package:get/get.dart';
import '../models/task_model.dart';
import '../data/task_data.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';

/// Steps dalam alur Choose Energy
enum ChooseEnergyStep {
  categorySelection, // Langkah 1: Pilih Kategori
  recommendation, // Langkah 2: Rekomendasi Otomatis
  alternative, // Langkah 3: Pilih Sendiri / Alternatif
  confirmation, // Langkah 4: Konfirmasi
}

/// State Management untuk Choose Energy
class ChooseEnergyController extends GetxController {
  // Current step
  final Rx<ChooseEnergyStep> currentStep = ChooseEnergyStep.categorySelection.obs;

  // User's energy level (from previous screen)
  late Rx<EnergyLevel> userEnergyLevel;

  // Selected category
  final Rx<TaskCategory?> selectedCategory = Rx<TaskCategory?>(null);

  // Recommended task
  final Rx<TaskModel?> recommendedTask = Rx<TaskModel?>(null);

  // Alternative tasks list
  final RxList<TaskModel> alternativeTasks = <TaskModel>[].obs;

  // Selected task for alternative selection
  final Rx<TaskModel?> selectedAlternativeTask = Rx<TaskModel?>(null);

  // Final confirmed task
  final Rx<TaskModel?> confirmedTask = Rx<TaskModel?>(null);

  // Loading state
  final RxBool isLoading = false.obs;

  // Initialize with energy level from previous screen
  void initializeWithEnergy(EnergyLevel energy) {
    userEnergyLevel = energy.obs;
    resetState();
  }

  // Reset all state
  void resetState() {
    currentStep.value = ChooseEnergyStep.categorySelection;
    selectedCategory.value = null;
    recommendedTask.value = null;
    alternativeTasks.clear();
    selectedAlternativeTask.value = null;
    confirmedTask.value = null;
    isLoading.value = false;
  }

  // Select category and proceed to recommendation
  void selectCategory(TaskCategory category) {
    selectedCategory.value = category;
    _loadRecommendationAndAlternatives();
  }

  // Load recommendation and alternatives based on selected category
  void _loadRecommendationAndAlternatives() {
    isLoading.value = true;

    // Determine if we should skip low-energy recommendation
    // (e.g., if low energy + rumah = "Menulis Jurnal")
    final recommended = TaskData.getRecommendedTask(
      category: selectedCategory.value!,
      energyLevel: userEnergyLevel.value,
    );

    recommendedTask.value = recommended;

    // Get alternatives
    if (recommended != null) {
      final alternatives = TaskData.getAlternativeTasks(
        category: selectedCategory.value!,
        energyLevel: userEnergyLevel.value,
        excludeTaskId: recommended.id,
      );
      alternativeTasks.assignAll(alternatives);
    } else {
      // Fallback: get all tasks matching energy level
      final allMatching = TaskData.getAllTasksByEnergy(userEnergyLevel.value)
          .where((t) => t.category == selectedCategory.value)
          .toList();
      alternativeTasks.assignAll(allMatching);
    }

    isLoading.value = false;
    currentStep.value = ChooseEnergyStep.recommendation;
  }

  // User confirms recommended task
  void confirmRecommendedTask() {
    if (recommendedTask.value != null) {
      confirmedTask.value = recommendedTask.value;
      currentStep.value = ChooseEnergyStep.confirmation;
    }
  }

  // User wants to see alternative tasks
  void showAlternativeTasks() {
    currentStep.value = ChooseEnergyStep.alternative;
  }

  // User selects an alternative task
  void selectAlternativeTask(TaskModel task) {
    selectedAlternativeTask.value = task;
  }

  // User confirms alternative selection
  void confirmAlternativeTask() {
    if (selectedAlternativeTask.value != null) {
      confirmedTask.value = selectedAlternativeTask.value;
      currentStep.value = ChooseEnergyStep.confirmation;
    }
  }

  // Go back to previous step
  void goBack() {
    switch (currentStep.value) {
      case ChooseEnergyStep.categorySelection:
        Get.back();
        break;
      case ChooseEnergyStep.recommendation:
        currentStep.value = ChooseEnergyStep.categorySelection;
        selectedCategory.value = null;
        break;
      case ChooseEnergyStep.alternative:
        currentStep.value = ChooseEnergyStep.recommendation;
        selectedAlternativeTask.value = null;
        break;
      case ChooseEnergyStep.confirmation:
        currentStep.value = ChooseEnergyStep.recommendation;
        confirmedTask.value = null;
        break;
    }
  }

  // Navigate to timer screen
  void proceedToFocusSession() {
    if (confirmedTask.value != null) {
      Get.toNamed(AppRoutes.timer, arguments: {
        'task': confirmedTask.value,
        'energy': userEnergyLevel.value.value,
      });
    }
  }

  // Get header text for current step
  String get headerTitle {
    switch (currentStep.value) {
      case ChooseEnergyStep.categorySelection:
        return 'Pilih Kategori';
      case ChooseEnergyStep.recommendation:
        return 'Rekomendasi untukmu';
      case ChooseEnergyStep.alternative:
        return 'Pilih Tugas Lain';
      case ChooseEnergyStep.confirmation:
        return 'Yuk Mulai!';
    }
  }

  String get headerSubtitle {
    switch (currentStep.value) {
      case ChooseEnergyStep.categorySelection:
        return 'Kategori apa yang ingin kamu kerjakan saat ini?';
      case ChooseEnergyStep.recommendation:
        return 'Aku punya saran nih untukmu';
      case ChooseEnergyStep.alternative:
        return 'Pilih tugas yang sesuai selera kamu';
      case ChooseEnergyStep.confirmation:
        return 'Kamu siap fokus dengan tugas ini!';
    }
  }

  // Get button text for current step
  String get buttonText {
    switch (currentStep.value) {
      case ChooseEnergyStep.categorySelection:
        return selectedCategory.value != null ? 'Lanjut' : 'Pilih Kategori';
      case ChooseEnergyStep.recommendation:
        return 'Aku siap fokus!';
      case ChooseEnergyStep.alternative:
        return 'Yay, Lanjut Fokus!';
      case ChooseEnergyStep.confirmation:
        return 'Yay, Lanjut Fokus!';
    }
  }

  // Check if button should be enabled
  bool get isButtonEnabled {
    switch (currentStep.value) {
      case ChooseEnergyStep.categorySelection:
        return selectedCategory.value != null;
      case ChooseEnergyStep.recommendation:
        return recommendedTask.value != null;
      case ChooseEnergyStep.alternative:
        return selectedAlternativeTask.value != null;
      case ChooseEnergyStep.confirmation:
        return confirmedTask.value != null;
    }
  }

  // Check if show "Try Another" button
  bool get showTryAnotherButton => currentStep.value == ChooseEnergyStep.recommendation && (alternativeTasks.isNotEmpty);

  // Check if show back button
  bool get showBackButton => currentStep.value != ChooseEnergyStep.categorySelection;
}
