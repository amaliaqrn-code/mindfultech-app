import '../models/task_model.dart';

/// Data tugas mock untuk Medium Energy (Energi Sedang)
class MediumEnergyData {
  /// Semua daftar tugas untuk medium energy
  static const List<TaskModel> allMediumTasks = [
    // ===== TUGAS PEKERJAAN =====
    // Energy Medium - Pekerjaan
    TaskModel(
      id: 'pk1',
      title: 'Membalas Email',
      description: 'Selesaikan email yang tertunda dengan tenang.Prioritaskan pesan penting.',
      category: TaskCategory.pekerjaan,
      energyLevel: EnergyLevel.medium,
      iconName: 'email',
      estimatedMinutes: 20,
    ),
    TaskModel(
      id: 'pk2',
      title: 'Menyusun Jadwal',
      description: 'Buat jadwal kegiatan untuk minggu ini. Atur prioritas dengan bijak.',
      category: TaskCategory.pekerjaan,
      energyLevel: EnergyLevel.medium,
      iconName: 'schedule',
      estimatedMinutes: 25,
    ),
    TaskModel(
      id: 'pk3',
      title: 'Meeting Report',
      description: 'Tulis ringkasan dari meeting hari ini. Catat action items.',
      category: TaskCategory.pekerjaan,
      energyLevel: EnergyLevel.medium,
      iconName: 'assignment',
      estimatedMinutes: 20,
    ),
    TaskModel(
      id: 'pk4',
      title: 'Update Progress Project',
      description: 'Update status project di tracker. Dokumentasikan pencapaian.',
      category: TaskCategory.pekerjaan,
      energyLevel: EnergyLevel.medium,
      iconName: 'trending_up',
      estimatedMinutes: 15,
    ),
    TaskModel(
      id: 'pk5',
      title: 'Buat Slide Presentasi',
      description: 'Persiapkan materi presentasi untuk cliente atau tim.',
      category: TaskCategory.pekerjaan,
      energyLevel: EnergyLevel.medium,
      iconName: 'slideshow',
      estimatedMinutes: 45,
    ),
    TaskModel(
      id: 'pk6',
      title: 'Review Dokumen',
      description: 'Periksa dan review dokumen yang perlu approval.',
      category: TaskCategory.pekerjaan,
      energyLevel: EnergyLevel.medium,
      iconName: 'description',
      estimatedMinutes: 30,
    ),
    TaskModel(
      id: 'pk7',
      title: 'Organisir File',
      description: 'Rapikan file di komputer. Buat folder-folder sesuai kategori.',
      category: TaskCategory.pekerjaan,
      energyLevel: EnergyLevel.medium,
      iconName: 'folder',
      estimatedMinutes: 25,
    ),
    TaskModel(
      id: 'pk8',
      title: 'Planning Mingguan',
      description: 'Buat plan kerja untuk minggu depan. Tentukan goals utama.',
      category: TaskCategory.pekerjaan,
      energyLevel: EnergyLevel.medium,
      iconName: 'event_note',
      estimatedMinutes: 30,
    ),

    // ===== TUGAS BELAJAR (Medium) =====
    TaskModel(
      id: 'bl1',
      title: 'Belajar Online',
      description: 'Ikuti course online di platform favorit. Fokus pada satu topik.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.medium,
      iconName: 'school',
      estimatedMinutes: 45,
    ),
    TaskModel(
      id: 'bl2',
      title: 'Membaca Buku',
      description: 'Luangkan waktu untuk membaca buku teknis atau pengembangan diri.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.medium,
      iconName: 'menu_book',
      estimatedMinutes: 30,
    ),
    TaskModel(
      id: 'bl3',
      title: 'Membaca Artikel',
      description: 'Cari dan baca artikel menarik tentang topik yang kamu minati.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.medium,
      iconName: 'article',
      estimatedMinutes: 20,
    ),
    TaskModel(
      id: 'bl4',
      title: 'Kerjakan Latihan Soal',
      description: 'Praktek dengan latihan soal untuk mengasah kemampuan.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.medium,
      iconName: 'quiz',
      estimatedMinutes: 30,
    ),
    TaskModel(
      id: 'bl5',
      title: 'Belajar Bahasa Baru',
      description: 'Pelajari vocabulario dan grammar bahasa asing hari ini.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.medium,
      iconName: 'translate',
      estimatedMinutes: 25,
    ),
    TaskModel(
      id: 'bl6',
      title: 'Tutorial Video',
      description: 'Tonton tutorial video untuk skill baru yang ingin dipelajari.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.medium,
      iconName: 'video_library',
      estimatedMinutes: 30,
    ),

    // ===== TUGAS KESEHATAN (Medium) =====
    TaskModel(
      id: 'ks1',
      title: 'Jalan Pagi',
      description: 'Keluarkan rumah untuk jalan pagi 20 menit. Nikmati udara segar.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.medium,
      iconName: 'directions_walk',
      estimatedMinutes: 20,
    ),
    TaskModel(
      id: 'ks2',
      title: 'Olahraga Ringan',
      description: 'Lakukan workout ringan seperti yoga atau stretching intensif.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.medium,
      iconName: 'fitness_center',
      estimatedMinutes: 30,
    ),
    TaskModel(
      id: 'ks3',
      title: 'Memasak Sehat',
      description: 'Siapkan menu makan sehat untuk hari ini. Eksperimen dengan resep baru.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.medium,
      iconName: 'restaurant',
      estimatedMinutes: 45,
    ),
    TaskModel(
      id: 'ks4',
      title: 'Cek Kesehatan',
      description: 'Periksa kondisi kesehatan: tekanan darah, berat badan, dll.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.medium,
      iconName: 'health_and_safety',
      estimatedMinutes: 10,
    ),
    TaskModel(
      id: 'ks5',
      title: 'Minum Vitamin',
      description: 'Jaga kesehatan dengan minum vitamin dan suplemen hari ini.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.medium,
      iconName: 'medication',
      estimatedMinutes: 5,
    ),

    // ===== TUGAS KREATIVITAS (Medium) =====
    TaskModel(
      id: 'kr1',
      title: 'Mulai Proyek Seni',
      description: 'Mulai proyek kreatif baru sesuai passionmu. Ekspresikan dirimu.',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.medium,
      iconName: 'palette',
      estimatedMinutes: 45,
    ),
    TaskModel(
      id: 'kr2',
      title: 'Buat Konten Sosial Media',
      description: 'Design konten untuk media sosial. Posting yang menarik hari ini.',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.medium,
      iconName: 'camera_alt',
      estimatedMinutes: 30,
    ),
    TaskModel(
      id: 'kr3',
      title: 'Menulis Draft Cerita',
      description: 'Tulis draft untuk cerpen atau novel yang sudah lama diimpiikan.',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.medium,
      iconName: 'edit',
      estimatedMinutes: 40,
    ),
    TaskModel(
      id: 'kr4',
      title: 'Memasak Resep Baru',
      description: 'Coba resep baru yang berbeda dari biasanya. Bereksperimen di dapur!',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.medium,
      iconName: 'restaurant_menu',
      estimatedMinutes: 45,
    ),
    TaskModel(
      id: 'kr5',
      title: 'Belajar Editing Video',
      description: 'Praktek editing video dengan software yang tersedia.',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.medium,
      iconName: 'movie',
      estimatedMinutes: 40,
    ),

    // ===== TUGAS HUBUNGAN (Medium) =====
    TaskModel(
      id: 'hb1',
      title: 'Hangout dengan Teman',
      description: 'Luangkan waktu berkualitas dengan teman dekat. Ngobrol santai.',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.medium,
      iconName: 'groups',
      estimatedMinutes: 60,
    ),
    TaskModel(
      id: 'hb2',
      title: 'Quality Time Keluarga',
      description: 'Habiskan waktu bersama keluarga tanpa ganguan gadget.',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.medium,
      iconName: 'family_restroom',
      estimatedMinutes: 45,
    ),
    TaskModel(
      id: 'hb3',
      title: 'Telepon Sahabat',
      description: 'Hubungi sahabat lama untuk catch up. Jalin kembali hubungan.',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.medium,
      iconName: 'call',
      estimatedMinutes: 30,
    ),
    TaskModel(
      id: 'hb4',
      title: 'Main dengan Hewan',
      description: 'Luangkan waktu bermain dengan hewan peliharaan kesayangan.',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.medium,
      iconName: 'pets',
      estimatedMinutes: 20,
    ),
    TaskModel(
      id: 'hb5',
      title: 'Kirim Pesan untuk Orang Tersayang',
      description: 'Kirim pesan atau voice note ke orang yang kamu sayangi.',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.medium,
      iconName: 'favorite',
      estimatedMinutes: 10,
    ),
  ];

  /// Ambil rekomendasi tugas berdasarkan kategori
  static TaskModel? getRecommendedTask(TaskCategory category) {
    final tasks = allMediumTasks
        .where((task) => task.category == category)
        .toList();
    if (tasks.isEmpty) return null;
    return tasks.first;
  }

  /// Ambil tugas alternatif
  static List<TaskModel> getAlternativeTasks(TaskCategory category, {String? excludeTaskId}) {
    return allMediumTasks
        .where((task) => task.category == category && task.id != excludeTaskId)
        .toList();
  }

  /// Ambil semua tugas untuk energi sedang
  static List<TaskModel> getAllTasks() => allMediumTasks;

  /// Ambil tugas berdasarkan kategori
  static List<TaskModel> getTasksByCategory(TaskCategory category) {
    return allMediumTasks
        .where((task) => task.category == category)
        .toList();
  }
}
