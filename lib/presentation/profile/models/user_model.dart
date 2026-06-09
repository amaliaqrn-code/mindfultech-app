class UserModel {
  int id;
  String name;
  String username;
  String gender;
  String phone;
  String email;
  String? imagePath;
  String? createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.gender,
    required this.phone,
    required this.email,
    this.imagePath,
    this.createdAt,
  });

  /// Buat UserModel dari JSON (API response)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      gender: json['gender'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      imagePath: json['image_path'] ?? json['imagePath'],
      createdAt: json['created_at'],
    );
  }

  /// Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'gender': gender,
      'phone': phone,
      'email': email,
      'image_path': imagePath,
      'created_at': createdAt,
    };
  }

  /// Copy with
  UserModel copyWith({
    int? id,
    String? name,
    String? username,
    String? gender,
    String? phone,
    String? email,
    String? imagePath,
    String? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}