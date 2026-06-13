import 'package:flutter/material.dart';
import '../models/level_result_model.dart';
import '../widgets/level_header_widget.dart';
import '../widgets/progress_card_widget.dart';

class LevelResultPage extends StatelessWidget {
  final int currentLevel;

  const LevelResultPage({super.key, required this.currentLevel});

  @override
  Widget build(BuildContext context) {
    // Membaca data dinamis (teks, awan, dan background) sesuai level saat ini
    final levelData = LevelResultModel.getLevelData(currentLevel);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            // 🔥 SEKARANG BERUBAH OTOMATIS: Menggunakan background per level
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
                ),
                
                const Spacer(flex: 3),
                
                // 3. Box Progress Card (Progress bar & mini mascot berjalan)
                ProgressCardWidget(
                  currentProgress: levelData.currentProgress,
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
                    onPressed: () {
                      if (currentLevel < 6) {
                        // Pindah ke level selanjutnya dengan transisi bersih
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LevelResultPage(currentLevel: currentLevel + 1),
                          ),
                        );
                      } else {
                        // Jika sudah di level 6, selesaikan perjalanan dan kembali
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      currentLevel == 6 ? 'Selesai' : 'Lanjut Ke Level ${currentLevel + 1}',
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
  }
}