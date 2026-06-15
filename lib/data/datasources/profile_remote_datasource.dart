import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mindfultech_app/core/network/dio_client.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/data/models/user_model.dart';

/// Remote Data Source untuk Profile
/// Mengikuti pola yang sama dengan AuthRemoteDataSource
class ProfileRemoteDataSource {
  final DioClient _dioClient;
  final AuthLocalDataSource _localDataSource;

  ProfileRemoteDataSource(this._dioClient)
    : _localDataSource = AuthLocalDataSource();

  // ============================================================
  // HELPER - Ambil Bearer Token
  // ============================================================

  /// Ambil token dari local storage dan buat header options
  Future<Options> _getAuthOptions() async {
    final token = _localDataSource.getToken();

    if (kDebugMode) {
      print('=== PROFILE API DEBUG ===');
      print(
        'Token: ${token != null ? "ADA (${token.substring(0, 10)}...)" : "TIDAK ADA"}',
      );
    }

    return Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
  }

  // ============================================================
  // UPDATE PROFILE - Update data profil user
  // ============================================================

  /// Update profile user
  /// Endpoint: PUT /api/profile
  /// ⚠️ Password TIDAK di-parse/dikirim ke server demi keamanan
  Future<UserModel> updateProfile({
    String? name,
    String? username,
    String? phone,
    String? gender,
  }) async {
    try {
      final options = await _getAuthOptions();

      if (kDebugMode) {
        print('=== UPDATE PROFILE API DEBUG ===');
        print('PUT /profile');
        print('Data Payload:');
        print('  - name: $name');
        print('  - username: $username');
        print('  - phone: $phone');
        print('  - gender: $gender');
        print('  - password: TIDAK DIKIRIM (keamanan)');
        print('==================================');
      }

      // ⚠️ PERHATIAN: Password TIDAK dikirim ke server
      // Jika user tidak mengisi field password, Laravel tidak mengubah password lama
      final response = await _dioClient.put(
        '/profile',
        data: {
          'name': name,
          'username': username,
          'phone': phone,
          'gender': gender,
          // 'password' dihilangkan - tidak perlu di-update di sini
        },
        options: options,
      );
      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE DATA: ${response.data}");

      if (kDebugMode) {
        print('✅ Laravel Response: ${response.data}');
      }

      // Laravel biasanya mengembalikan {'user': {...}} atau {'data': {...}}
      final updatedUser = _parseUserFromResponse(response.data);

      if (kDebugMode) {
        print('✅ Profile Updated Successfully');
        print('    User ID: ${updatedUser.id}');
        print('    Name: ${updatedUser.name}');
        print('    Email: ${updatedUser.email}');
      }

      return updatedUser;
    } on DioException catch (e) {
      // Debug: Print response Laravel jika gagal
      if (kDebugMode) {
        print('❌ Error Laravel: ${e.response?.data}');
      }
      _printError('UPDATE PROFILE', e);
      throw _handleError(e);
    }
  }

  // ============================================================
  // GET PROFILE - Ambil data profil user
  // ============================================================

  /// Ambil data profile user dari server
  /// Endpoint: GET /api/profile
  Future<UserModel> getProfile() async {
    try {
      final options = await _getAuthOptions();

      if (kDebugMode) {
        print('GET /profile');
      }

      final response = await _dioClient.get('/profile', options: options);

      if (kDebugMode) {
        print('Response: ${response.data}');
      }

      return _parseUserFromResponse(response.data);
    } on DioException catch (e) {
      _printError('GET PROFILE', e);
      throw _handleError(e);
    }
  }

  // ============================================================
  // UPLOAD PHOTO - Upload foto profil
  // ============================================================

  /// Upload foto profile
  /// Endpoint: POST /api/profile/photo
  Future<String> uploadProfilePhoto(File imageFile) async {
    try {
      final options = await _getAuthOptions();

      if (kDebugMode) {
        print('POST /profile/photo');
        print('File: ${imageFile.path}');
      }

      final fileName = imageFile.path.split('/').last;
      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await _dioClient.put(
        '/profile/photo',
        data: formData,
        options: options,
      );

      if (kDebugMode) {
        print('Upload Response: ${response.data}');
      }

      // Parse response - biasanya mengembalikan URL foto
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        if (data.containsKey('photo_url')) {
          return data['photo_url'] as String;
        }
        if (data.containsKey('image_path')) {
          return data['image_path'] as String;
        }
        if (data.containsKey('data') && data['data'] is Map) {
          final innerData = data['data'] as Map<String, dynamic>;
          return innerData['photo_url'] ?? innerData['image_path'] ?? '';
        }
      }

      return '';
    } on DioException catch (e) {
      _printError('UPLOAD PHOTO', e);
      throw _handleError(e);
    }
  }

  // ============================================================
  // PARSE RESPONSE - Parse UserModel dari response Laravel
  // ============================================================

  /// Parse UserModel dari response Laravel
  UserModel _parseUserFromResponse(dynamic responseData) {
    Map<String, dynamic> userData;

    if (responseData is Map<String, dynamic>) {
      // Cek format {'user': {...}}
      if (responseData.containsKey('user')) {
        userData = responseData['user'] as Map<String, dynamic>;
      }
      // Cek format {'data': {...}}
      else if (responseData.containsKey('data') &&
          responseData['data'] is Map) {
        userData = responseData['data'] as Map<String, dynamic>;
      }
      // Langsung parse jika response adalah user object
      else if (responseData.containsKey('id') ||
          responseData.containsKey('email')) {
        userData = responseData;
      } else {
        throw Exception('Format response tidak dikenali');
      }
    } else {
      throw Exception('Response bukan Map');
    }

    return UserModel.fromJson(userData);
  }

  // ============================================================
  // ERROR HANDLING - Helper untuk menangani DioException
  // ============================================================

  /// Print error details ke debug console
  void _printError(String operation, DioException e) {
    if (kDebugMode) {
      print('=== ERROR: $operation ===');
      print('Type: ${e.type}');
      print('Message: ${e.message}');
      if (e.response != null) {
        print('Status Code: ${e.response?.statusCode}');
        print('Laravel Response Data: ${e.response?.data}');
        // Print validation errors jika ada
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          if (data.containsKey('errors')) {
            print('Validation Errors: ${data['errors']}');
          }
          if (data.containsKey('message')) {
            print('Laravel Message: ${data['message']}');
          }
        }
      }
      print('=========================');
    }
  }

  /// Handle Dio errors - mengikuti pola AuthRemoteDataSource
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
        return data['message'];
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
    return 'Terjadi kesalahan saat update profile. Silakan coba lagi.';
  }
}
