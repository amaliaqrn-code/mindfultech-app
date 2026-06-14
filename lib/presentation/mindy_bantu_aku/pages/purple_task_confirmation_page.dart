import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/theme/purple_theme.dart';

/// ============================================================
/// PURPLE TASK CONFIRMATION SCREEN
/// Halaman konfirmasi tugas pilihan setelah memilih dari alternatif
/// ============================================================

class PurpleTaskConfirmationPage extends StatelessWidget {
  final TaskModel selectedTask;

  const PurpleTaskConfirmationPage({
    super.key,
    required this.selectedTask,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PurpleTheme.backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 44),

            // Title
            const Text(
              'Tugas Dipilih',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: PurpleTheme.primaryPurpleDark,
              ),
            ),
            const SizedBox(height: 6),

            // Subtitle
            const Text(
              'Aktivitas yang kamu pilih untuk menemani\nfokus hari ini',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: PurpleTheme.textGrey,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),

            // Mascot Image - centered above card
            _buildMascotImage(),
            // Main Task Card
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Card - min height 340
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(minHeight: 340),
                      decoration: BoxDecoration(
                        color: PurpleTheme.backgroundWhite,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: PurpleTheme.primaryPurple.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: PurpleTheme.shadowColor,
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Badge Header - height 56
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                            child: Container(
                              width: double.infinity,
                              height: 30,
                              decoration: BoxDecoration(
                                color: PurpleTheme.primaryPurplePale,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: 
                                  Center(
                                    child: Text(
                                      'Hari ini coba kamu fokus ke:',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: PurpleTheme.primaryPurple,
                                      ),
                                    ),
                                  ),
                            ),
                          ),

                          // Content
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                // Task Icon - 100x100
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: PurpleTheme.primaryPurplePale,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: SvgPicture.asset(
                                      selectedTask.kategori.iconPath,
                                      width: 50,
                                      height: 50,
                                      colorFilter: const ColorFilter.mode(
                                        PurpleTheme.primaryPurple,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // Task Title
                                Text(
                                  selectedTask.namaTugas,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: PurpleTheme.primaryPurpleDark,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Task Description
                                Text(
                                  selectedTask.kategori.displayName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: PurpleTheme.textGrey,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Primary Button - "Yay, Lanjut Fokus!"
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
                          color: PurpleTheme.primaryPurple,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: [
                            BoxShadow(
                              color: PurpleTheme.primaryPurple.withValues(alpha: 0.4),
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
          ],
        ),
      ),
    );
  }

  Widget _buildMascotImage() {
    return   Padding(
      padding: EdgeInsetsGeometry.only(left: 20),
      child: Image.asset(
        'assets/images/energitinggi/energi_rekomendasi.png',
        width: 200,
        height: 106.59996032714844,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 180,
            height: 90,
            decoration: BoxDecoration(
              color: PurpleTheme.primaryPurplePale,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text('⚡', style: TextStyle(fontSize: 50)),
            ),
          );
        },
      ),
    );
  }
}
