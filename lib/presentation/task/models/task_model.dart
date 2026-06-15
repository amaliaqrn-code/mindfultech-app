import 'package:equatable/equatable.dart';

/// Enum untuk level energi
enum EnergyLevel { rendah, sedang, tinggi }

/// Enum untuk kategori tugas
enum TaskCategory { belajar, pekerjaan, kesehatan, pribadi, rumah, lainnya }

/// Enum untuk prioritas tugas
enum TaskPriority { mendesak, penting, santai }

extension EnergyLevelExtension on EnergyLevel {
  String get displayName {
    switch (this) {
      case EnergyLevel.rendah: return 'Rendah';
      case EnergyLevel.sedang: return 'Sedang';
      case EnergyLevel.tinggi: return 'Tinggi';
    }
  }

  int get value {
    switch (this) {
      case EnergyLevel.rendah: return 0;
      case EnergyLevel.sedang: return 1;
      case EnergyLevel.tinggi: return 2;
    }
  }

  static EnergyLevel fromValue(int value) {
    switch (value) {
      case 0: return EnergyLevel.rendah;
      case 1: return EnergyLevel.sedang;
      case 2: return EnergyLevel.tinggi;
      default: return EnergyLevel.rendah;
    }
  }
}

extension TaskCategoryExtension on TaskCategory {
  String get displayName {
    switch (this) {
      case TaskCategory.belajar: return 'Belajar';
      case TaskCategory.pekerjaan: return 'Pekerjaan';
      case TaskCategory.kesehatan: return 'Kesehatan';
      case TaskCategory.pribadi: return 'Pribadi';
      case TaskCategory.rumah: return 'Rumah';
      case TaskCategory.lainnya: return 'Lainnya';
    }
  }

  String get iconPath {
    switch (this) {
      case TaskCategory.belajar: return 'assets/icon/kategori/belajar.svg';
      case TaskCategory.pekerjaan: return 'assets/icon/kategori/pekerjaan.svg';
      case TaskCategory.kesehatan: return 'assets/icon/kategori/kesehatan.svg';
      case TaskCategory.pribadi: return 'assets/icon/kategori/pribadi.svg';
      case TaskCategory.rumah: return 'assets/icon/kategori/rumah.svg';
      case TaskCategory.lainnya: return 'assets/icon/kategori/lainnya.svg';
    }
  }

  static TaskCategory fromString(String value) {
    switch (value.toLowerCase()) {
      case 'belajar': return TaskCategory.belajar;
      case 'pekerjaan': return TaskCategory.pekerjaan;
      case 'kesehatan': return TaskCategory.kesehatan;
      case 'pribadi': return TaskCategory.pribadi;
      case 'rumah': return TaskCategory.rumah;
      case 'lainnya': return TaskCategory.lainnya;
      default: return TaskCategory.lainnya;
    }
  }
}

extension TaskPriorityExtension on TaskPriority {
  String get displayName {
    switch (this) {
      case TaskPriority.mendesak: return 'Mendesak';
      case TaskPriority.penting: return 'Penting';
      case TaskPriority.santai: return 'Santai';
    }
  }

  int get value {
    switch (this) {
      case TaskPriority.mendesak: return 0;
      case TaskPriority.penting: return 1;
      case TaskPriority.santai: return 2;
    }
  }

  static TaskPriority fromValue(int value) {
    switch (value) {
      case 0: return TaskPriority.mendesak;
      case 1: return TaskPriority.penting;
      case 2: return TaskPriority.santai;
      default: return TaskPriority.mendesak;
    }
  }
}

