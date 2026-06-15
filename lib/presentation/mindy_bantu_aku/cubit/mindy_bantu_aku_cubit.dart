import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/core/database/database_helper.dart';
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
  // FALLBACK - DefaultTaskHelper ketika DB kosong
  // ============================================================

  List<TaskModel> _createFallbackTasks(EnergyLevel energyLevel, {TaskCategory? category}) {
    if (category != null) {
      return [DefaultTaskHelper.createDefaultTask(energi: energyLevel, kategori: category)];
    }
    return TaskCategory.values.map((cat) =>
      DefaultTaskHelper.createDefaultTask(energi: energyLevel, kategori: cat)
    ).toList();
  }

  /// Simpan fallback task ke DB supaya muncul di kueri berikutnya
  Future<void> _saveFallbackTask(TaskModel task) async {
    try {
      final db = DatabaseHelper();
      final userId = _taskRepository.getUserId();
      if (userId == null) return;
      final saved = task.copyWith(id: DateTime.now().millisecondsSinceEpoch, userId: userId);
      await db.insertTask(saved);
    } catch (_) {}
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
      var tasks = await _taskRepository.getRecommendedTasks(energyLevel);

      if (tasks.isEmpty) {
        tasks = _createFallbackTasks(energyLevel);
        for (final t in tasks) {
          await _saveFallbackTask(t);
        }
      }

      emit(state.copyWith(
        status: MindyBantuAkuStatus.success,
        recommendedTasks: tasks,
        primaryRecommendation: tasks.firstOrNull,
      ));
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
      var tasks = await _taskRepository.getRecommendedTasksByCategory(
        state.selectedEnergyLevel!,
        category,
      );

      if (tasks.isEmpty) {
        tasks = _createFallbackTasks(state.selectedEnergyLevel!, category: category);
        for (final t in tasks) {
          await _saveFallbackTask(t);
        }
      }

      emit(state.copyWith(
        status: MindyBantuAkuStatus.success,
        recommendedTasks: tasks,
        primaryRecommendation: tasks.firstOrNull,
      ));
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
      selectedCategory: category,
      clearError: true,
    ));

    try {
      var tasks = <TaskModel>[];
      
      if (category != null) {
        tasks = await _taskRepository.getRecommendedTasksByCategory(energyLevel, category);
      } else {
        tasks = await _taskRepository.getRecommendedTasks(energyLevel);
      }

      if (tasks.isEmpty) {
        tasks = _createFallbackTasks(energyLevel, category: category);
        for (final t in tasks) {
          await _saveFallbackTask(t);
        }
      }

      emit(state.copyWith(
        status: MindyBantuAkuStatus.success,
        recommendedTasks: tasks,
        primaryRecommendation: tasks.firstOrNull,
      ));
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

  /// Helper untuk mendapatkan semua task berdasarkan energi dan kategori
  Future<List<TaskModel>> getTasksByEnergy(EnergyLevel energyLevel, {TaskCategory? category}) async {
    try {
      var tasks = category != null
          ? await _taskRepository.getRecommendedTasksByCategory(energyLevel, category)
          : await _taskRepository.getRecommendedTasks(energyLevel);

      if (tasks.isEmpty) {
        tasks = _createFallbackTasks(energyLevel, category: category);
        for (final t in tasks) {
          await _saveFallbackTask(t);
        }
      }
      return tasks;
    } catch (e) {
      return [];
    }
  }
}