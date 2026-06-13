import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_cubit.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_state.dart';
import '../models/level_result_model.dart';
import '../widgets/level_header_widget.dart';
import '../widgets/progress_card_widget.dart';
import 'journey_page.dart';

class LevelResultPage extends StatelessWidget {
  final int currentLevel;

  const LevelResultPage({super.key, required this.currentLevel});

  @override
  Widget build(BuildContext context) {
    // ✅ Use BlocBuilder to ensure reactive state
    return BlocBuilder<JourneyCubit, JourneyState>(
      builder: (context, state) {
        // Get level data based on current level (clamped to valid range)
        final levelData = LevelResultModel.getLevelData(currentLevel.clamp(1, 6));

        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(levelData.backgroundPath),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  children: [
                    // Tombol Back di pojok kiri atas
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_circle_left, size: 40, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 1. Header atas (Level Badge, Title, Subtitle)
                    LevelHeaderWidget(
                      level: levelData.level,
                      title: levelData.title,
                      subtitle: levelData.subtitle,
                    ),

                    const Spacer(flex: 2),

                    // 2. Gambar Awan Tengah yang otomatis berganti ekspresi wajahnya
                    Image.asset(
                      levelData.imagePath,
                      height: 200,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.cloud, size: 150, color: Colors.white);
                      },
                    ),

                    const Spacer(flex: 3),

                    // 3. Box Progress Card (Progress bar & mini mascot berjalan)
                    ProgressCardWidget(
                      currentProgress: state.safeTotalDays, // ✅ Use safe getter
                      maxProgress: levelData.maxProgress,
                    ),

                    const SizedBox(height: 24),

                    // 4. Tombol Aksi dinamis paling bawah
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2d3167),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () => _handleContinue(context, state),
                        child: Text(
                          currentLevel >= 6 ? 'Selesai' : 'Lanjut Ke Level ${currentLevel + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// ✅ FIXED: Handle continue with proper state update and navigation
  Future<void> _handleContinue(BuildContext context, JourneyState state) async {
    final cubit = context.read<JourneyCubit>();

    // ✅ STEP 1: Update JourneyCubit state FIRST
    // This updates: totalDays, currentLevel, streak, lastFocusDate
    await cubit.completeLevelSession();

    // ✅ STEP 2: Check if journey is complete
    if (currentLevel >= 6) {
      // Journey complete - navigate back to journey page
      if (context.mounted) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushNamed(context, AppRoutes.journey);
      }
      return;
    }

    // ✅ STEP 3: Navigate to JourneyPage (cloud animation will trigger automatically)
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const JourneyPage()),
      );

      // ✅ STEP 4: Wait for mascot animation to complete
      await Future.delayed(const Duration(milliseconds: 900));

      if (context.mounted) {
        // ✅ STEP 5: Navigate to next level result
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LevelResultPage(currentLevel: currentLevel + 1),
          ),
        );
      }
    }
  }
}
