import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/models/task_model.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/theme/green_theme.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/widgets/green_recommendation_card.dart';

/// ============================================================
/// GREEN TASK RECOMMENDATION SCREEN
/// Halaman setelah memilih kategori - menampilkan rekomendasi Mindy
/// ============================================================

class GreenTaskRecommendationPage extends StatelessWidget {
  final TaskCategory selectedCategory;
  final TaskModel recommendedTask;

  const GreenTaskRecommendationPage({
    super.key,
    required this.selectedCategory,
    required this.recommendedTask,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GreenTheme.backgroundPage,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
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
                                  'category': selectedCategory,
                                  'excludeTaskId': recommendedTask.id,
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
                  'Kategori dipilih',
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