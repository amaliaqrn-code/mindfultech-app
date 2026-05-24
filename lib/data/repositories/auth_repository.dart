import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';
import '../models/requests/login_request.dart';
import '../models/requests/register_request.dart';

class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepository({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  // Register new user
  Future<UserModel> register({required RegisterRequest request}) async {
    final response = await _remoteDataSource.register(request: request);

    // Save to local storage
    if (response.token != null) {
      await _localDataSource.saveToken(response.token!);
    }
    if (response.user != null) {
      await _localDataSource.saveUser(response.user!);
      await _localDataSource.setLoggedIn(true);
    }

    return response.user!;
  }

  // Login user
  Future<UserModel> login({required LoginRequest request}) async {
    try {
      final response = await _remoteDataSource.login(request: request);

      // Validate response
      if (response.user == null) {
        throw Exception('Data user tidak valid dari server');
      }
      if (response.token == null || response.token!.isEmpty) {
        throw Exception('Token tidak diterima dari server');
      }

      // Save to local storage
      await _localDataSource.saveToken(response.token!);
      await _localDataSource.saveUser(response.user!);
      await _localDataSource.setLoggedIn(true);

      return response.user!;
    } catch (e) {
      // Re-throw dengan pesan clean
      String message = e.toString();
      if (message.startsWith('Exception: ')) {
        message = message.replaceFirst('Exception: ', '');
      }
      throw Exception(message);
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      await _remoteDataSource.logout();
    } catch (_) {
      // Ignore remote error, clear local anyway
    }
    await _localDataSource.clearAuth();
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return _localDataSource.isLoggedIn();
  }

  // Get current user from local storage
  UserModel? getCurrentUser() {
    return _localDataSource.getUser();
  }

  // Get auth token
  String? getToken() {
    return _localDataSource.getToken();
  }
}