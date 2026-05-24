import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/models/requests/login_request.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginInitial()) {
    on<LoginEmailChanged>((event, emit) {});
    on<LoginPasswordChanged>((event, emit) {});
    on<LoginSubmitted>(_onSubmitted);
    on<LoginReset>(_onReset);
  }

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state is LoginLoading) return;

    debugPrint('=== LOGIN DEBUG ===');
    debugPrint('Email: ${event.email}');

    emit(const LoginLoading());
    try {
      final request = LoginRequest(
        email: event.email.trim(),
        password: event.password,
      );
      debugPrint('Sending login request...');

      final user = await _authRepository.login(request: request).timeout(
        const Duration(seconds: 20),
        onTimeout: () => throw Exception('Koneksi timeout. Server tidak merespons.'),
      );

      debugPrint('Login success! User: ${user.name}');
      emit(LoginSuccess(user));
    } catch (e) {
      debugPrint('Login error: $e');
      String message = e.toString();
      if (message.startsWith('Exception: ')) {
        message = message.replaceFirst('Exception: ', '');
      }
      emit(LoginFailure(message));
    }
  }

  void _onReset(LoginReset event, Emitter<LoginState> emit) {
    emit(const LoginInitial());
  }
}