/// Default task data helper for fallback recommendations
class DefaultTaskHelper {
  static String getDefaultTaskTitle(EnergyLevel energi, TaskCategory kategori) {
    if (energi == EnergyLevel.rendah) {
      switch (kategori) {
        case TaskCategory.belajar: return 'Baca 1 halaman buku atau artikel edukatif ringan';
        case TaskCategory.pekerjaan: return 'Cek dan rapihkan inbox email atau urutkan to-do list';
        case TaskCategory.kesehatan: return 'Minum satu gelas air putih dan regangkan tangan';
        case TaskCategory.pribadi: return 'Tulis 1 hal yang kamu syukuri hari ini di jurnal';
        case TaskCategory.rumah: return 'Buang sampah atau letakkan baju kotor ke tempatnya';
        case TaskCategory.lainnya: return 'Istirahat tanpa melihat layar smartphone sama sekali';
      }
    }

    if (energi == EnergyLevel.sedang) {
      switch (kategori) {
        case TaskCategory.belajar: return 'Tonton 1 video tutorial atau rangkum materi singkat';
        case TaskCategory.pekerjaan: return 'Balas pesan klien atau cicil dokumen kerjaan ringan';
        case TaskCategory.kesehatan: return 'Latihan napas dalam (deep breathing) atau jalan santai';
        case TaskCategory.pribadi: return 'Lakukan meditasi tenang atau rapikan galeri foto HP';
        case TaskCategory.rumah: return 'Lap meja kerja, cuci piring, atau rapikan kasur';
        case TaskCategory.lainnya: return 'Buat daftar lagu (playlist) santai untuk nemenin hari';
      }
    }

    switch (kategori) {
      case TaskCategory.belajar: return 'Pelajari topik baru yang sulit atau latihan soal';
      case TaskCategory.pekerjaan: return 'Selesaikan tugas utama yang paling menyita otak';
      case TaskCategory.kesehatan: return 'Olahraga ringan, stretching total, atau workout singkat';
      case TaskCategory.pribadi: return 'Evaluasi target mingguan atau rencanakan hobi barumu';
      case TaskCategory.rumah: return 'Sapu dan pel kamar atau tata ulang lemari pakaian';
      case TaskCategory.lainnya: return 'Bereskan satu hal kecil yang terus kamu tunda minggu ini';
    }
  }

  static int getDefaultDuration(EnergyLevel energi) {
    switch (energi) {
      case EnergyLevel.rendah: return 5;
      case EnergyLevel.sedang: return 15;
      case EnergyLevel.tinggi: return 25;
    }
  }

  static TaskModel createDefaultTask({
    required EnergyLevel energi,
    required TaskCategory kategori,
    int? customId,
  }) {
    return TaskModel(
      // 🟢 Karena id bertipe int, kita gunakan milidetik timestamp saat ini sebagai angka ID unik unik
      id: customId ?? DateTime.now().millisecondsSinceEpoch, 
      namaTugas: getDefaultTaskTitle(energi, kategori),
      kategori: kategori,
      energi: energi,
      estimasiWaktu: getDefaultDuration(energi),
      prioritas: TaskPriority.santai,
      createdAt: DateTime.now(),
      isDefault: true,
    );
  }
}

// ==========================================
// PARSING HELPER FUNCTIONS
// ==========================================
int _parseInt(dynamic value, {int defaultValue = 0}) {
  if (value == null) return defaultValue;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value) ?? defaultValue;
  return defaultValue;
}

String _parseString(dynamic value, {String defaultValue = ''}) {
  if (value == null) return defaultValue;
  if (value is String) return value;
  return value.toString();
}

DateTime _parseDateTime(dynamic value, {DateTime? defaultValue}) {
  if (value == null) return defaultValue ?? DateTime.now();
  if (value is DateTime) return value;
  if (value is String) {
    try {
      return DateTime.parse(value);
    } catch (_) {
      return defaultValue ?? DateTime.now();
    }
  }
  return defaultValue ?? DateTime.now();
}

TaskCategory _safeParseKategori(dynamic value) {
  if (value == null) return TaskCategory.lainnya;
  if (value is int) {
    if (value >= 0 && value < TaskCategory.values.length) {
      return TaskCategory.values[value];
    }
    return TaskCategory.lainnya;
  }
  if (value is String) {
    final intValue = int.tryParse(value);
    if (intValue != null && intValue >= 0 && intValue < TaskCategory.values.length) {
      return TaskCategory.values[intValue];
    }
    return TaskCategoryExtension.fromString(value);
  }
  return TaskCategory.lainnya;
}

