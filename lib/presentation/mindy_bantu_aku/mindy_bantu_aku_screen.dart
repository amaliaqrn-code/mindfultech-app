import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/task_model.dart';
import 'cubit/choose_energy_cubit.dart';
import 'cubit/choose_energy_state.dart';
import 'widgets/mascot_widget.dart';
import 'widgets/category_grid_widget.dart';
import 'widgets/recommendation_card.dart';
import 'widgets/alternative_task_list.dart';
import 'widgets/main_action_button.dart';
import 'theme/green_theme.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';

// Catatan: Jika GreenBackButton belum didefinisikan, kamu bisa membuat widget kustom 
// atau menggunakan IconButton standar di dalam proyekmu.
class GreenBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const GreenBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GreenTheme.textDark),
      onPressed: onTap,
    );
  }
}

/// Layar "Mindy Bantu Aku" - Sistem Filter & Rekomendasi Tugas
/// Menggunakan nuansa hijau (Sage Green theme)
class MindyBantuAkuScreen extends StatelessWidget {
  const MindyBantuAkuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GreenTheme.backgroundPage,
      body: SafeArea(
        child: Column(
          children: [
            // Header dengan tombol back dan progress indicator dinamis
            _buildHeader(context),

            // Konten Utama (Scrollable)
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),

                    // Maskot Animasi/Gambar Mindy
                    const MascotWidget(size: 100),
                    const SizedBox(height: 24),

                    // Konten Dinamis Berdasarkan State Cubit yang Baru
                    BlocBuilder<ChooseEnergyCubit, ChooseEnergyState>(
                      builder: (context, state) => _buildDynamicContent(context, state),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Tombol Aksi di Bagian Bawah (Bottom Button)
            Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
              child: BlocBuilder<ChooseEnergyCubit, ChooseEnergyState>(
                builder: (context, state) => MainActionButton(
                  text: state.buttonText,
                  isEnabled: state.isButtonEnabled,
                  onPressed: () => _handleMainAction(context, state),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Row(
        children: [
          GreenBackButton(onTap: () {
            final shouldPop = context.read<ChooseEnergyCubit>().goBack();
            if (shouldPop) {
              Navigator.pop(context);
            }
          }),
          const Spacer(),
          // Progress indicator menyesuaikan 2-langkah utama
          BlocBuilder<ChooseEnergyCubit, ChooseEnergyState>(
            builder: (context, state) => _buildProgressIndicator(state.currentStep),
          ),
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

  Widget _buildDynamicContent(BuildContext context, ChooseEnergyState state) {
    switch (state.currentStep) {
      case ChooseEnergyStep.categorySelection:
        return _buildCategorySelectionContent(context, state);
      case ChooseEnergyStep.taskSelection:
        // Jika sedang memicu alternatif list, render list tugas pilihan lain
        if (state.isShowingAlternativeList) {
          return _buildAlternativeContent(context, state);
        }
        // Jika tidak, render kartu rekomendasi tunggal (Baik rekomendasi otomatis awal / konfirmasi tugas)
        return _buildTaskContent(context, state);
    }
  }

  // Langkah 1: Tampilan Pilih Kategori
  Widget _buildCategorySelectionContent(BuildContext context, ChooseEnergyState state) {
    return Column(
      children: [
        Text(
          state.headerTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: GreenTheme.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          state.headerSubtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            color: GreenTheme.textGrey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),

        // Grid Kategori Tugas
        CategoryGridWidget(
          selectedCategory: state.selectedCategory,
          onCategorySelected: (category) {
            context.read<ChooseEnergyCubit>().selectCategory(category);
          },
        ),
      ],
    );
  }

  // Langkah 2: Tampilan Rekomendasi Tugas Terpilih (Satu Kartu Utama)
  Widget _buildTaskContent(BuildContext context, ChooseEnergyState state) {
    if (state.selectedTask == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Text(
          state.headerTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: GreenTheme.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          state.headerSubtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            color: GreenTheme.textGrey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),

        // Menggunakan RecommendationCard bawaan untuk render tugas tunggal
        RecommendationCard(
          task: state.selectedTask!,
          onConfirm: () => _proceedToFocusSession(context, state.selectedTask!, state.userEnergyLevel),
          onTryAnother: () => context.read<ChooseEnergyCubit>().switchToAlternativeList(),
        ),
      ],
    );
  }

  // Langkah 2 Alternatif: Tampilan Daftar List Tugas Lain (Opsi Pengganti)
  Widget _buildAlternativeContent(BuildContext context, ChooseEnergyState state) {
    return Column(
      children: [
        Text(
          state.headerTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: GreenTheme.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          state.headerSubtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            color: GreenTheme.textGrey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),

        // List Radio Opsi Alternatif
        AlternativeTaskList(
          tasks: state.availableTasks,
          selectedTask: state.selectedTask,
          onTaskSelected: (task) {
            context.read<ChooseEnergyCubit>().selectAlternativeTask(task);
          },
        ),
      ],
    );
  }

  void _proceedToFocusSession(BuildContext context, TaskModel task, EnergyLevel energyLevel) {
    Navigator.pushNamed(context, AppRoutes.timer, arguments: {
      'taskName': task.title,
      'energy': energyLevel.value,
    });
  }

  // Manajemen Aksi Tombol Bawah Hijau agar Sesuai Alur 2 Langkah Desain
  void _handleMainAction(BuildContext context, ChooseEnergyState state) {
    final cubit = context.read<ChooseEnergyCubit>();
    
    switch (state.currentStep) {
      case ChooseEnergyStep.categorySelection:
        // Pindah dari halaman kategori ke halaman rekomendasi otomatis
        cubit.proceedToTaskSelection();
        break;
        
      case ChooseEnergyStep.taskSelection:
        if (state.isShowingAlternativeList) {
          // Jika di dalam list alternatif, konfirmasi pilihan lalu kunci kembali ke mode kartu tunggal
          cubit.confirmAlternativeSelection();
        } else {
          // Jika sudah mantap di kartu tunggal, langsung arahkan navigasi ke halaman Timer
          if (state.selectedTask != null) {
            _proceedToFocusSession(context, state.selectedTask!, state.userEnergyLevel);
          }
        }
        break;
    }
  }
}