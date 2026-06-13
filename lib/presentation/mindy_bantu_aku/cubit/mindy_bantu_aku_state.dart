import 'package:equatable/equatable.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';

/// Status untuk operasi Mindy Bantu Aku
enum MindyBantuAkuStatus { initial, loading, success, empty, failure }

/// State untuk MindyBantuAkuCubit
/// Mengelola state untuk fitur rekomendasi tugas berdasarkan energi
class MindyBantuAkuState extends Equatable {
  final MindyBantuAkuStatus status;
  final EnergyLevel? selectedEnergyLevel;
  final TaskCategory? selectedCategory;
  final List<TaskModel> recommendedTasks;
  final TaskModel? primaryRecommendation;
  final String? errorMessage;

  const MindyBantuAkuState({
    this.status = MindyBantuAkuStatus.initial,
    this.selectedEnergyLevel,
    this.selectedCategory,
    this.recommendedTasks = const [],
    this.primaryRecommendation,
    this.errorMessage,
  });

  /// State awal/default
  factory MindyBantuAkuState.initial() => const MindyBantuAkuState();

  /// Apakah sedang memuat data
  bool get isLoading => status == MindyBantuAkuStatus.loading;

  /// Apakah tidak ada task yang direkomendasikan
  bool get isEmpty => status == MindyBantuAkuStatus.empty;

  /// Apakah ada error
  bool get hasError => status == MindyBantuAkuStatus.failure;

  /// Apakah data berhasil dimuat
  bool get isLoaded => status == MindyBantuAkuStatus.success;

  /// Apakah user sudah memilih level energi
  bool get hasSelectedEnergy => selectedEnergyLevel != null;

  /// Apakah user sudah memilih kategori
  bool get hasSelectedCategory => selectedCategory != null;

  /// Jumlah task yang direkomendasikan
  int get recommendationCount => recommendedTasks.length;

  /// Salinan state dengan data yang diperbarui
  MindyBantuAkuState copyWith({
    MindyBantuAkuStatus? status,
    EnergyLevel? selectedEnergyLevel,
    TaskCategory? selectedCategory,
    List<TaskModel>? recommendedTasks,
    TaskModel? primaryRecommendation,
    String? errorMessage,
    bool clearEnergyLevel = false,
    bool clearCategory = false,
    bool clearError = false,
  }) {
    return MindyBantuAkuState(
      status: status ?? this.status,
      selectedEnergyLevel: clearEnergyLevel ? null : (selectedEnergyLevel ?? this.selectedEnergyLevel),
      selectedCategory: clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      recommendedTasks: recommendedTasks ?? this.recommendedTasks,
      primaryRecommendation: primaryRecommendation ?? this.primaryRecommendation,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedEnergyLevel,
        selectedCategory,
        recommendedTasks,
        primaryRecommendation,
        errorMessage,
      ];
}