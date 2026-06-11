import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Enum untuk level energi
enum EnergyLevel { rendah, sedang, tinggi }

/// Enum untuk kategori tugas
enum TaskCategory { belajar, pekerjaan, kesehatan, pribadi, rumah, lainnya }

/// Enum untuk prioritas tugas
enum TaskPriority { mendesak, penting, santai }

extension EnergyLevelExtension on EnergyLevel {
  String get displayName {
    switch (this) {
      case EnergyLevel.rendah:
        return 'Rendah';
      case EnergyLevel.sedang:
        return 'Sedang';
      case EnergyLevel.tinggi:
        return 'Tinggi';
    }
  }

  int get value {
    switch (this) {
      case EnergyLevel.rendah:
        return 0;
      case EnergyLevel.sedang:
        return 1;
      case EnergyLevel.tinggi:
        return 2;
    }
  }

  static EnergyLevel fromValue(int value) {
    switch (value) {
      case 0:
        return EnergyLevel.rendah;
      case 1:
        return EnergyLevel.sedang;
      case 2:
        return EnergyLevel.tinggi;
      default:
        return EnergyLevel.rendah;
    }
  }
}

extension TaskCategoryExtension on TaskCategory {
  String get displayName {
    switch (this) {
      case TaskCategory.belajar:
        return 'Belajar';
      case TaskCategory.pekerjaan:
        return 'Pekerjaan';
      case TaskCategory.kesehatan:
        return 'Kesehatan';
      case TaskCategory.pribadi:
        return 'Pribadi';
      case TaskCategory.rumah:
        return 'Rumah';
      case TaskCategory.lainnya:
        return 'Lainnya';
    }
  }

  IconData get icon {
    switch (this) {
      case TaskCategory.belajar:
        return Icons.menu_book_rounded;
      case TaskCategory.pekerjaan:
        return Icons.work_rounded;
      case TaskCategory.kesehatan:
        return Icons.favorite_rounded;
      case TaskCategory.pribadi:
        return Icons.person_rounded;
      case TaskCategory.rumah:
        return Icons.home_rounded;
      case TaskCategory.lainnya:
        return Icons.auto_awesome_rounded;
    }
  }

  Color get color {
    switch (this) {
      case TaskCategory.belajar:
        return const Color(0xFF4597E6);
      case TaskCategory.pekerjaan:
        return const Color(0xFF7B68EE);
      case TaskCategory.kesehatan:
        return const Color(0xFFFF6B6B);
      case TaskCategory.pribadi:
        return const Color(0xFFFF9F43);
      case TaskCategory.rumah:
        return const Color(0xFF26DE81);
      case TaskCategory.lainnya:
        return const Color(0xFFA55EEA);
    }
  }

  static TaskCategory fromString(String value) {
    switch (value) {
      case 'Belajar':
        return TaskCategory.belajar;
      case 'Pekerjaan':
        return TaskCategory.pekerjaan;
      case 'Kesehatan':
        return TaskCategory.kesehatan;
      case 'Pribadi':
        return TaskCategory.pribadi;
      case 'Rumah':
        return TaskCategory.rumah;
      case 'Lainnya':
        return TaskCategory.lainnya;
      default:
        return TaskCategory.lainnya;
    }
  }
}

extension TaskPriorityExtension on TaskPriority {
  String get displayName {
    switch (this) {
      case TaskPriority.mendesak:
        return 'Mendesak';
      case TaskPriority.penting:
        return 'Penting';
      case TaskPriority.santai:
        return 'Santai';
    }
  }

  int get value {
    switch (this) {
      case TaskPriority.mendesak:
        return 0;
      case TaskPriority.penting:
        return 1;
      case TaskPriority.santai:
        return 2;
    }
  }

  static TaskPriority fromValue(int value) {
    switch (value) {
      case 0:
        return TaskPriority.mendesak;
      case 1:
        return TaskPriority.penting;
      case 2:
        return TaskPriority.santai;
      default:
        return TaskPriority.mendesak;
    }
  }
}