// ==========================================
// CORE MODEL CLASS
// ==========================================
class TaskModel extends Equatable {
  final int id; // 🟢 SEKARANG SUDAH JADI INT
  final String namaTugas;
  final TaskCategory kategori;
  final EnergyLevel energi;
  final int estimasiWaktu; 
  final TaskPriority prioritas;
  final DateTime createdAt;
  final String? userId; 
  final bool isDefault; 

  const TaskModel({
    required this.id, // 🟢 Tipe data int
    required this.namaTugas,
    required this.kategori,
    required this.energi,
    required this.estimasiWaktu,
    required this.prioritas,
    required this.createdAt,
    this.userId,
    this.isDefault = false,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    // 🟢 Parsing menggunakan _parseInt agar aman dari database/API
    final idValue = _parseInt(map['id']); 
    final isDefaultValue = map['isDefault'] == 1 || map['isDefault'] == true || map['is_default'] == 1 || map['is_default'] == true;

    return TaskModel(
      id: idValue == 0 ? DateTime.now().millisecondsSinceEpoch : idValue,
      namaTugas: _parseString(map['namaTugas'] ?? map['title']),
      kategori: _safeParseKategori(map['kategori'] ?? (map['category_id'] != null ? (_parseInt(map['category_id']) - 1) : null)),
      energi: map['energi'] != null 
          ? EnergyLevelExtension.fromValue(_parseInt(map['energi']))
          : (map['difficulty'] == 'easy' ? EnergyLevel.rendah : map['difficulty'] == 'hard' ? EnergyLevel.tinggi : EnergyLevel.sedang),
      estimasiWaktu: _parseInt(map['estimasiWaktu'] ?? map['duration'], defaultValue: 10),
      prioritas: TaskPriorityExtension.fromValue(_parseInt(map['prioritas'])),
      createdAt: _parseDateTime(map['createdAt'] ?? map['created_at']),
      userId: map['userId'] != null ? _parseString(map['userId']) : (map['user_id'] != null ? _parseString(map['user_id']) : null),
      isDefault: isDefaultValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id, // 🟢 Tulis langsung sebagai integer ke database
      'namaTugas': namaTugas,
      'kategori': kategori.index, 
      'energi': energi.value,
      'estimasiWaktu': estimasiWaktu,
      'prioritas': prioritas.value,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
      'isDefault': isDefault ? 1 : 0,
    };
  }

  Map<String, dynamic> toApiMap({required int userId}) {
    String difficultyLaravel = 'medium';
    if (energi == EnergyLevel.rendah) difficultyLaravel = 'easy';
    if (energi == EnergyLevel.tinggi) difficultyLaravel = 'hard';

    int laravelCategoryId = kategori.index + 1;

    return {
      'id': id, // 🟢 Dikirim sebagai integer ke backend Laravel
      'user_id': userId,
      'category_id': laravelCategoryId, 
      'title': namaTugas,              
      'difficulty': difficultyLaravel,
      'is_completed': 0,
      'is_default': isDefault ? 1 : 0,
    };
  }

  TaskModel copyWith({
    int? id, // 🟢 SEKARANG KONSISTEN MENGGUNAKAN INT?
    String? namaTugas,
    TaskCategory? kategori,
    EnergyLevel? energi,
    int? estimasiWaktu,
    TaskPriority? prioritas,
    DateTime? createdAt,
    String? userId,
    bool? isDefault,
  }) {
    return TaskModel(
      id: id ?? this.id, // 🟢 Sempurna, int ketemu int!
      namaTugas: namaTugas ?? this.namaTugas,
      kategori: kategori ?? this.kategori,
      energi: energi ?? this.energi,
      estimasiWaktu: estimasiWaktu ?? this.estimasiWaktu,
      prioritas: prioritas ?? this.prioritas,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  String get formattedDuration => '$estimasiWaktu Menit Fokus';

  @override
  List<Object?> get props => [
        id,
        namaTugas,
        kategori,
        energi,
        estimasiWaktu,
        prioritas,
        createdAt,
        userId,
        isDefault,
      ];
}