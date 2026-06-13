import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/data/repositories/task_repository.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import 'mindy_bantu_aku_state.dart';

/// Cubit untuk mengelola fitur "Mindy Bantu Aku"
/// Memberikan rekomendasi tugas berdasarkan level energi user
/// Mendukung Multi-User Isolation
class MindyBantuAkuCubit extends Cubit<MindyBantuAkuState> {
  final TaskRepository _taskRepository;

  MindyBantuAkuCubit({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(MindyBantuAkuState.initial());

  // ============================================================
  // INITIALIZATION - Seed default tasks saat pertama kali dibuka
  // ============================================================

  /// Initialize dan seed default tasks jika needed
  Future<void> initialize() async {
    await _taskRepository.seedDefaultTasksIfNeeded();
  }

  // ============================================================
  // SET ENERGY LEVEL - Pilih level energi user
  // ============================================================

  /// Set level energi yang dipilih user dan fetch rekomendasi
  Future<void> selectEnergyLevel(EnergyLevel energyLevel) async {
    emit(state.copyWith(
      status: MindyBantuAkuStatus.loading,
      selectedEnergyLevel: energyLevel,
      clearCategory: true,
      clearError: true,
    ));

    try {
      final tasks = await _taskRepository.getRecommendedTasks(energyLevel);

      if (tasks.isEmpty) {
        emit(state.copyWith(
          status: MindyBantuAkuStatus.empty,
          recommendedTasks: [],
          primaryRecommendation: null,
        ));
      } else {
        emit(state.copyWith(
          status: MindyBantuAkuStatus.success,
          recommendedTasks: tasks,
          primaryRecommendation: tasks.firstOrNull,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: MindyBantuAkuStatus.failure,
        errorMessage: 'Gagal memuat rekomendasi: ${e.toString()}',
      ));
    }
  }

  // ============================================================
  // SET CATEGORY - Pilih kategori tugas
  // ============================================================

  /// Set kategori yang dipilih user dan fetch rekomendasi spesifik
  Future<void> selectCategory(TaskCategory category) async {
    if (state.selectedEnergyLevel == null) return;

    emit(state.copyWith(
      status: MindyBantuAkuStatus.loading,
      selectedCategory: category,
      clearError: true,
    ));

    try {
      final tasks = await _taskRepository.getRecommendedTasksByCategory(
        state.selectedEnergyLevel!,
        category,
      );

      if (tasks.isEmpty) {
        emit(state.copyWith(
          status: MindyBantuAkuStatus.empty,
          recommendedTasks: [],
          primaryRecommendation: null,
        ));
      } else {
        emit(state.copyWith(
          status: MindyBantuAkuStatus.success,
          recommendedTasks: tasks,
          primaryRecommendation: tasks.firstOrNull,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: MindyBantuAkuStatus.failure,
        errorMessage: 'Gagal memuat rekomendasi: ${e.toString()}',
      ));
    }
  }

  // ============================================================
// INITIAL FETCH - Untuk Halaman Rekomendasi
// ============================================================

/// Mengambil rekomendasi berdasarkan Energi DAN Kategori sekaligus tanpa konflik state
Future<void> fetchInitialRecommendations({
  required EnergyLevel energyLevel,
  TaskCategory? category,
}) async {
  emit(state.copyWith(
    status: MindyBantuAkuStatus.loading,
    selectedEnergyLevel: energyLevel,
    selectedCategory: category, // Langsung pasang jika ada, tidak di-clear
    clearError: true,
  ));

  try {
    List<TaskModel> tasks;
    
    // Jika ada kategori, cari spesifik. Jika tidak, cari berdasarkan energi saja.
    if (category != null) {
      tasks = await _taskRepository.getRecommendedTasksByCategory(energyLevel, category);
    } else {
      tasks = await _taskRepository.getRecommendedTasks(energyLevel);
    }

    if (tasks.isEmpty) {
      emit(state.copyWith(
        status: MindyBantuAkuStatus.empty,
        recommendedTasks: [],
        primaryRecommendation: null,
      ));
    } else {
      emit(state.copyWith(
        status: MindyBantuAkuStatus.success,
        recommendedTasks: tasks,
        primaryRecommendation: tasks.firstOrNull,
      ));
    }
  } catch (e) {
    emit(state.copyWith(
      status: MindyBantuAkuStatus.failure,
      errorMessage: 'Gagal memuat rekomendasi: ${e.toString()}',
    ));
  }
}

  // ============================================================
  // SELECT RECOMMENDATION - Pilih tugas dari daftar
  // ============================================================

  /// Pilih tugas dari daftar alternatif sebagai rekomendasi utama
  void selectRecommendation(TaskModel task) {
    final updatedList = [
      task,
      ...state.recommendedTasks.where((t) => t.id != task.id),
    ];

    emit(state.copyWith(
      primaryRecommendation: task,
      recommendedTasks: updatedList,
    ));
  }

  // ============================================================
  // RESET - Kembali ke state awal
  // ============================================================

  /// Reset semua state ke awal
  void reset() {
    emit(MindyBantuAkuState.initial());
  }

  // ============================================================
  // GET TASKS BY ENERGY - Helper untuk UI
  // ============================================================

  /// Helper untuk mendapatkan semua task berdasarkan energi
  /// (tanpa filter kategori) - untuk halaman alternatif
  Future<List<TaskModel>> getTasksByEnergy(EnergyLevel energyLevel) async {
    try {
      return await _taskRepository.getRecommendedTasks(energyLevel);
    } catch (e) {
      return [];
    }
  }
}