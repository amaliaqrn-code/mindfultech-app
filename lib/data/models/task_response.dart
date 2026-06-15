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
        message: json["message"]?.toString(),
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
