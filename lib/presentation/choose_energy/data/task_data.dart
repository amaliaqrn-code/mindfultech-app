import '../models/task_model.dart';

/// Data tugas mock untuk sistem filter & rekomendasi
class TaskData {
  /// Semua daftar tugas
  static const List<TaskModel> allTasks = [
    // ===== TUGAS RUMAH =====
    // Energy Low - Rumah
    TaskModel(
      id: 'r1',
      title: 'Membersihkan Meja Kerja',
      description: 'Rapikan dan bersihkan permukaan meja dari barang yang tidak diperlukan. Buat suasana kerja lebih nyaman.',
      category: TaskCategory.rumah,
      energyLevel: EnergyLevel.low,
      iconName: 'desk',
      estimatedMinutes: 10,
    ),
    TaskModel(
      id: 'r2',
      title: 'Menulis Jurnal',
      description: 'Tulis refleksi hari ini. Apa yang kamu syukuri dan apa yang bisa diperbaiki besok.',
      category: TaskCategory.rumah,
      energyLevel: EnergyLevel.low,
      iconName: 'edit_note',
      estimatedMinutes: 15,
    ),
    TaskModel(
      id: 'r3',
      title: 'Menyampur Pakaian',
      description: 'Kumpulkan pakaian kotor dan masukkan ke mesin cuci. Jalankan siklus pencucian.',
      category: TaskCategory.rumah,
      energyLevel: EnergyLevel.low,
      iconName: 'local_laundry_service',
      estimatedMinutes: 5,
    ),
    TaskModel(
      id: 'r4',
      title: 'Menyiram Tanaman',
      description: 'Siram tanaman di dalam rumah. Periksa kondisi tanah apakah sudah kering.',
      category: TaskCategory.rumah,
      energyLevel: EnergyLevel.low,
      iconName: 'local_florist',
      estimatedMinutes: 5,
    ),
    // Energy Medium - Rumah
    TaskModel(
      id: 'r5',
      title: 'Mengepel Lantai',
      description: 'Bersihkan lantai dari debu dan noda. Gunakan pel atau Vacuum cleaner.',
      category: TaskCategory.rumah,
      energyLevel: EnergyLevel.medium,
      iconName: 'cleaning_services',
      estimatedMinutes: 25,
    ),
    TaskModel(
      id: 'r6',
      title: 'Merapikan Kamar',
      description: 'Rapikan tempat tidur, lipat pakaian, dan masukkan barang ke tempatnya.',
      category: TaskCategory.rumah,
      energyLevel: EnergyLevel.medium,
      iconName: 'king_bed',
      estimatedMinutes: 20,
    ),
    TaskModel(
      id: 'r7',
      title: 'Mencuci Piring',
      description: 'Cuci piring kotor secara manual atau masukkan ke mesin pencucian piring.',
      category: TaskCategory.rumah,
      energyLevel: EnergyLevel.medium,
      iconName: 'restaurant',
      estimatedMinutes: 15,
    ),
    // Energy High - Rumah
    TaskModel(
      id: 'r8',
      title: 'Membersihkan Kamar Mandi',
      description: 'Bersihkan toilet, shower, dan wastafel dengan desinfektan.',
      category: TaskCategory.rumah,
      energyLevel: EnergyLevel.high,
      iconName: 'bathroom',
      estimatedMinutes: 30,
    ),
    TaskModel(
      id: 'r9',
      title: 'Membersihkan Gudang',
      description: 'Rapikan gudang atau ruang penyimpanan. Buang barang yang sudah tidak terpakai.',
      category: TaskCategory.rumah,
      energyLevel: EnergyLevel.high,
      iconName: 'warehouse',
      estimatedMinutes: 45,
    ),

    // ===== TUGAS SELF CARE =====
    // Energy Low - Self Care
    TaskModel(
      id: 'sc1',
      title: 'Meditasi 5 Menit',
      description: 'Ambillah waktu untuk bernapas dalam-dalam dan menenangkan pikiran. Fokus pada aroma di sekitarmu.',
      category: TaskCategory.selfCare,
      energyLevel: EnergyLevel.low,
      iconName: 'self_improvement',
      estimatedMinutes: 5,
    ),
    TaskModel(
      id: 'sc2',
      title: 'Minum Air Hangat',
      description: 'Seduh teh atau kopi hangat. Nikmati prosesnya danhirup aroma wanginya.',
      category: TaskCategory.selfCare,
      energyLevel: EnergyLevel.low,
      iconName: 'local_cafe',
      estimatedMinutes: 5,
    ),
    TaskModel(
      id: 'sc3',
      title: 'Stretching Ringan',
      description: 'Lakukan peregangan ringan untuk leher, bahu, dan punggung.非常好 untuk tubuh.',
      category: TaskCategory.selfCare,
      energyLevel: EnergyLevel.low,
      iconName: 'accessibility_new',
      estimatedMinutes: 10,
    ),
    // Energy Medium - Self Care
    TaskModel(
      id: 'sc4',
      title: 'Face Mask',
      description: 'Rawat kulit wajah dengan masker. Pilih masker yang sesuai jenis kulitmu.',
      category: TaskCategory.selfCare,
      energyLevel: EnergyLevel.medium,
      iconName: 'face',
      estimatedMinutes: 20,
    ),
    TaskModel(
      id: 'sc5',
      title: 'Mandi Air Hangat',
      description: 'Nikmati mandi air hangat dengan tambahan minyak esensial atau garam bath.',
      category: TaskCategory.selfCare,
      energyLevel: EnergyLevel.medium,
      iconName: 'bathtub',
      estimatedMinutes: 20,
    ),
    // Energy High - Self Care
    TaskModel(
      id: 'sc6',
      title: 'Skincare Routine Lengkap',
      description: 'Lakukan routine perawatan kulit lengkap: cleansing, toning, serum, dan moisturizer.',
      category: TaskCategory.selfCare,
      energyLevel: EnergyLevel.high,
      iconName: 'spa',
      estimatedMinutes: 30,
    ),
    TaskModel(
      id: 'sc7',
      title: 'Yoga Session',
      description: 'Ikuti session yoga 30 menit untuk meningkatkan fleksibilitas dan kekuatan.',
      category: TaskCategory.selfCare,
      energyLevel: EnergyLevel.high,
      iconName: 'fitness_center',
      estimatedMinutes: 30,
    ),

    // ===== TUGAS BELAJAR =====
    // Energy Low - Belajar
    TaskModel(
      id: 'b1',
      title: 'Baca Buku 10 Halaman',
      description: 'Baca beberapa halaman buku yang kamu sukai. Tidak perlu banyak, cukup nikmati.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.low,
      iconName: 'menu_book',
      estimatedMinutes: 15,
    ),
    TaskModel(
      id: 'b2',
      title: 'Belajar Kosakata Baru',
      description: 'Pelajari 5 kata baru dalam bahasa asing. Gunakan flashcard atau aplikasi belajar.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.low,
      iconName: 'translate',
      estimatedMinutes: 10,
    ),
    TaskModel(
      id: 'b3',
      title: 'Menonton Edukasi',
      description: 'Tonton video edukasi singkat di YouTube tentang topik yang kamu minati.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.low,
      iconName: 'play_circle',
      estimatedMinutes: 15,
    ),
    // Energy Medium - Belajar
    TaskModel(
      id: 'b4',
      title: 'Kerjakan PR/Tugas',
      description: 'Fokus selesaikan tugas atau PR yang tertunda. bekerja dengan tenang.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.medium,
      iconName: 'assignment',
      estimatedMinutes: 30,
    ),
    TaskModel(
      id: 'b5',
      title: 'Belajar Skill Baru',
      description: 'Praktek skill baru yang sedang kamu pelajari. Bisa coding, desain, atau musik.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.medium,
      iconName: 'school',
      estimatedMinutes: 30,
    ),
    // Energy High - Belajar
    TaskModel(
      id: 'b6',
      title: 'Workshop Online',
      description: 'Ikuti workshop atau webinar untuk meningkatkan kemampuan. Aktif berinteraksi.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.high,
      iconName: 'computer',
      estimatedMinutes: 60,
    ),
    TaskModel(
      id: 'b7',
      title: 'Proyek Belajar Intensif',
      description: 'Kerjakan proyek belajar secara mendalam. Fokus dan ciptakan hasil terbaik.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.high,
      iconName: 'construction',
      estimatedMinutes: 60,
    ),

    // ===== TUGAS HUBUNGAN =====
    // Energy Low - Hubungan
    TaskModel(
      id: 'h1',
      title: 'Kirim Pesan ke Teman',
      description: 'Kirim pesan atau voice note ke teman lama. Tanyakan kabarnya dengan tulus.',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.low,
      iconName: 'chat',
      estimatedMinutes: 10,
    ),
    TaskModel(
      id: 'h2',
      title: 'Caption Media Sosial',
      description: 'Buat caption yang menarik untuk konten media sosialmu. Ungkapkan perasaanmu.',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.low,
      iconName: 'text_fields',
      estimatedMinutes: 10,
    ),
    // Energy Medium - Hubungan
    TaskModel(
      id: 'h3',
      title: 'Telepon Orang Tua',
      description: 'Hubungi orang tua atau kerabat terdekat. Ngobrol santai tanpa terburu-buru.',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.medium,
      iconName: 'call',
      estimatedMinutes: 20,
    ),
    TaskModel(
      id: 'h4',
      title: 'Main dengan hewan peliharaan',
      description: 'Luangkan waktu bermain dengan kucing atau anjing kesayanganmu.',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.medium,
      iconName: 'pets',
      estimatedMinutes: 20,
    ),
    // Energy High - Hubungan
    TaskModel(
      id: 'h5',
      title: 'Kumpul Keluarga',
      description: 'Adakan quality time bersama keluarga. Main game atau masak bersama.',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.high,
      iconName: 'family_restroom',
      estimatedMinutes: 60,
    ),
    TaskModel(
      id: 'h6',
      title: 'Hangout dengan Teman',
      description: 'Keluarkan waktu untuk berkumpul dengan teman. Ngobrol dan tertawa bareng.',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.high,
      iconName: 'groups',
      estimatedMinutes: 60,
    ),

    // ===== TUGAS KREATIVITAS =====
    // Energy Low - Kreativitas
    TaskModel(
      id: 'kr1',
      title: 'Doodle di Kertas',
      description: 'Gambar corat-coret di kertas. Tidak perlu sempurna, biarkan imajinasimu mengalir.',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.low,
      iconName: 'brush',
      estimatedMinutes: 10,
    ),
    TaskModel(
      id: 'kr2',
      title: 'Dengarkan Musik',
      description: 'Temukan playlist baru atau buat playlist sesuai mood. Enjoy musiknya.',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.low,
      iconName: 'music_note',
      estimatedMinutes: 15,
    ),
    // Energy Medium - Kreativitas
    TaskModel(
      id: 'kr3',
      title: 'Memasak Resep Baru',
      description: 'Coba resep baru yang belum pernah dibuat. Siap-siap bereksperimen di dapur!',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.medium,
      iconName: 'restaurant_menu',
      estimatedMinutes: 45,
    ),
    TaskModel(
      id: 'kr4',
      title: 'Menulis Puisi/Cerpen',
      description: 'Tulis puisi pendek atau cerpen berdasarkan perasaanmu saat ini.',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.medium,
      iconName: 'create',
      estimatedMinutes: 30,
    ),
    // Energy High - Kreativitas
    TaskModel(
      id: 'kr5',
      title: 'Proyek Seni',
      description: 'Buat karya seni yang lebih kompleks. Bisa lukisan, kolase, atau craft.',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.high,
      iconName: 'palette',
      estimatedMinutes: 60,
    ),
    TaskModel(
      id: 'kr6',
      title: 'Bikin Konten Kreatif',
      description: 'Buat konten untuk media sosial - foto, video, atau tulisan kreatif.',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.high,
      iconName: 'videocam',
      estimatedMinutes: 45,
    ),

    // ===== TUGAS KESEHATAN =====
    // Energy Low - Kesehatan
    TaskModel(
      id: 'k1',
      title: 'Minum Vitamin',
      description: 'Jangan lupa minum vitamin atau suplemen hari ini. Jaga kesehatan tubuh.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.low,
      iconName: 'medication',
      estimatedMinutes: 5,
    ),
    TaskModel(
      id: 'k2',
      title: 'Cek tekanan Darah',
      description: 'Ukur tekanan darah dengan alat yang tersedia. Catat hasilnya.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.low,
      iconName: 'favorite',
      estimatedMinutes: 5,
    ),
    TaskModel(
      id: 'k3',
      title: 'Journaling Kesehatan',
      description: 'Catat makanan yang dimakan hari ini dan perasaanmu. Evaluasi pola makan.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.low,
      iconName: 'book',
      estimatedMinutes: 10,
    ),
    // Energy Medium - Kesehatan
    TaskModel(
      id: 'k4',
      title: 'Jalan-jalan Sebentar',
      description: 'Keluarkan rumah untuk jalan-jalan santai 15-20 menit. Nikmati udara segar.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.medium,
      iconName: 'directions_walk',
      estimatedMinutes: 20,
    ),
    TaskModel(
      id: 'k5',
      title: 'Olahraga Ringan',
      description: 'Lakukan olahraga ringan seperti push-up, squat, atau plank 10 menit.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.medium,
      iconName: 'sports',
      estimatedMinutes: 20,
    ),
    // Energy High - Kesehatan
    TaskModel(
      id: 'k6',
      title: 'Gym/Pool Session',
      description: 'Pergi ke gym atau kolam Renang untuk olahraga intens. Target 1 jam.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.high,
      iconName: 'pool',
      estimatedMinutes: 60,
    ),
    TaskModel(
      id: 'k7',
      title: 'Hiking/Trekking',
      description: 'Jelajahi alam dengan hiking di taman atau bukit terdekat.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.high,
      iconName: 'hiking',
      estimatedMinutes: 90,
    ),
  ];

