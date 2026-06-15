import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mindfultech_app/core/network/dio_client.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/data/models/task_request.dart';
import 'package:mindfultech_app/data/models/task_response.dart';
import 'package:mindfultech_app/data/models/create_task_response_model.dart';

/// Remote Data Source untuk Task
/// Mengikuti pola yang sama dengan AuthRemoteDataSource
class TaskRemoteDataSource {
  final DioClient _dioClient;
  final AuthLocalDataSource _localDataSource;

  TaskRemoteDataSource(this._dioClient)
      : _localDataSource = AuthLocalDataSource();

  // ============================================================
  // HELPER - Ambil Bearer Token
  // ============================================================

  /// Ambil token dari local storage dan buat header options
  Future<Options> _getAuthOptions() async {
    final token = _localDataSource.getToken();

    if (kDebugMode) {
      print('=== TASK API DEBUG ===');
      print('Token: ${token != null ? "ADA (${token.substring(0, 10)}...)" : "TIDAK ADA"}');
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
  // CREATE TASK - Membuat task baru
  // ============================================================

  /// Membuat task baru di Laravel API
  /// Menggunakan CreateTaskResponseModel untuk parsing response
  Future<CreateTaskResponseModel> createTask(TaskRequest request) async {
    try {
      final options = await _getAuthOptions();

      if (kDebugMode) {
        print('=== CREATE TASK API DEBUG ===');
        print('POST /tasks');
        print('Data Payload: ${request.toMap()}');
        print('Category ID (dari enum): ${request.categoryId}');
        print('=================================');
      }

      final response = await _dioClient.post(
        '/tasks',
        data: request.toMap(),
        options: options,
      );

      if (kDebugMode) {
        print('✅ Laravel Response: ${response.data}');
      }

      // Parse response menggunakan CreateTaskResponseModel
      final createTaskResponse = CreateTaskResponseModel.fromMap(
        response.data as Map<String, dynamic>,
      );

      if (kDebugMode) {
        print('✅ Task Created - ID: ${createTaskResponse.data.id}');
        print('    Title: ${createTaskResponse.data.title}');
        print('    Category ID: ${createTaskResponse.data.categoryId}');
        print('    Difficulty: ${createTaskResponse.data.difficulty}');
      }

      return createTaskResponse;
    } on DioException catch (e) {
      // Debug: Print response Laravel jika gagal
      if (kDebugMode) {
        print('❌ Error Laravel: ${e.response?.data}');
      }
      _printError('CREATE TASK', e);
      throw _handleError(e);
    }
  }

  // ============================================================
  // UPDATE TASK - Memperbarui task yang sudah ada
  // ============================================================

  /// Memperbarui task yang sudah ada di Laravel API
  Future<TaskResponse> updateTask(String taskId, TaskRequest request) async {
    try {
      final options = await _getAuthOptions();

      if (kDebugMode) {
        print('PUT /tasks/$taskId');
        print('Data: ${request.toMap()}');
      }

      final response = await _dioClient.put(
        '/tasks/$taskId',
        data: request.toMap(),
        options: options,
      );

      if (kDebugMode) {
        print('Response: ${response.data}');
      }

      return TaskResponse.fromMap(response.data);
    } on DioException catch (e) {
      _printError('UPDATE TASK', e);
      throw _handleError(e);
    }
  }

  // ============================================================
  // DELETE TASK - Menghapus task
  // ============================================================

  /// Menghapus task dari Laravel API
  Future<bool> deleteTask(String taskId) async {
    try {
      final options = await _getAuthOptions();

      if (kDebugMode) {
        print('DELETE /tasks/$taskId');
      }

      final response = await _dioClient.delete(
        '/tasks/$taskId',
        options: options,
      );

      if (kDebugMode) {
        print('DELETE Response Status: ${response.statusCode}');
      }

      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      _printError('DELETE TASK', e);
      throw _handleError(e);
    }
  }

  // ============================================================
  // FETCH TASKS - Mengambil semua task dari server
  // ============================================================

  /// Mengambil semua task dari Laravel API
  Future<List<TaskResponse>> fetchTasks() async {
    try {
      final options = await _getAuthOptions();

      if (kDebugMode) {
        print('GET /tasks');
      }

      final response = await _dioClient.get(
        '/tasks',
        options: options,
      );

      if (kDebugMode) {
        print('GET TASKS Response: ${response.data}');
      }

      if (response.data is Map<String, dynamic>) {
        final responseMap = response.data as Map<String, dynamic>;

        // Cek field 'task' (Laravel standard)
        if (responseMap.containsKey('task')) {
          final taskData = responseMap['task'];
          if (taskData is List) {
            return taskData
                .map((json) => TaskResponse.fromMap(json as Map<String, dynamic>))
                .toList();
          }
        }

        // Cek field 'data' (alternative)
        if (responseMap.containsKey('data')) {
          final data = responseMap['data'];
          if (data is List) {
            return data
                .map((json) => TaskResponse.fromMap(json as Map<String, dynamic>))
                .toList();
          }
        }
      }

      // Jika response adalah array langsung
      if (response.data is List) {
        return (response.data as List)
            .map((json) => TaskResponse.fromMap(json as Map<String, dynamic>))
            .toList();
      }

      return [];
    } on DioException catch (e) {
      _printError('FETCH TASKS', e);
      throw _handleError(e);
    }
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
