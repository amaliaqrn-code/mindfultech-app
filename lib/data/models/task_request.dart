import 'package:mindfultech_app/presentation/task/models/task_model.dart';

// / DTO untuk Request membuat task ke Laravel API
// / Struktur JSON yang diharapkan Laravel:
// / {
// /   "user_id": int,
// /   "category_id": int, // Nilai 1-6
// /   "title": string,
// /   "description": string (nullable),
// /   "difficulty": string // 'easy', 'medium', atau 'hard'
// / }
class TaskRequest {
  final int userId;
  final int categoryId; // 1-6 (category.index + 1)
  final String title;
  final String? description;
  final String difficulty; // 'easy', 'medium', 'hard'

  const TaskRequest({
    required this.userId,
    required this.categoryId,
    required this.title,
    this.description,
    required this.difficulty,
  });

  /// Buat TaskRequest dari TaskModel Flutter
  factory TaskRequest.fromTaskModel(TaskModel task, {required int userId}) {
    // Konversi EnergyLevel Flutter ke difficulty string Laravel
    String difficulty;
    switch (task.energi) {
      case EnergyLevel.rendah:
        difficulty = 'easy';
      case EnergyLevel.sedang:
        difficulty = 'medium';
      case EnergyLevel.tinggi:
        difficulty = 'hard';
    }

    // Konversi kategori: index enum (0-5) + 1 = ID Laravel (1-6)
    // urutan enum: [belajar=1, pekerjaan=2, kesehatan=3, pribadi=4, rumah=5, lainnya=6]
    final categoryId = task.kategori.index + 1;

    return TaskRequest(
      userId: userId,
      categoryId: categoryId,
      title: task.namaTugas,
      description: null, // TaskModel tidak punya description field
      difficulty: difficulty,
    );
  }

  /// Konversi ke Map/JSON untuk dikirim ke API
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'category_id': categoryId,
      'title': title,
      if (description != null) 'description': description,
      'difficulty': difficulty,
    };
  }

  @override
  String toString() => 'TaskRequest(userId: $userId, categoryId: $categoryId, title: $title, difficulty: $difficulty)';
}