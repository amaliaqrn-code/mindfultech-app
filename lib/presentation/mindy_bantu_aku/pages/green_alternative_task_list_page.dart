import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/theme/green_theme.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/widgets/green_alternative_task_list.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/cubit/mindy_bantu_aku_cubit.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/cubit/mindy_bantu_aku_state.dart';

/// ============================================================
/// GREEN ALTERNATIVE TASK LIST SCREEN
/// Halaman untuk memilih tugas lain (alternative)
/// ============================================================

class GreenAlternativeTaskListPage extends StatefulWidget {
  final TaskCategory category;
  final String? excludeTaskId;
  final EnergyLevel energyLevel;

  const GreenAlternativeTaskListPage({
    super.key,
    required this.category,
    this.excludeTaskId,
    required this.energyLevel,
  });

  @override
  State<GreenAlternativeTaskListPage> createState() =>
      _GreenAlternativeTaskListPageState();
}

class _GreenAlternativeTaskListPageState
    extends State<GreenAlternativeTaskListPage> {
  TaskModel? _selectedTask;

  @override
  void initState() {
    super.initState();
    // Trigger data fetch saat halaman dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MindyBantuAkuCubit>().selectEnergyLevel(widget.energyLevel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GreenTheme.backgroundPage,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),

            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Title
                    const Text(
                      'Pilih tugas lain',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: GreenTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    const Text(
                      'Pilih task yang ingin kamu kerjakan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: GreenTheme.textGrey,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Main image dari assets
                    _buildMainImage(),

                    const SizedBox(height: 20),

                    // Task list
                    BlocBuilder<MindyBantuAkuCubit, MindyBantuAkuState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: CircularProgressIndicator(
                                color: GreenTheme.sageGreen,
                              ),
                            ),
                          );
                        }

                        if (state.hasError) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: Text(
                                state.errorMessage ?? 'Terjadi kesalahan',
                                style: TextStyle(
                                  color: GreenTheme.textGrey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        }

                        return GreenAlternativeTaskList(
                          tasks: state.recommendedTasks,
                          selectedTask: _selectedTask,
                          onTaskSelected: (task) {
                            setState(() {
                              _selectedTask = task as TaskModel?;
                            });
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Button
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).padding.bottom + 20,
              ),
              child: GestureDetector(
                onTap: _selectedTask != null
                    ? () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.greenTaskConfirmation,
                          arguments: {
                            'selectedTask': _selectedTask!,
                          },
                        );
                      }
                    : null,
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: _selectedTask != null
                        ? GreenTheme.primaryButtonGradient
                        : null,
                    color: _selectedTask != null ? null : GreenTheme.borderLight,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: _selectedTask != null
                        ? [
                            BoxShadow(
                              color: GreenTheme.sageGreen.withValues(alpha: 0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      'Lanjut',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _selectedTask != null
                            ? Colors.white
                            : GreenTheme.textMuted,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom decoration
            Container(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
            child: const Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: GreenTheme.sageGreen,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  'Pilih tugas lain',
                  style: TextStyle(
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

  Widget _buildMainImage() {
    return Image.asset(
      'assets/images/energirendah/energi_rendah_alternative.png',
      width: double.infinity,
      height: 200,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback jika asset tidak ditemukan
        return Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: GreenTheme.sageGreenLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.spa_rounded,
                size: 60,
                color: GreenTheme.sageGreen,
              ),
              const SizedBox(height: 8),
              const Text(
                '☁️ Mindy siap membantu!',
                style: TextStyle(
                  fontSize: 16,
                  color: GreenTheme.sageGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}