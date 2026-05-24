import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/user_model.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;
  const factory LoginState.loading() = LoginLoading;
  const factory LoginState.success(UserModel user) = LoginSuccess;
  const factory LoginState.failure(String message) = LoginFailure;
}