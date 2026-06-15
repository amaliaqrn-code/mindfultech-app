import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_cubit.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_state.dart';
import '../models/level_result_model.dart';
import '../widgets/level_header_widget.dart';
import '../widgets/progress_card_widget.dart';

class LevelResultPage extends StatelessWidget {
  final int currentLevel;

  const LevelResultPage({super.key, required this.currentLevel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JourneyCubit, JourneyState>(
      builder: (context, state) {
        // Ambil data visual level (clamped dari level 1 sampai maksimal level 6)
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_circle_left, size: 40, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 1. Header Detail Level
                    LevelHeaderWidget(
                      level: levelData.level,
                      title: levelData.title,
                      subtitle: levelData.subtitle,
                    ),
                    const Spacer(flex: 2),

                    // 2. Maskot Ekspresi Awan Tengah
                    Image.asset(
                      levelData.imagePath,
                      height: 200,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.cloud, size: 150, color: Colors.white);
                      },
                    ),
                    const Spacer(flex: 3),

                    // 3. Status Progress Card Akumulasi Hari
                    ProgressCardWidget(
                      currentProgress: state.safeTotalDays,
                      maxProgress: levelData.maxProgress,
                    ),
                    const SizedBox(height: 24),

                    // 4. Tombol Aksi Penyelesaian
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2d3167),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () {
                          // Bersihkan tumpukan halaman agar kembali ke halaman utama aplikasi
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: Text(
                          currentLevel >= 6 ? 'Selesaikan Ritual 🏰' : 'Lanjut Menjelajah',
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
}