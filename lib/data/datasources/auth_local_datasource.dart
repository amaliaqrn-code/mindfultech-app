import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';

class AuthLocalDataSource {
  final GetStorage _storage = GetStorage();

  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';

  // Save auth token
  Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
  }

  // Get auth token
  String? getToken() {
    return _storage.read(_tokenKey);
  }

  // Save user data
  Future<void> saveUser(UserModel user) async {
    await _storage.write(_userKey, user.toJson());
  }

  // Get saved user
  UserModel? getUser() {
    final userData = _storage.read(_userKey);
    if (userData != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(userData));
    }
    return null;
  }

  // Set logged in status
  Future<void> setLoggedIn(bool isLoggedIn) async {
    await _storage.write(_isLoggedInKey, isLoggedIn);
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return _storage.read(_isLoggedInKey) ?? false;
  }

  // Clear all auth data (logout)
  Future<void> clearAuth() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_userKey);
    await _storage.write(_isLoggedInKey, false);
  }
}
