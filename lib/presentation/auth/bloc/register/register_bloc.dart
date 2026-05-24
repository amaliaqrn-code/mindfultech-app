import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/models/requests/register_request.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;

  RegisterBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const RegisterInitial()) {
    on<RegisterNameChanged>((event, emit) {});
    on<RegisterEmailChanged>((event, emit) {});
    on<RegisterPasswordChanged>((event, emit) {});
    on<RegisterConfirmPasswordChanged>((event, emit) {});
    on<RegisterSubmitted>(_onSubmitted);
    on<RegisterReset>(_onReset);
  }

  Future<void> _onSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {
    // Validate password confirmation
    if (event.password != event.confirmPassword) {
      emit(const RegisterFailure('Konfirmasi password tidak cocok'));
      return;
    }

    emit(const RegisterLoading());
    try {
      final request = RegisterRequest(
        name: event.name.trim(),
        email: event.email.trim(),
        password: event.password,
        passwordConfirmation: event.confirmPassword,
      );
      final user = await _authRepository.register(request: request);
      emit(RegisterSuccess(user));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

  void _onReset(RegisterReset event, Emitter<RegisterState> emit) {
    emit(const RegisterInitial());
  }
}