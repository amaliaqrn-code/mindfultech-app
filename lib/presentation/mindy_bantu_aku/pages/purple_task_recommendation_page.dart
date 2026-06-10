import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/theme/purple_theme.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/widgets/purple_recommendation_card.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/cubit/mindy_bantu_aku_cubit.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/cubit/mindy_bantu_aku_state.dart';

/// ============================================================
/// PURPLE TASK RECOMMENDATION SCREEN
/// Halaman setelah memilih kategori - menampilkan rekomendasi Mindy
/// ============================================================

class PurpleTaskRecommendationPage extends StatefulWidget {
  final TaskCategory? selectedCategory;
  final EnergyLevel? energyLevel;

  const PurpleTaskRecommendationPage({
    super.key,
    this.selectedCategory,
    this.energyLevel,
  });

  @override
  State<PurpleTaskRecommendationPage> createState() =>
      _PurpleTaskRecommendationPageState();
}

class _PurpleTaskRecommendationPageState
    extends State<PurpleTaskRecommendationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<MindyBantuAkuCubit>();
      // Gunakan argumen energyLevel dari halaman sebelumnya, atau default ke tinggi
      final energyLevel = widget.energyLevel ?? EnergyLevel.tinggi;

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
      backgroundColor: PurpleTheme.backgroundPage,
      body: SafeArea(
        child: BlocBuilder<MindyBantuAkuCubit, MindyBantuAkuState>(
          builder: (context, state) {
            return Column(
              children: [
                _buildHeader(context, state),
                Expanded(child: _buildContent(context, state)),
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
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: PurpleTheme.borderMedium, width: 2),
                color: PurpleTheme.backgroundWhite,
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: PurpleTheme.primaryPurple, size: 18),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: PurpleTheme.primaryPurplePale,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  state.hasSelectedCategory ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: PurpleTheme.primaryPurple,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  state.hasSelectedCategory ? 'Kategori dipilih' : 'Energi dipilih',
                  style: const TextStyle(fontSize: 12, color: PurpleTheme.primaryPurple, fontWeight: FontWeight.w600),
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
      return const Center(child: CircularProgressIndicator(color: PurpleTheme.primaryPurple));
    }

    if (state.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: PurpleTheme.textGrey),
            const SizedBox(height: 16),
            Text(state.errorMessage ?? 'Terjadi kesalahan', style: const TextStyle(color: PurpleTheme.textGrey)),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => context.read<MindyBantuAkuCubit>().selectEnergyLevel(EnergyLevel.tinggi),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(color: PurpleTheme.primaryPurple, borderRadius: BorderRadius.circular(20)),
                child: const Text('Coba Lagi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
              const Icon(Icons.inbox_rounded, size: 64, color: PurpleTheme.primaryPurple),
              const SizedBox(height: 16),
              const Text('Belum ada tugas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: PurpleTheme.textDark)),
              const SizedBox(height: 8),
              const Text('Yuk buat tugas baru yang sesuai\ndengan energimu!', style: TextStyle(fontSize: 14, color: PurpleTheme.textGrey), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRoutes.createCustomTask),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: PurpleTheme.primaryButtonGradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: PurpleTheme.primaryPurple.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 6))],
                  ),
                  child: const Text('Buat Tugas Baru', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final recommendedTask = state.primaryRecommendation ?? state.recommendedTasks.first;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Mindy memilihkan\ntugas untukmu', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: PurpleTheme.textDark, height: 1.3)),
          const SizedBox(height: 12),
          const Text('Berdasarkan energimu hari ini dan kategori yang kamu pilih,\nini lah rekomendasi kegiatan terbaik buat kamu', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: PurpleTheme.textGrey, height: 1.4)),
          const SizedBox(height: 24),
          Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: PurpleRecommendationCard(
                  task: recommendedTask,
                  onConfirm: () => Navigator.pushNamed(context, AppRoutes.timer),
                  onTryAnother: () => Navigator.pushNamed(context, AppRoutes.purpleAlternativeTaskList, arguments: {'category': state.selectedCategory ?? widget.selectedCategory, 'excludeTaskId': recommendedTask.id, 'energyLevel': widget.energyLevel ?? EnergyLevel.tinggi}),
                ),
              ),
              Positioned(top: -20, child: _buildMascotImage()),
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
        color: PurpleTheme.backgroundWhite,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [BoxShadow(color: PurpleTheme.shadowColor.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: PurpleTheme.borderLight, borderRadius: BorderRadius.circular(2)))),
    );
  }

  Widget _buildMascotImage() {
    return Image.asset('assets/images/energitinggi/energi_rekomendasi.png', width: 180, height: 90, fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => Container(width: 180, height: 90, decoration: BoxDecoration(color: PurpleTheme.primaryPurplePale, borderRadius: BorderRadius.circular(16)), child: const Center(child: Text('⚡', style: TextStyle(fontSize: 50)))));
  }
}