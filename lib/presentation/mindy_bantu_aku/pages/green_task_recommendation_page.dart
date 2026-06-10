import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/theme/green_theme.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/widgets/green_recommendation_card.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/cubit/mindy_bantu_aku_cubit.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/cubit/mindy_bantu_aku_state.dart';

/// ============================================================
/// GREEN TASK RECOMMENDATION SCREEN
/// Halaman setelah memilih kategori - menampilkan rekomendasi Mindy
/// ============================================================

class GreenTaskRecommendationPage extends StatefulWidget {
  final TaskCategory? selectedCategory;
  final EnergyLevel? energyLevel;

  const GreenTaskRecommendationPage({
    super.key,
    this.selectedCategory,
    this.energyLevel,
  });

  @override
  State<GreenTaskRecommendationPage> createState() =>
      _GreenTaskRecommendationPageState();
}

class _GreenTaskRecommendationPageState
    extends State<GreenTaskRecommendationPage> {
  @override
  void initState() {
    super.initState();
    // Fetch rekomendasi berdasarkan energi yang dipilih user
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<MindyBantuAkuCubit>();
      // Gunakan argumen energyLevel dari halaman sebelumnya, atau default ke rendah
      final energyLevel = widget.energyLevel ?? EnergyLevel.rendah;

      if (widget.selectedCategory != null) {
        cubit.selectCategory(widget.selectedCategory!);
      } else {
        cubit.selectEnergyLevel(energyLevel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GreenTheme.backgroundPage,
      body: SafeArea(
        child: BlocBuilder<MindyBantuAkuCubit, MindyBantuAkuState>(
          builder: (context, state) {
            return Column(
              children: [
                // Header with back button
                _buildHeader(context, state),

                // Content
                Expanded(
                  child: _buildContent(context, state),
                ),

                // Bottom decoration
                _buildBottomDecoration(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MindyBantuAkuState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: GreenTheme.borderMedium,
                  width: 2,
                ),
                color: GreenTheme.backgroundWhite,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: GreenTheme.sageGreen,
                size: 18,
              ),
            ),
          ),
          const Spacer(),
          // Progress indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: GreenTheme.sageGreenLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  state.hasSelectedCategory
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: GreenTheme.sageGreen,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  state.hasSelectedCategory ? 'Kategori dipilih' : 'Energi dipilih',
                  style: const TextStyle(
                    fontSize: 12,
                    color: GreenTheme.sageGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, MindyBantuAkuState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: GreenTheme.sageGreen,
        ),
      );
    }

    if (state.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: GreenTheme.textGrey,
            ),
            const SizedBox(height: 16),
            Text(
              state.errorMessage ?? 'Terjadi kesalahan',
              style: const TextStyle(
                color: GreenTheme.textGrey,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                context.read<MindyBantuAkuCubit>().selectEnergyLevel(EnergyLevel.rendah);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: GreenTheme.sageGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Coba Lagi',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (state.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.inbox_rounded,
                size: 64,
                color: GreenTheme.sageGreen,
              ),
              const SizedBox(height: 16),
              const Text(
                'Belum ada tugas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: GreenTheme.textDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Yuk buat tugas baru yang sesuai\ndengan energimu!',
                style: TextStyle(
                  fontSize: 14,
                  color: GreenTheme.textGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.createCustomTask);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: GreenTheme.primaryButtonGradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: GreenTheme.sageGreen.withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Buat Tugas Baru',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Success state - tampilkan rekomendasi
    final recommendedTask = state.primaryRecommendation ?? state.recommendedTasks.first;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Title
          const Text(
            'Mindy memilihkan\ntugas untukmu',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: GreenTheme.textDark,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),

          // Subtitle
          const Text(
            'Berdasarkan energimu hari ini dan kategori\nyang kamu pilih, ini lah rekomendasi kegiatan\nterbaik buat kamu',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: GreenTheme.textGrey,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),

          // Stack untuk overlap mascot dan card
          Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              // Card di belakang (offset ke atas agar mascot masuk)
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: GreenRecommendationCard(
                  task: recommendedTask,
                  onConfirm: () {
                    Navigator.pushNamed(context, AppRoutes.timer);
                  },
                  onTryAnother: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.greenAlternativeTaskList,
                      arguments: {
                        'category': state.selectedCategory ?? widget.selectedCategory,
                        'excludeTaskId': recommendedTask.id,
                        'energyLevel': widget.energyLevel ?? EnergyLevel.rendah,
                      },
                    );
                  },
                ),
              ),
              // Mascot di depan, overlap ke card
              Positioned(
                top: -20,
                child: _buildMascotImage(),
              ),
            ],
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildBottomDecoration() {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: GreenTheme.backgroundWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: GreenTheme.shadowColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: GreenTheme.borderLight,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildMascotImage() {
    return Image.asset(
      'assets/images/energirendah/energi_rendah_rekomendasi.png',
      width: 180,
      height: 120,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 180,
          height: 120,
          decoration: BoxDecoration(
            color: GreenTheme.sageGreenLight,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text(
              '😴',
              style: TextStyle(fontSize: 50),
            ),
          ),
        );
      },
    );
  }
}