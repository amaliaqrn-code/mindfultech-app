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
      emit(AuthLoading());
      debugPrint('🔄 AuthCubit: Starting logout process...');
      await _authRepository.logout();
      await _authLocalDataSource.clearAuth();
      debugPrint('✅ AuthCubit: Logout successful, cleared all auth data');
      emit(Unauthenticated());
    } catch (e) {
      debugPrint('❌ AuthCubit: Logout error - $e');
      await _authLocalDataSource.clearAuth();
      emit(Unauthenticated());
    }
  }

  bool get checkIsLoggedIn => _authLocalDataSource.isLoggedIn();
  String? get currentToken => _authLocalDataSource.getToken();
}
