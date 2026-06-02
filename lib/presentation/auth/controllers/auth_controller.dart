import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/data/repositories/auth_repository.dart';

/// 🔥 AUTH CONTROLLER - Authentication Flow Management
///
/// Bertugas mengelola seluruh alur autentikasi:
/// - Auto-login check saat startup
/// - Login & simpan token
/// - Logout & hapus token
/// - Cek status login
///
/// Menggunakan GetX untuk state management dan navigasi
class AuthController extends GetxController {
  final AuthRepository _authRepository;
  final AuthLocalDataSource _authLocalDataSource = AuthLocalDataSource();

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  // Reactive state
  final RxBool isLoggedIn = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  /// 🔥 CEK STATUS LOGIN SAAT STARTUP
  /// Dipanggil saat app pertama kali dibuka
  void _checkLoginStatus() {
    isLoggedIn.value = _authLocalDataSource.isLoggedIn();
    debugPrint('🔐 AuthController: isLoggedIn = ${isLoggedIn.value}');
  }

  /// 🔥 FUNGSI LOGIN
  /// Called setelah user berhasil login dari login page
  /// Menyimpan token dan update status login
  Future<void> onLoginSuccess() async {
    try {
      isLoading.value = true;

      // Simpan status logged in
      await _authLocalDataSource.setLoggedIn(true);

      // Update reactive state
      isLoggedIn.value = true;

      debugPrint('✅ AuthController: Login successful, token saved');

      // Navigate ke Homepage
      Get.offAllNamed(AppRoutes.homepage);
    } catch (e) {
      debugPrint('❌ AuthController: Error saving login state - $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔥 FUNGSI LOGOUT
  /// Menghapus semua data autentikasi dan redirect ke Login
  ///
  /// Steps:
  /// 1. Hapus token dari storage
  /// 2. Hapus data user
  /// 3. Set status logged in = false
  /// 4. Navigate ke Login page
  Future<void> logout() async {
    try {
      isLoading.value = true;
      debugPrint('🔄 AuthController: Starting logout process...');

      // Panggil repository untuk logout (bisa juga call API /logout)
      await _authRepository.logout();

      // Clear local auth data
      await _authLocalDataSource.clearAuth();

      // Update reactive state
      isLoggedIn.value = false;

      debugPrint('✅ AuthController: Logout successful, cleared all auth data');

      // Navigate ke Login page
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      debugPrint('❌ AuthController: Logout error - $e');
      // Tetap clear local meskipun error
      await _authLocalDataSource.clearAuth();
      isLoggedIn.value = false;
      Get.offAllNamed(AppRoutes.login);
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔥 CEK APAKAH USER SUDAH LOGIN (untuk use di widget)
  bool get checkIsLoggedIn => _authLocalDataSource.isLoggedIn();

  /// 🔥 AMBIL TOKEN (untuk API calls)
  String? get currentToken => _authLocalDataSource.getToken();
}