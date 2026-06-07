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

/// Model untuk Tugas
class TaskModel extends Equatable {
  final String id;
  final String namaTugas;
  final TaskCategory kategori;
  final EnergyLevel energi;
  final int estimasiWaktu; // dalam menit
  final TaskPriority prioritas;
  final DateTime createdAt;

  const TaskModel({
    required this.id,
    required this.namaTugas,
    required this.kategori,
    required this.energi,
    required this.estimasiWaktu,
    required this.prioritas,
    required this.createdAt,
  });

  /// Membuat TaskModel dari Map (biasanya dari database)
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      namaTugas: map['namaTugas'] as String,
      kategori: TaskCategoryExtension.fromString(map['kategori'] as String),
      energi: EnergyLevelExtension.fromValue(map['energi'] as int),
      estimasiWaktu: map['estimasiWaktu'] as int,
      prioritas: TaskPriorityExtension.fromValue(map['prioritas'] as int),
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  /// Mengubah TaskModel ke Map untuk disimpan ke database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'namaTugas': namaTugas,
      'kategori': kategori.displayName,
      'energi': energi.value,
      'estimasiWaktu': estimasiWaktu,
      'prioritas': prioritas.value,
      'createdAt': createdAt.toIso8601String(),
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
  }) {
    return TaskModel(
      id: id ?? this.id,
      namaTugas: namaTugas ?? this.namaTugas,
      kategori: kategori ?? this.kategori,
      energi: energi ?? this.energi,
      estimasiWaktu: estimasiWaktu ?? this.estimasiWaktu,
      prioritas: prioritas ?? this.prioritas,
      createdAt: createdAt ?? this.createdAt,
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
      ];
}
