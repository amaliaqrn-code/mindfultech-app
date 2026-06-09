import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? username;  // 🟢 Tambahan (bisa null)
  final String? gender;    // 🟢 Tambahan (bisa null)
  final String? phone;     // 🟢 Tambahan (bisa null)
  final String? imagePath; // 🟢 Tambahan (bisa null)
  final String? createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.username,
    this.gender,
    this.phone,
    this.imagePath,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      username: json['username'],
      gender: json['gender'],
      phone: json['phone'],
      imagePath: json['image_path'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'gender': gender,
      'phone': phone,
      'image_path': imagePath,
      'created_at': createdAt,
    };
  }

  @override
  List<Object?> get props 
  => [id, name, email, username, gender, phone, imagePath, createdAt];
}