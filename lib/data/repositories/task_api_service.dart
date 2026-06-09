import 'package:dio/dio.dart';
import 'package:mindfultech_app/core/network/dio_client.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/data/models/task_request.dart';
import 'package:mindfultech_app/data/models/task_response.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';

/// Service untuk berkomunikasi dengan Laravel API untuk operasi Task
/// Menggunakan DioClient yang sudah memiliki auth token injection dan error handling
class TaskApiService {
  final DioClient _dioClient;
  final AuthLocalDataSource _authLocalDataSource;

  TaskApiService({
    DioClient? dioClient,
    AuthLocalDataSource? authLocalDataSource,
  })  : _dioClient = dioClient ?? DioClient(),
        _authLocalDataSource = authLocalDataSource ?? AuthLocalDataSource();

  /// Ambil userId dari user yang sedang login
  /// Returns 0 jika tidak ada user yang login (task tidak akan tersimpan di server)
  int _getCurrentUserId() {
    final user = _authLocalDataSource.getUser();
    return user?.id ?? 0;
  }

  /// Cek apakah ada user yang login
  bool get isUserLoggedIn => _authLocalDataSource.isLoggedIn();

  // ============================================================
  // CREATE TASK - Membuat task baru
  // ============================================================

  /// Membuat task baru di Laravel API
  ///
  /// Throws [TaskApiException] jika gagal
  /// Jika user belum login, akan throw exception
  Future<TaskResponse> createTask(TaskModel task) async {
    // Validasi: pastikan user sudah login
    if (!isUserLoggedIn) {
      throw TaskApiException(
        message: 'User belum login. Task tidak dapat dikirim ke server.',
        statusCode: null,
      );
    }

    try {
      // Buat request DTO dari TaskModel dengan userId dari session login
      final userId = _getCurrentUserId();
      final request = TaskRequest.fromTaskModel(
        task,
        userId: userId,
      );

      // Kirim POST request ke Laravel
      final response = await _dioClient.post(
        '/tasks',
        data: request.toMap(),
      );

      // Parse response
      final taskResponse = TaskResponse.fromMap(response.data);

      // Validasi response dari server
      if (taskResponse.data.id <= 0) {
        throw TaskApiException(
          message: 'Server mengembalikan response tidak valid',
          statusCode: response.statusCode,
          response: taskResponse,
        );
      }

      return taskResponse;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // ============================================================
  // UPDATE TASK - Memperbarui task yang sudah ada
  // ============================================================

  /// Memperbarui task yang sudah ada di Laravel API
  Future<TaskResponse> updateTask(TaskModel task) async {
    // Validasi: pastikan user sudah login
    if (!isUserLoggedIn) {
      throw TaskApiException(
        message: 'User belum login. Task tidak dapat diupdate di server.',
        statusCode: null,
      );
    }

    try {
      // Buat request untuk update dengan userId dari session login
      final userId = _getCurrentUserId();
      final request = TaskRequest.fromTaskModel(
        task,
        userId: userId,
      );

      // Kirim PUT request ke Laravel
      final response = await _dioClient.put(
        '/tasks/${task.id}',
        data: request.toMap(),
      );

      final taskResponse = TaskResponse.fromMap(response.data);

      if (taskResponse.data.id <= 0) {
        throw TaskApiException(
          message: 'Server mengembalikan response tidak valid saat update',
          statusCode: response.statusCode,
          response: taskResponse,
        );
      }

      return taskResponse;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // ============================================================
  // DELETE TASK - Menghapus task
  // ============================================================

  /// Menghapus task dari Laravel API
  Future<bool> deleteTask(String taskId) async {
    // Validasi: pastikan user sudah login
    if (!isUserLoggedIn) {
      throw TaskApiException(
        message: 'User belum login. Task tidak dapat dihapus dari server.',
        statusCode: null,
      );
    }

    try {
      final response = await _dioClient.delete('/tasks/$taskId');

      // Laravel biasanya mengembalikan 200 atau 204 untuk delete success
      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      }

      throw TaskApiException(
        message: 'Gagal menghapus task di server',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // ============================================================
  // FETCH TASKS - Mengambil semua task dari server
  // ============================================================

  /// Mengambil semua task dari Laravel API
  Future<List<TaskResponse>> fetchTasks() async {
    // Validasi: pastikan user sudah login
    if (!isUserLoggedIn) {
      throw TaskApiException(
        message: 'User belum login. Tidak dapat mengambil task dari server.',
        statusCode: null,
      );
    }

    try {
      final response = await _dioClient.get('/tasks');

      // Laravel mengembalikan: {'message': '...', 'task': [...]} atau {'data': [...]}
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
      throw _handleDioError(e);
    }
  }

  // ============================================================
  // ERROR HANDLING - Helper untuk menangani DioException
  // ============================================================

  /// Konversi DioException ke TaskApiException yang lebih spesifik
  TaskApiException _handleDioError(DioException e) {
    String message;
    int? statusCode = e.response?.statusCode;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Koneksi timeout. Pastikan server Laravel berjalan.';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout. Coba lagi.';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout. Server terlalu lambat merespons.';
        break;
      case DioExceptionType.badResponse:
        // Parse error message dari response Laravel
        final responseData = e.response?.data;
        if (responseData is Map<String, dynamic>) {
          message = responseData['message'] ??
                   responseData['error'] ??
                   'Response error dari server';
        } else {
          message = 'Response tidak valid dari server';
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request dibatalkan';
        break;
      case DioExceptionType.connectionError:
        message = 'Tidak dapat terhubung ke server. '
                  'Pastikan:\n'
                  '1. Server Laravel berjalan\n'
                  '2. URL base di ApiConstants sudah benar\n'
                  '3. Device terhubung ke jaringan yang sama';
        break;
      default:
        message = 'Terjadi kesalahan jaringan: ${e.message}';
    }

    return TaskApiException(
      message: message,
      statusCode: statusCode,
      originalError: e,
    );
  }
}

// ============================================================
// CUSTOM EXCEPTION - Untuk error handling yang lebih spesifik
// ============================================================

/// Exception khusus untuk Task API operations
class TaskApiException implements Exception {
  final String message;
  final int? statusCode;
  final TaskResponse? response;
  final dynamic originalError;

  TaskApiException({
    required this.message,
    this.statusCode,
    this.response,
    this.originalError,
  });

  @override
  String toString() {
    final buffer = StringBuffer('TaskApiException: $message');
    if (statusCode != null) {
      buffer.write(' (Status: $statusCode)');
    }
    if (originalError != null) {
      buffer.write('\nOriginal: $originalError');
    }
    return buffer.toString();
  }

  /// Apakah ini error terkait koneksi
  bool get isConnectionError =>
      message.contains('koneksi') ||
      message.contains('terhubung') ||
      message.contains('timeout');

  /// Apakah ini error validasi dari server
  bool get isValidationError =>
      statusCode == 422 ||
      message.contains('validation') ||
      message.contains('validasi');
}