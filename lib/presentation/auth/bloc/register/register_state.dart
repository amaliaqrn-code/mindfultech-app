import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/user_model.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = RegisterInitial;
  const factory RegisterState.loading() = RegisterLoading;
  const factory RegisterState.success(UserModel user) = RegisterSuccess;
  const factory RegisterState.failure(String message) = RegisterFailure;
}