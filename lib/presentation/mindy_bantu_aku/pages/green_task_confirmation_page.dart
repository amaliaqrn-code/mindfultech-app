import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/theme/green_theme.dart';

/// ============================================================
/// GREEN TASK CONFIRMATION SCREEN
/// Halaman konfirmasi tugas pilihan setelah memilih dari alternatif
/// ============================================================

class GreenTaskConfirmationPage extends StatelessWidget {
  final TaskModel selectedTask;

  const GreenTaskConfirmationPage({
    super.key,
    required this.selectedTask,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GreenTheme.backgroundPage,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),

            // Title
            const Text(
              'Tugas Dipilih',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: GreenTheme.sageGreen,
              ),
            ),
            const SizedBox(height: 6),

            // Subtitle
            const Text(
              'Yuk, pastikan tugas yang kamu pilih ini\ndan siap untuk fokus!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: GreenTheme.textGrey,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),

            // Mascot Image - centered above card
            Padding(
              padding: const EdgeInsets.only(left: 38),
              child: _buildMascotImage(),
            ),

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
                        color: GreenTheme.backgroundWhite,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: GreenTheme.sageGreen.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: GreenTheme.shadowColor,
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
                            padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 20),
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                color: GreenTheme.sageGreenLight,
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: 
                                Center(
                                  child: Text(
                                   'Hari ini coba kamu fokus ke:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: GreenTheme.sageGreen,
                                    ),                        
                                  ),
                                ),
                              ),
                          ),
                          // Content
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: [
                                // Task Icon -100x100
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: GreenTheme.sageGreenLight,
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    selectedTask.kategori.iconPath,
                                    width: 22,
                                    height: 22,
                                    colorFilter: const ColorFilter.mode(
                                      GreenTheme.sageGreen,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // Task Title
                                Text(
                                  selectedTask.namaTugas,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: GreenTheme.sageGreen,
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
                                    color: GreenTheme.textGrey,
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
                          color: GreenTheme.sageGreen,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: [
                            BoxShadow(
                              color: GreenTheme.sageGreen.withValues(alpha: 0.4),
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
    return Center(
      child: Image.asset(
        'assets/images/energirendah/energi_rendah_rekomendasi.png',
        width: 292,
        height: 133,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 180,
            height: 90,
            decoration: BoxDecoration(
              color: GreenTheme.sageGreenLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text('😴', style: TextStyle(fontSize: 50)),
            ),
          );
        },
      ),
    );
  }
}
