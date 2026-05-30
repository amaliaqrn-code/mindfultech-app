import '../models/task_model.dart';

/// Data tugas mock untuk High Energy (Energi Tinggi)
class HighEnergyData {
  /// Semua daftar tugas untuk high energy
  static const List<TaskModel> allHighTasks = [
    // ===== TUGAS KESEHATAN (High) =====
    TaskModel(
      id: 'hks1',
      title: 'Workout Singkat',
      description: 'Selesaikan targetmu dengan gerakan aktif. Pilih workout yang kamu suka!',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.high,
      iconName: 'fitness_center',
      estimatedMinutes: 30,
    ),
    TaskModel(
      id: 'hks2',
      title: 'Jogging Pagi',
      description: 'Lari pagi di luar rumah. Targetkan 3-5 km untuk kesehatan optimal.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.high,
      iconName: 'directions_run',
      estimatedMinutes: 40,
    ),
    TaskModel(
      id: 'hks3',
      title: 'Swimming Session',
      description: 'Renang adalah olahraga full body yang sangat bagus untuk kesehatan.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.high,
      iconName: 'pool',
      estimatedMinutes: 45,
    ),
    TaskModel(
      id: 'hks4',
      title: 'HIIT Training',
      description: 'High Intensity Interval Training untuk membakar kalori dengan cepat.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.high,
      iconName: 'sports',
      estimatedMinutes: 25,
    ),
    TaskModel(
      id: 'hks5',
      title: 'Cycling',
      description: 'Bersepeda di luar atau stationary bike untuk cardio yang seru.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.high,
      iconName: 'directions_bike',
      estimatedMinutes: 40,
    ),
    TaskModel(
      id: 'hks6',
      title: 'Yoga Intensif',
      description: 'Sesi yoga yang lebih challenging untuk kekuatan dan fleksibilitas.',
      category: TaskCategory.kesehatan,
      energyLevel: EnergyLevel.high,
      iconName: 'self_improvement',
      estimatedMinutes: 45,
    ),

    // ===== TUGAS PEKERJAAN (High) =====
    TaskModel(
      id: 'hpk1',
      title: 'Belajar Intensif',
      description: 'Fokus belajar skill baru dengan konsentrasi penuh. Tidak ada distraksi!',
      category: TaskCategory.pekerjaan,
      energyLevel: EnergyLevel.high,
      iconName: 'school',
      estimatedMinutes: 60,
    ),
    TaskModel(
      id: 'hpk2',
      title: 'Menata Lemari',
      description: 'Rapikan dan kategorikan ulang isi lemari pakaian. Buang yang tidak terpakai.',
      category: TaskCategory.pekerjaan,
      energyLevel: EnergyLevel.high,
      iconName: 'checkroom',
      estimatedMinutes: 45,
    ),
    TaskModel(
      id: 'hpk3',
      title: 'Final Revisi',
      description: 'Selesaikan revisi akhir dari proyek atau tugas. Beri yang terbaik!',
      category: TaskCategory.pekerjaan,
      energyLevel: EnergyLevel.high,
      iconName: 'edit_document',
      estimatedMinutes: 60,
    ),
    TaskModel(
      id: 'hpk4',
      title: 'Menulis Laporan',
      description: 'Buat laporan lengkap dengan data dan analisis. Hasilkan karya terbaik.',
      category: TaskCategory.pekerjaan,
      energyLevel: EnergyLevel.high,
      iconName: 'assignment',
      estimatedMinutes: 60,
    ),
    TaskModel(
      id: 'hpk5',
      title: 'Coding Project',
      description: 'Kembangkan project coding dengan fitur baru. Demo time!',
      category: TaskCategory.pekerjaan,
      energyLevel: EnergyLevel.high,
      iconName: 'code',
      estimatedMinutes: 90,
    ),
    TaskModel(
      id: 'hpk6',
      title: 'Workshop Online',
      description: 'Ikuti workshop intensif untuk upgrade skill. Aktif berinteraksi!',
      category: TaskCategory.pekerjaan,
      energyLevel: EnergyLevel.high,
      iconName: 'computer',
      estimatedMinutes: 60,
    ),

    // ===== TUGAS KREATIVITAS (High) =====
    TaskModel(
      id: 'hkr1',
      title: 'Proyek Seni Kompleks',
      description: 'Buat karya seni yang detail. Lukisan, kolase, atau craft tingkat lanjut.',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.high,
      iconName: 'palette',
      estimatedMinutes: 90,
    ),
    TaskModel(
      id: 'hkr2',
      title: 'Bikin Konten Video',
      description: 'Buat video kreatif untuk YouTube atau TikTok. Edit dengan profesional!',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.high,
      iconName: 'videocam',
      estimatedMinutes: 60,
    ),
    TaskModel(
      id: 'hkr3',
      title: 'Music Recording',
      description: 'Rekam lagu atau instrument baru. Produksi musik dari rumah!',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.high,
      iconName: 'music_note',
      estimatedMinutes: 60,
    ),
    TaskModel(
      id: 'hkr4',
      title: 'Photography Session',
      description: 'Ambil foto dengan tema tertentu. Edit hasilnya untuk portfolio.',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.high,
      iconName: 'camera_alt',
      estimatedMinutes: 45,
    ),
    TaskModel(
      id: 'hkr5',
      title: 'Blog Writing',
      description: 'Tulis artikel blog yang panjang dan informatif. Bangun personal branding!',
      category: TaskCategory.kreativitas,
      energyLevel: EnergyLevel.high,
      iconName: 'article',
      estimatedMinutes: 45,
    ),

    // ===== TUGAS BELAJAR (High) =====
    TaskModel(
      id: 'hbl1',
      title: 'Belajar Skill Baru',
      description: 'Kuasai skill baru dari awal. Ikuti tutorial lengkap dan praktik langsung.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.high,
      iconName: 'school',
      estimatedMinutes: 90,
    ),
    TaskModel(
      id: 'hbl2',
      title: 'Baca Buku Teknis',
      description: 'Baca buku teknis atau non-fiksi yang tebal. Target 5 bab hari ini.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.high,
      iconName: 'menu_book',
      estimatedMinutes: 60,
    ),
    TaskModel(
      id: 'hbl3',
      title: 'Kursus Online Intensif',
      description: 'Selesaikan 2-3 modul course online dalam satu sesi.',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.high,
      iconName: 'online',
      estimatedMinutes: 90,
    ),
    TaskModel(
      id: 'hbl4',
      title: 'Praktik Coding',
      description: 'Build project nyata dengan tutorial. Belajar dengan praktik!',
      category: TaskCategory.belajar,
      energyLevel: EnergyLevel.high,
      iconName: 'computer',
      estimatedMinutes: 60,
    ),

    // ===== TUGAS HUBUNGAN (High) =====
    TaskModel(
      id: 'hhb1',
      title: 'Family Gathering',
      description: 'Adakan kegiatan bersama keluarga. Main game, masak, atau jalan-jalan.',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.high,
      iconName: 'family_restroom',
      estimatedMinutes: 120,
    ),
    TaskModel(
      id: 'hhb2',
      title: 'Reuni Teman',
      description: 'Kumpul dengan teman-teman lama. Ngobrol seru dan update kabar.',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.high,
      iconName: 'groups',
      estimatedMinutes: 120,
    ),
    TaskModel(
      id: 'hhb3',
      title: 'Volunteer Activity',
      description: 'Ikut kegiatan sosial atau volunteer. Bantu orang lain dengan energimu!',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.high,
      iconName: 'volunteer_activism',
      estimatedMinutes: 180,
    ),
    TaskModel(
      id: 'hhb4',
      title: 'Date Night',
      description: 'Luangkan waktu berkualitas dengan pasangan. Makan bersama atau nonton film.',
      category: TaskCategory.hubungan,
      energyLevel: EnergyLevel.high,
      iconName: 'favorite',
      estimatedMinutes: 120,
    ),
  ];

  /// Ambil rekomendasi tugas berdasarkan kategori
  static TaskModel? getRecommendedTask(TaskCategory category) {
    final tasks = allHighTasks
        .where((task) => task.category == category)
        .toList();
    if (tasks.isEmpty) return null;
    return tasks.first;
  }

  /// Ambil tugas alternatif
  static List<TaskModel> getAlternativeTasks(TaskCategory category, {String? excludeTaskId}) {
    return allHighTasks
        .where((task) => task.category == category && task.id != excludeTaskId)
        .toList();
  }

  /// Ambil semua tugas untuk energi tinggi
  static List<TaskModel> getAllTasks() => allHighTasks;

  /// Ambil tugas berdasarkan kategori
  static List<TaskModel> getTasksByCategory(TaskCategory category) {
    return allHighTasks
        .where((task) => task.category == category)
        .toList();
  }
}