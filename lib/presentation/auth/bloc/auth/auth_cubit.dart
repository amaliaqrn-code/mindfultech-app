import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/data/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final AuthLocalDataSource _authLocalDataSource = AuthLocalDataSource();

  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    checkLoginStatus();
  }

  void checkLoginStatus() {
    final isLoggedIn = _authLocalDataSource.isLoggedIn();
    debugPrint('🔐 AuthCubit: isLoggedIn = $isLoggedIn');
    if (isLoggedIn) {
      final token = _authLocalDataSource.getToken();
      emit(Authenticated(token));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> onLoginSuccess() async {
    try {
      emit(AuthLoading());
      await _authLocalDataSource.setLoggedIn(true);
      final token = _authLocalDataSource.getToken();
      debugPrint('✅ AuthCubit: Login successful, token saved');
      emit(Authenticated(token));
    } catch (e) {
      debugPrint('❌ AuthCubit: Error saving login state - $e');
      emit(Unauthenticated());
    }
  }

  Future<void> logout() async {
    try {
      print('STEP 1');

      emit(AuthLoading());

      try {
        await _authRepository.logout();
      } catch (e) {
        print('STEP 2 API ERROR');
      }

      print('STEP 3 BEFORE CLEAR');

      await _authLocalDataSource.clearAuth();

      print('STEP 4 AFTER CLEAR');

      emit(Unauthenticated());

      print('STEP 5 EMIT UNAUTH');
    } catch (e) {
      print('LOGOUT ERROR: $e');
    }
  }

  bool get checkIsLoggedIn => _authLocalDataSource.isLoggedIn();
  String? get currentToken => _authLocalDataSource.getToken();
}
