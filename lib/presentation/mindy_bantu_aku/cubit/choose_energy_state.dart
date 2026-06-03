import 'package:equatable/equatable.dart';
import '../models/task_model.dart';

// Disesuaikan dengan visual 2 tahapan pada gambar desain
enum ChooseEnergyStep {
  categorySelection, // Langkah 1: Pilih Kategori (Layar 1 & 2)
  taskSelection,     // Langkah 2: Rekomendasi & Pilih Tugas Lain (Layar 3, 4, 5, 6)
}

class ChooseEnergyState extends Equatable {
  final ChooseEnergyStep currentStep;
  final EnergyLevel userEnergyLevel;
  final TaskCategory? selectedCategory;
  final TaskModel? selectedTask; // Menggabungkan rekomendasi dan pilihan alternatif
  final List<TaskModel> availableTasks;
  final bool isShowingAlternativeList; // Flag untuk tombol "Coba tugas lain" / "Pilih Tugas Lain"

  const ChooseEnergyState({
    required this.currentStep,
    required this.userEnergyLevel,
    this.selectedCategory,
    this.selectedTask,
    required this.availableTasks,
    required this.isShowingAlternativeList,
  });

  factory ChooseEnergyState.initial(EnergyLevel energy) {
    return ChooseEnergyState(
      currentStep: ChooseEnergyStep.categorySelection,
      userEnergyLevel: energy,
      selectedCategory: null,
      selectedTask: null,
      availableTasks: const [],
      isShowingAlternativeList: false,
    );
  }

  ChooseEnergyState copyWith({
    ChooseEnergyStep? currentStep,
    EnergyLevel? userEnergyLevel,
    TaskCategory? Function()? selectedCategory,
    TaskModel? Function()? selectedTask,
    List<TaskModel>? availableTasks,
    bool? isShowingAlternativeList,
  }) {
    return ChooseEnergyState(
      currentStep: currentStep ?? this.currentStep,
      userEnergyLevel: userEnergyLevel ?? this.userEnergyLevel,
      selectedCategory: selectedCategory != null ? selectedCategory() : this.selectedCategory,
      selectedTask: selectedTask != null ? selectedTask() : this.selectedTask,
      availableTasks: availableTasks ?? this.availableTasks,
      isShowingAlternativeList: isShowingAlternativeList ?? this.isShowingAlternativeList,
    );
  }

  // Teks Header dinamis yang menyesuaikan 6 layar pada gambar
  String get headerTitle {
    if (currentStep == ChooseEnergyStep.categorySelection) {
      return 'Mau fokus\nkategori apa?';
    } else {
      if (isShowingAlternativeList) {
        return 'Pilih Tugas Lain';
      } else {
        return selectedTask != null ? 'Tugas Dipilih' : 'Mindy memilihkan\ntugas untukmu';
      }
    }
  }

  String get headerSubtitle {
    if (currentStep == ChooseEnergyStep.categorySelection) {
      return 'Pilih kategori agar Mindy bisa\nmembantumu memilih tugas terbaik';
    } else {
      if (isShowingAlternativeList) {
        return 'Mindy sudah menyiapkan beberapa opsi\nkegiatan untukmu';
      } else {
        return selectedTask != null 
            ? 'Aktivitas yang kamu pilih untuk menemani\nfokus hari ini'
            : 'Berdasarkan energimu hari ini, ini rekomendasi kegiatan\nterbaik buat kamu';
      }
    }
  }

  // Teks Tombol Bawah dinamis sesuai teks hijau di gambar
  String get buttonText {
    if (currentStep == ChooseEnergyStep.categorySelection) {
      return 'Lanjut';
    } else {
      if (isShowingAlternativeList) {
        return 'Lanjut';
      } else {
        return selectedTask != null ? 'Yay, Lanjut Fokus!' : 'Aku siap fokus!';
      }
    }
  }

  bool get isButtonEnabled {
    if (currentStep == ChooseEnergyStep.categorySelection) {
      return selectedCategory != null;
    } else {
      return selectedTask != null;
    }
  }

  @override
  List<Object?> get props => [
        currentStep,
        userEnergyLevel,
        selectedCategory,
        selectedTask,
        availableTasks,
        isShowingAlternativeList,
      ];
}