import 'package:mindfultech_app/core/database/database_helper.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/data/datasources/task_remote_datasource.dart';
import 'package:mindfultech_app/data/models/task_request.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';

/// Repository untuk Task
/// Mengikuti pola yang sama dengan AuthRepository
class TaskRepository {
  final TaskRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final DatabaseHelper _databaseHelper;

  TaskRepository({
    required TaskRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    DatabaseHelper? databaseHelper,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _databaseHelper = databaseHelper ?? DatabaseHelper();

  /// Ambil userId dari user yang sedang login
  int _getCurrentUserId() {
    final user = _localDataSource.getUser();
    return user?.id ?? 0;
  }

  /// Cek apakah ada user yang login
  bool get isUserLoggedIn => _localDataSource.isLoggedIn();

  // ============================================================
  // CREATE TASK - Membuat task baru
  // ============================================================

  /// Membuat task baru
  /// 1. Simpan ke SQLite lokal terlebih dahulu
  /// 2. Sinkronisasi ke server Laravel di background
  Future<TaskModel> createTask(TaskModel task) async {
    // Validasi: pastikan user sudah login
    if (!isUserLoggedIn) {
      throw Exception('User belum login. Task tidak dapat disimpan.');
    }

    try {
      // 1. Simpan ke SQLite lokal terlebih dahulu
      final id = await _databaseHelper.insertTask(task);
      final savedTask = task.copyWith(id: id.toString());

      // 2. Sinkronisasi ke server Laravel di background
      try {
        final userId = _getCurrentUserId();
        final request = TaskRequest.fromTaskModel(savedTask, userId: userId);
        await _remoteDataSource.createTask(request);
      } catch (_) {
        // Sinkronisasi gagal, tapi data lokal tetap aman
 }

      return savedTask;
    } catch (e) {
      String message = e.toString();
      if (message.startsWith('Exception: ')) {
        message = message.replaceFirst('Exception: ', '');
      }
      throw Exception(message);
    }
  }

  // ============================================================
  // UPDATE TASK - Memperbarui task yang sudah ada
  // ============================================================

  /// Memperbarui task yang sudah ada
  Future<TaskModel> updateTask(TaskModel task) async {
    // Validasi: pastikan user sudah login
    if (!isUserLoggedIn) {
      throw Exception('User belum login. Task tidak dapat diupdate.');
    }

    try {
      // 1. Update ke database lokal terlebih dahulu
      await _databaseHelper.updateTask(task);

      // 2. Sinkronisasi ke server Laravel di background
      try {
        final userId = _getCurrentUserId();
        final request = TaskRequest.fromTaskModel(task, userId: userId);
        await _remoteDataSource.updateTask(task.id, request);
      } catch (_) {
        // Sinkronisasi gagal, tapi data lokal tetap aman
      }

      return task;
    } catch (e) {
      String message = e.toString();
      if (message.startsWith('Exception: ')) {
        message = message.replaceFirst('Exception: ', '');
      }
      throw Exception(message);
    }
  }

  // ============================================================
  // DELETE TASK - Menghapus task
  // ============================================================

  /// Menghapus task
  Future<void> deleteTask(String taskId) async {
    // Validasi: pastikan user sudah login
    if (!isUserLoggedIn) {
      throw Exception('User belum login. Task tidak dapat dihapus.');
    }

    try {
      // 1. Hapus dari database lokal terlebih dahulu
      await _databaseHelper.deleteTask(taskId);

      // 2. Sinkronisasi ke server Laravel di background
      try {
        await _remoteDataSource.deleteTask(taskId);
      } catch (_) {
        // Sinkronisasi gagal, tapi data lokal tetap aman
      }
    } catch (e) {
      String message = e.toString();
      if (message.startsWith('Exception: ')) {
        message = message.replaceFirst('Exception: ', '');
      }
      throw Exception(message);
    }
  }

  // ============================================================
  // FETCH TASKS - Mengambil semua task
  // ============================================================

  /// Ambil semua task dari database lokal
  Future<List<TaskModel>> getAllTasks() async {
    try {
      return await _databaseHelper.getAllTasks();
    } catch (e) {
      String message = e.toString();
      if (message.startsWith('Exception: ')) {
        message = message.replaceFirst('Exception: ', '');
      }
      throw Exception(message);
    }
  }

  /// Sinkronisasi task dari server ke lokal
  Future<void> syncTasksFromServer() async {
    if (!isUserLoggedIn) return;

    try {
      // TODO: Implementasi merge/sync dari server tasks ke SQLite lokal
      await _remoteDataSource.fetchTasks();
    } catch (_) {
      // Sinkronisasi gagal, abaikan
    }
  }
}