  /// Ambil tugas berdasarkan kategori dan level energi
  static List<TaskModel> getTasksByFilter({
    required TaskCategory category,
    required EnergyLevel energyLevel,
  }) {
    return allTasks
        .where((task) =>
            task.category == category && task.energyLevel == energyLevel)
        .toList();
  }

  /// Ambil rekomendasi tugas terbaik (prioritas 1)
  static TaskModel? getRecommendedTask({
    required TaskCategory category,
    required EnergyLevel energyLevel,
  }) {
    final tasks = getTasksByFilter(category: category, energyLevel: energyLevel);
    if (tasks.isEmpty) return null;
    return tasks.first;
  }

  /// Ambil tugas alternatif (selain tugas rekomendasi)
  static List<TaskModel> getAlternativeTasks({
    required TaskCategory category,
    required EnergyLevel energyLevel,
    String? excludeTaskId,
  }) {
    return allTasks
        .where((task) =>
            task.category == category &&
            task.energyLevel == energyLevel &&
            task.id != excludeTaskId)
        .toList();
  }

  /// Ambil semua tugas untuk view alternatif
  static List<TaskModel> getAllTasksByEnergy(EnergyLevel energyLevel) {
    return allTasks.where((task) => task.energyLevel == energyLevel).toList();
  }
}
