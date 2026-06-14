import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/theme/blue_theme.dart';

/// ============================================================
/// BLUE TASK CONFIRMATION SCREEN
/// Halaman konfirmasi tugas pilihan setelah memilih dari alternatif
/// ============================================================

class BlueTaskConfirmationPage extends StatelessWidget {
  final TaskModel selectedTask;

  const BlueTaskConfirmationPage({
    super.key,
    required this.selectedTask,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlueTheme.backgroundPage,
      body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 32),

            const Text(
              'Tugas Dipilih',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: BlueTheme.primaryBlueDark,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Aktivitas yang kamu pilih untuk menemani\nfokus hari ini',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: BlueTheme.textGrey,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 12),

            _buildMascotImage(),
            // CARD
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 340),
              decoration: BoxDecoration(
                color: BlueTheme.backgroundWhite,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: BlueTheme.primaryBlue.withValues(alpha: 0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: BlueTheme.shadowColor,
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 24),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: BlueTheme.primaryBluePale,
                        borderRadius: BorderRadius.circular(36),
                      ),
                      child: const Center(
                        child: Text(
                          'Hari ini coba kamu fokus ke:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: BlueTheme.textMedium,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: BlueTheme.primaryBluePale,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: SvgPicture.asset(
                              selectedTask.kategori.iconPath,
                              colorFilter: const ColorFilter.mode(
                                BlueTheme.primaryBlueDark,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        Text(
                          selectedTask.namaTugas,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: BlueTheme.primaryBlueDark,
                          ),
                        ),

                        const SizedBox(height: 16),

                        Text(
                          selectedTask.kategori.displayName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: BlueTheme.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // BUTTON
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.setupTimer,
                  arguments: selectedTask,
                );
              },
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  gradient: BlueTheme.primaryButtonGradient,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: BlueTheme.primaryBlue.withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Yay, Lanjut Fokus!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    ),    
    );
  }

  Widget _buildMascotImage() {
    return Center(
      child: Image.asset(
        'assets/images/energisedang/energi_rekomendasi.png',
        width: 237.999755859375,
        height: 146.59996032714844,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 180,
            height: 90,
            decoration: BoxDecoration(
              color: BlueTheme.primaryBluePale,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text('😊', style: TextStyle(fontSize: 50)),
            ),
          );
        },
      ),
    );
  }
}