/// Default task data helper for fallback recommendations
class DefaultTaskHelper {
  /// Get default task title based on energy level and category
  static String getDefaultTaskTitle(EnergyLevel energi, TaskCategory kategori) {
    // Low energy (rendah) - 5 minutes tasks
    if (energi == EnergyLevel.rendah) {
      switch (kategori) {
        case TaskCategory.belajar:
          return 'Baca 1 halaman buku atau artikel edukatif ringan';
        case TaskCategory.pekerjaan:
          return 'Cek dan rapihkan inbox email atau urutkan to-do list';
        case TaskCategory.kesehatan:
          return 'Minum satu gelas air putih dan regangkan tangan';
        case TaskCategory.pribadi:
          return 'Tulis 1 hal yang kamu syukuri hari ini di jurnal';
        case TaskCategory.rumah:
          return 'Buang sampah atau letakkan baju kotor ke tempatnya';
        case TaskCategory.lainnya:
          return 'Istirahat tanpa melihat layar smartphone sama sekali';
      }
    }

    // Medium energy (sedang) - 10-15 minutes tasks
    if (energi == EnergyLevel.sedang) {
      switch (kategori) {
        case TaskCategory.belajar:
          return 'Tonton 1 video tutorial atau rangkum materi singkat';
        case TaskCategory.pekerjaan:
          return 'Balas pesan klien atau cicil dokumen kerjaan ringan';
        case TaskCategory.kesehatan:
          return 'Latihan napas dalam (deep breathing) atau jalan santai';
        case TaskCategory.pribadi:
          return 'Lakukan meditasi tenang atau rapikan galeri foto HP';
        case TaskCategory.rumah:
          return 'Lap meja kerja, cuci piring, atau rapikan kasur';
        case TaskCategory.lainnya:
          return 'Buat daftar lagu (playlist) santai untuk nemenin hari';
      }
    }

    // High energy (tinggi) - 15-30 minutes tasks
    // Default case for tinggi
    switch (kategori) {
      case TaskCategory.belajar:
        return 'Pelajari topik baru yang sulit atau latihan soal';
      case TaskCategory.pekerjaan:
        return 'Selesaikan tugas utama yang paling menyita otak';
      case TaskCategory.kesehatan:
        return 'Olahraga ringan, stretching total, atau workout singkat';
      case TaskCategory.pribadi:
        return 'Evaluasi target mingguan atau rencanakan hobi barumu';
      case TaskCategory.rumah:
        return 'Sapu dan pel kamar atau tata ulang lemari pakaian';
      case TaskCategory.lainnya:
        return 'Bereskan satu hal kecil yang terus kamu tunda minggu ini';
    }
  }

  /// Get default duration based on energy level
  static int getDefaultDuration(EnergyLevel energi) {
    switch (energi) {
      case EnergyLevel.rendah:
        return 5;
      case EnergyLevel.sedang:
        return 15;
      case EnergyLevel.tinggi:
        return 25;
    }
  }

