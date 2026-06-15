import 'package:equatable/equatable.dart';
import 'user_model.dart';

class AuthResponse extends Equatable {
  final String message;
  final UserModel? user;
  final String? token;

  const AuthResponse({
    required this.message,
    this.user,
    this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json['message']?.toString() ?? '',
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      token: json['token']?.toString(),
    );
  }

  @override
  List<Object?> get props => [message, user, token];
}