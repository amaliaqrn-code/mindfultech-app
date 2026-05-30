import 'package:equatable/equatable.dart';

/// Enum untuk level energi
enum EnergyLevel { low, medium, high }

/// Enum untuk kategori tugas
enum TaskCategory { rumah, selfCare, belajar, hubungan, kreativitas, kesehatan, pekerjaan }

extension EnergyLevelExtension on EnergyLevel {
  String get displayName {
    switch (this) {
      case EnergyLevel.low:
        return 'Rendah';
      case EnergyLevel.medium:
        return 'Sedang';
      case EnergyLevel.high:
        return 'Tinggi';
    }
  }

  int get value {
    switch (this) {
      case EnergyLevel.low:
        return 0;
      case EnergyLevel.medium:
        return 1;
      case EnergyLevel.high:
        return 2;
    }
  }

  static EnergyLevel fromValue(int value) {
    switch (value) {
      case 0:
        return EnergyLevel.low;
      case 1:
        return EnergyLevel.medium;
      case 2:
        return EnergyLevel.high;
      default:
        return EnergyLevel.low;
    }
  }
}

extension TaskCategoryExtension on TaskCategory {
  String get displayName {
    switch (this) {
      case TaskCategory.rumah:
        return 'Rumah';
      case TaskCategory.selfCare:
        return 'Self Care';
      case TaskCategory.belajar:
        return 'Belajar';
      case TaskCategory.hubungan:
        return 'Hubungan';
      case TaskCategory.kreativitas:
        return 'Kreativitas';
      case TaskCategory.kesehatan:
        return 'Kesehatan';
      case TaskCategory.pekerjaan:
        return 'Pekerjaan';
    }
  }

  String get iconName {
    switch (this) {
      case TaskCategory.rumah:
        return 'home';
      case TaskCategory.selfCare:
        return 'favorite';
      case TaskCategory.belajar:
        return 'menu_book';
      case TaskCategory.hubungan:
        return 'people';
      case TaskCategory.kreativitas:
        return 'palette';
      case TaskCategory.kesehatan:
        return 'accessibility_new';
      case TaskCategory.pekerjaan:
        return 'work';
    }
  }
}

/// Model untuk Tugas
class TaskModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final TaskCategory category;
  final EnergyLevel energyLevel;
  final DateTime? deadline;
  final String? iconName;
  final int estimatedMinutes;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.energyLevel,
    this.deadline,
    this.iconName,
    this.estimatedMinutes = 10,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        energyLevel,
        deadline,
      ];

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    TaskCategory? category,
    EnergyLevel? energyLevel,
    DateTime? deadline,
    String? iconName,
    int? estimatedMinutes,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      energyLevel: energyLevel ?? this.energyLevel,
      deadline: deadline ?? this.deadline,
      iconName: iconName ?? this.iconName,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
    );
  }
}