  /// Create a default TaskModel based on energy level and category
  static TaskModel createDefaultTask({
    required EnergyLevel energi,
    required TaskCategory kategori,
    String? customId,
  }) {
    return TaskModel(
      id: customId ?? 'default_${energi.name}_${kategori.name}_${DateTime.now().millisecondsSinceEpoch}',
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

/// Fungsi helper untuk parsing int yang aman
int _parseInt(dynamic value, {int defaultValue = 0}) {
  if (value == null) return defaultValue;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value) ?? defaultValue;
  return defaultValue;
}

/// Fungsi helper untuk parsing string yang aman
String _parseString(dynamic value, {String defaultValue = ''}) {
  if (value == null) return defaultValue;
  if (value is String) return value;
  return value.toString();
}

/// Fungsi helper untuk parsing DateTime yang aman
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

/// Fungsi helper untuk parsing kategori yang aman
/// Bisa menerima String (displayName) atau int (value) dari database/API
TaskCategory _safeParseKategori(dynamic value) {
  if (value == null) return TaskCategory.lainnya;

  // Jika berupa int, coba parse sebagai value
  if (value is int) {
    if (value >= 0 && value <= 5) {
      return TaskCategory.values[value];
    }
    return TaskCategory.lainnya;
  }

  // Jika berupa String, gunakan fromString
  if (value is String) {
    // Coba parse sebagai int terlebih dahulu
    final intValue = int.tryParse(value);
    if (intValue != null && intValue >= 0 && intValue <= 5) {
      return TaskCategory.values[intValue];
    }
    // Gunakan fromString untuk displayName
    return TaskCategoryExtension.fromString(value);
  }

  return TaskCategory.lainnya;
}

/// Model untuk Tugas
class TaskModel extends Equatable {
  final String id;
  final String namaTugas;
  final TaskCategory kategori;
  final EnergyLevel energi;
  final int estimasiWaktu; // dalam menit
  final TaskPriority prioritas;
  final DateTime createdAt;
  final String? userId; // User ID untuk multi-user isolation
  final bool isDefault; // Flag untuk default system tasks

  const TaskModel({
    required this.id,
    required this.namaTugas,
    required this.kategori,
    required this.energi,
    required this.estimasiWaktu,
    required this.prioritas,
    required this.createdAt,
    this.userId,
    this.isDefault = false,
  });

  /// Membuat TaskModel dari Map (biasanya dari database)
  /// Menggunakan parsing yang aman untuk menangani data dari berbagai sumber
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    // Parse energi - bisa berupa int atau String dari database/API
    final energiValue = _parseInt(map['energi']);
    // Parse prioritas - bisa berupa int atau String dari database/API
    final prioritasValue = _parseInt(map['prioritas']);
    // Parse estimasiWaktu - bisa berupa int atau String dari database/API
    final estimasiValue = _parseInt(map['estimasiWaktu'], defaultValue: 10);
    // Parse kategori - bisa berupa String (displayName) atau int dari database/API
    final kategoriValue = _safeParseKategori(map['kategori']);
    // Parse id - pastikan string
    final idValue = _parseString(map['id']);
    // Parse namaTugas - pastikan string
    final namaTugasValue = _parseString(map['namaTugas']);
    // Parse createdAt - handle berbagai format tanggal
    final createdAtValue = _parseDateTime(map['createdAt']);
    // Parse userId - nullable, untuk multi-user isolation
    final userIdValue = map['userId'] != null ? _parseString(map['userId']) : null;
    // Parse isDefault - boolean flag untuk default tasks
    final isDefaultValue = map['isDefault'] == 1 || map['isDefault'] == true;

    return TaskModel(
      id: idValue.isEmpty ? DateTime.now().millisecondsSinceEpoch.toString() : idValue,
      namaTugas: namaTugasValue,
      kategori: kategoriValue,
      energi: EnergyLevelExtension.fromValue(energiValue),
      estimasiWaktu: estimasiValue,
      prioritas: TaskPriorityExtension.fromValue(prioritasValue),
      createdAt: createdAtValue,
      userId: userIdValue?.isNotEmpty == true ? userIdValue : null,
      isDefault: isDefaultValue,
    );
  }

  /// Mengubah TaskModel ke Map untuk disimpan ke database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
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

  //// Mengubah data Task ke format JSON yang dimengerti oleh API Laravel
  Map<String, dynamic> toApiMap({required int userId}) {
    // 1. Konversi Energi Level Flutter ke String Difficulty Laravel
    String difficultyLaravel = 'medium';
    if (energi == EnergyLevel.rendah) difficultyLaravel = 'easy';
    if (energi == EnergyLevel.tinggi) difficultyLaravel = 'hard';

    // 2. Ambil ID Kategori secara dinamis berdasarkan index enum + 1
    // Contoh: Jika user milih 'rumah' (index 0), maka laravelCategoryId = 1
    int laravelCategoryId = kategori.index + 1;

    return {
      'user_id': userId,
      'category_id': laravelCategoryId, // 🟢 ID Dinamis 1 sampai 6 aman!
      'title': namaTugas,               // Sesuaikan dengan nama variabel properti tugasmu
      'difficulty': difficultyLaravel,
      'is_completed': 0,
      'is_default': isDefault ? 1 : 0,
    };
  }

  /// Membuat salinan dengan data yang diperbarui
  TaskModel copyWith({
    String? id,
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
      id: id ?? this.id,
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

  /// Format estimasi waktu untuk tampilan
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
