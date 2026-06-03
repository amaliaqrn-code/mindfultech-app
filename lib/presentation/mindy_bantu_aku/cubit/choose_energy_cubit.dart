import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task_model.dart';
import '../data/task_data.dart';
import 'choose_energy_state.dart';

class ChooseEnergyCubit extends Cubit<ChooseEnergyState> {
  ChooseEnergyCubit({required EnergyLevel energy})
      : super(ChooseEnergyState.initial(energy));

  void initializeWithEnergy(EnergyLevel energy) {
    emit(ChooseEnergyState.initial(energy));
  }

  void selectCategory(TaskCategory category) {
    emit(state.copyWith(selectedCategory: () => category));
  }

  // Dipicu saat menekan tombol "Lanjut" di halaman kategori (Layar 2 ke Layar 3)
  void proceedToTaskSelection() {
    if (state.selectedCategory == null) return;

    // Ambil rekomendasi otomatis bawaan dari data source
    final recommended = TaskData.getRecommendedTask(
      category: state.selectedCategory!,
      energyLevel: state.userEnergyLevel,
    );

    // Ambil seluruh tugas di kategori tersebut sebagai opsi alternatif
    final allTasks = TaskData.getAlternativeTasks(
      category: state.selectedCategory!,
      energyLevel: state.userEnergyLevel,
      excludeTaskId: null, // dapatkan semua item
    );

    emit(state.copyWith(
      currentStep: ChooseEnergyStep.taskSelection,
      selectedTask: () => recommended, // Secara default otomatis merekomendasikan 1 tugas (Layar 3)
      availableTasks: allTasks,
      isShowingAlternativeList: false,
    ));
  }

  // Dipicu saat klik tombol "Coba tugas lain" (Layar 3 ke Layar 4)
  void switchToAlternativeList() {
    emit(state.copyWith(
      isShowingAlternativeList: true,
      selectedTask: () => null, // Reset pilihan agar user harus memilih dari list radio button (Layar 4)
    ));
  }

  // Dipicu saat user memilih salah satu item di list alternatif (Layar 4 ke Layar 5)
  void selectAlternativeTask(TaskModel task) {
    emit(state.copyWith(selectedTask: () => task));
  }

  // Dipicu saat klik "Lanjut" dari pemilihan alternatif untuk konfirmasi akhir (Layar 5 ke Layar 6)
  void confirmAlternativeSelection() {
    if (state.selectedTask != null) {
      emit(state.copyWith(
        isShowingAlternativeList: false, // Menutup list, kembali ke mode visual kartu tunggal
      ));
    }
  }

  // Fungsi tombol Back fisik/top bar agar tidak merusak alur state
  bool goBack() {
    if (state.currentStep == ChooseEnergyStep.categorySelection) {
      return true; // Keluar dari screen (pop screen)
    } else {
      if (state.isShowingAlternativeList) {
        // Dari daftar opsi list kembali ke tampilan rekomendasi tunggal awal
        final recommended = TaskData.getRecommendedTask(
          category: state.selectedCategory!,
          energyLevel: state.userEnergyLevel,
        );
        emit(state.copyWith(
          isShowingAlternativeList: false,
          selectedTask: () => recommended,
        ));
      } else {
        // Kembali ke menu awal pemilihan grid kategori
        emit(state.copyWith(
          currentStep: ChooseEnergyStep.categorySelection,
          selectedTask: () => null,
          isShowingAlternativeList: false,
        ));
      }
      return false; // Jangan pop screen dahulu
    }
  }
}