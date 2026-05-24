import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.freezed.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.nameChanged(String name) = RegisterNameChanged;
  const factory RegisterEvent.emailChanged(String email) = RegisterEmailChanged;
  const factory RegisterEvent.passwordChanged(String password) = RegisterPasswordChanged;
  const factory RegisterEvent.confirmPasswordChanged(String confirmPassword) = RegisterConfirmPasswordChanged;
  const factory RegisterEvent.submitted({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) = RegisterSubmitted;
  const factory RegisterEvent.reset() = RegisterReset;
}