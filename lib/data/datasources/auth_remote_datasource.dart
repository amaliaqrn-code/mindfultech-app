import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../models/auth_response.dart';
import '../models/requests/login_request.dart';
import '../models/requests/register_request.dart';

class AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSource(this._dioClient);

  // Register new user
  Future<AuthResponse> register({required RegisterRequest request}) async {
    try {
      final response = await _dioClient.post(
        '/register',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Login user
  Future<AuthResponse> login({required LoginRequest request}) async {
    try {
      final response = await _dioClient.post(
        '/login',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      await _dioClient.post('/logout');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Handle Dio errors
  String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return 'Koneksi timeout. Pastikan server aktif dan coba lagi.';
    }
    if (e.type == DioExceptionType.connectionError) {
      return 'Tidak bisa terhubung ke server. Periksa koneksi internet.';
    }
    if (e.response != null) {
      final data = e.response!.data;
      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }
      // Handle validation errors
      if (data is Map && data['errors'] != null) {
        final errors = data['errors'] as Map<String, dynamic>;
        final firstError = errors.values.first;
        if (firstError is List && firstError.isNotEmpty) {
          return firstError.first.toString();
        }
      }
    }
    return 'Terjadi kesalahan. Silakan coba lagi.';
  }
}
