import 'dart:convert';

class TaskResponse {
    final String? message;
    final Data data;

    TaskResponse({
        this.message,
        required this.data,
    });

    factory TaskResponse.fromJson(String str) => TaskResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TaskResponse.fromMap(Map<String, dynamic> json) => TaskResponse(
        message: json["message"],
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "data": data.toMap(),
    };
}

class Data {
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

    Data({
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

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        title: json["title"],
        description: json["description"],
        difficulty: json["difficulty"],
        deadline: json["deadline"],
        isCompleted: json["is_completed"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
