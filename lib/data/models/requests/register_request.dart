import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  const RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }

  @override
  List<Object?> get props => [name, email, password, passwordConfirmation];
}