class LevelResultModel {
  final int level;
  final String title;
  final String subtitle;
  final String imagePath;      // Menangani gambar awan tengah
  final String backgroundPath; // Menangani background per level
  final int currentProgress;
  final int maxProgress;

  LevelResultModel({
    required this.level,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.backgroundPath,
    required this.currentProgress,
    required this.maxProgress,
  });

  static LevelResultModel getLevelData(int level) {
    // 1. Tentukan asset gambar awan tengah secara dinamis
    // Level 6 menggunakan nama file 'Group 67.png' sesuai daftar asetmu
    String cloudImg = level == 6 
        ? 'assets/images/result/Group 67.png' 
        : 'assets/images/result/Cloud$level.png';

    // 2. Tentukan asset background secara dinamis
    String bgImg = 'assets/images/result/resultlevel$level.png';

    // 3. Tentukan teks motivasi berdasarkan level (sesuai screenshot)
    String titleText = 'Kamu mulai menemukan ritmemu';
    String subtitleText = 'Setiap perjalanan dimulai dari satu langkah.';

    if (level == 1) {
      titleText = 'Perjalanan kecilmu dimulai hari ini';
    } else if (level == 6) {
      titleText = 'Kamu berhasil menyelesaikan ritmemu!';
    }

    return LevelResultModel(
      level: level,
      title: titleText,
      subtitle: subtitleText,
      imagePath: cloudImg,
      backgroundPath: bgImg,
      currentProgress: level,
      maxProgress: 6,
    );
  }
}