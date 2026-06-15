import 'dart:convert';

/// Model response untuk Create Task API
/// Struktur JSON dari Laravel:
/// {
///   "message": "Task created successfully",
///   "data": {
///     "id": int,
///     "user_id": int,
///     "category_id": int,
///     "title": string,
///     "description": string|null,
///     "difficulty": string,
///     "deadline": string|null,
///     "is_completed": int,
///     "created_at": string,
///     "updated_at": string
///   }
/// }
class CreateTaskResponseModel {
  final String? message;
  final CreateTaskData data;

  CreateTaskResponseModel({
    this.message,
    required this.data,
  });

  factory CreateTaskResponseModel.fromJson(String str) =>
      CreateTaskResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateTaskResponseModel.fromMap(Map<String, dynamic> json) =>
      CreateTaskResponseModel(
        message: json["message"]?.toString(),
        data: CreateTaskData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": data.toMap(),
      };
}

/// Data class untuk task yang baru dibuat
class CreateTaskData {
  final int id;
  final int? userId;
  final int? categoryId;
  final String title;
  final String? description;
  final String? difficulty;
  final String? deadline;
  final int? isCompleted;
  final String? createdAt;
  final String? updatedAt;

  CreateTaskData({
    required this.id,
    this.userId,
    this.categoryId,
    required this.title,
    this.description,
    this.difficulty,
    this.deadline,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateTaskData.fromJson(String str) =>
      CreateTaskData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateTaskData.fromMap(Map<String, dynamic> json) => CreateTaskData(
        id: json["id"] is int ? json["id"] : int.tryParse('${json["id"]}') ?? 0,
        userId: json["user_id"] is int ? json["user_id"] : int.tryParse('${json["user_id"]}'),
        categoryId: json["category_id"] is int ? json["category_id"] : int.tryParse('${json["category_id"]}'),
        title: json["title"]?.toString() ?? '',
        description: json["description"]?.toString(),
        difficulty: json["difficulty"]?.toString(),
        deadline: json["deadline"]?.toString(),
        isCompleted: json["is_completed"] is int ? json["is_completed"] : int.tryParse('${json["is_completed"]}'),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "category_id": categoryId,
        "title": title,
        "description": description,
        "difficulty": difficulty,
        "deadline": deadline,
        "is_completed": isCompleted,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}