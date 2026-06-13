import 'package:mindfultech_app/core/database/database_helper.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/data/datasources/task_remote_datasource.dart';
import 'package:mindfultech_app/data/models/task_request.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';

/// Repository untuk Task
/// Mendukung Multi-User Isolation dan Default System Tasks
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

  /// Ambil userId sebagai String untuk database local
  String? _getCurrentUserIdString() {
    final user = _localDataSource.getUser();
    return user?.id.toString();
  }

  /// Cek apakah ada user yang login
  bool get isUserLoggedIn => _localDataSource.isLoggedIn();

  // ============================================================
  // DEFAULT TASKS - Seeding untuk daily default tasks
  // ============================================================

  /// Default system tasks untuk seeding harian
  static final List<TaskModel> _defaultDailyTasks = [
    TaskModel(
      id: '', // Will be generated
      namaTugas: 'Mengulang pembelajaran di kelas hari ini 30 menit',
      kategori: TaskCategory.belajar,
      energi: EnergyLevel.sedang,
      estimasiWaktu: 30,
      prioritas: TaskPriority.penting,
      createdAt: DateTime.now(),
      isDefault: true,
    ),
    TaskModel(
      id: '',
      namaTugas: 'Membersihkan kamar tidur',
      kategori: TaskCategory.rumah,
      energi: EnergyLevel.rendah,
      estimasiWaktu: 15,
      prioritas: TaskPriority.santai,
      createdAt: DateTime.now(),
      isDefault: true,
    ),
    TaskModel(
      id: '',
      namaTugas: 'Membuat laporan bulanan/harian',
      kategori: TaskCategory.pekerjaan,
      energi: EnergyLevel.tinggi,
      estimasiWaktu: 45,
      prioritas: TaskPriority.mendesak,
      createdAt: DateTime.now(),
      isDefault: true,
    ),
    TaskModel(
      id: '',
      namaTugas: 'Pengecekan kesehatan berkala/stretching',
      kategori: TaskCategory.kesehatan,
      energi: EnergyLevel.rendah,
      estimasiWaktu: 10,
      prioritas: TaskPriority.penting,
      createdAt: DateTime.now(),
      isDefault: true,
    ),
  ];

  /// Seed default tasks jika belum ada untuk hari ini
  /// Dipanggil saat user login atau saat pertama kali membuka app
  Future<void> seedDefaultTasksIfNeeded() async {
    final userId = _getCurrentUserIdString();
    if (userId == null) return;

    try {
      // Cek apakah sudah ada default tasks hari ini
      final hasDefaults = await _databaseHelper.hasDefaultTasksForToday(userId);
      if (hasDefaults) return;

      // Generate tasks dengan ID unik dan userId
      final tasksToInsert = _defaultDailyTasks.map((task) {
        return task.copyWith(
          id: 'default_${DateTime.now().millisecondsSinceEpoch}_${task.kategori.index}',
          userId: userId,
          createdAt: DateTime.now(),
        );
      }).toList();

      // Insert ke database
      await _databaseHelper.insertDefaultTasks(tasksToInsert);
    } catch (_) {
      // Gagal seeding, tidak masalah - user tetap bisa pakai app
    }
  }

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
      final userId = _getCurrentUserIdString();

      // 1. Simpan ke SQLite lokal dengan userId
      final id = await _databaseHelper.insertTask(task.copyWith(
        id: task.id.isEmpty ? DateTime.now().millisecondsSinceEpoch.toString() : task.id,
        userId: userId,
      ));
      final savedTask = task.copyWith(
        id: id.toString(),
        userId: userId,
      );

      // 2. Sinkronisasi ke server Laravel di background
      try {
        final apiUserId = _getCurrentUserId();
        final request = TaskRequest.fromTaskModel(savedTask, userId: apiUserId);
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
  // FETCH TASKS - Mengambil semua task (dengan User Isolation)
  // ============================================================

  /// Ambil semua task milik user yang sedang login
  Future<List<TaskModel>> getAllTasks() async {
    final userId = _getCurrentUserIdString();
    if (userId == null) return [];

    try {
      return await _databaseHelper.getAllTasksForUser(userId);
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

  // ============================================================
  // MINDY BANTU AKU - Filter berdasarkan Energi (dengan User Isolation)
  // ============================================================

  /// Ambil task yang direkomendasikan berdasarkan level energi user
  /// Digunakan untuk fitur "Mindy Bantu Aku"
  /// Wajib menggunakan userId untuk security
  ///
  /// Logic:
  /// - User dengan energi rendah → task dengan difficulty rendah
  /// - User dengan energi sedang → task dengan difficulty rendah-sedang
  /// - User dengan energi tinggi → semua task tersedia
  Future<List<TaskModel>> getRecommendedTasks(EnergyLevel userEnergyLevel) async {
    final userId = _getCurrentUserIdString();
    if (userId == null) return [];

    try {
      return await _databaseHelper.getTasksByEnergyLevel(
        userEnergyLevel,
        userId: userId,
      );
    } catch (e) {
      String message = e.toString();
      if (message.startsWith('Exception: ')) {
        message = message.replaceFirst('Exception: ', '');
      }
      throw Exception(message);
    }
  }

  /// Ambil task yang direkomendasikan berdasarkan energi DAN kategori
  /// Untuk rekomendasi yang lebih spesifik berdasarkan pilihan user
  Future<List<TaskModel>> getRecommendedTasksByCategory(
    EnergyLevel userEnergyLevel,
    TaskCategory category,
  ) async {
    final userId = _getCurrentUserIdString();
    if (userId == null) return [];

    try {
      return await _databaseHelper.getTasksByEnergyAndCategory(
        userEnergyLevel,
        category,
        userId: userId,
      );
    } catch (e) {
      String message = e.toString();
      if (message.startsWith('Exception: ')) {
        message = message.replaceFirst('Exception: ', '');
      }
      throw Exception(message);
    }
  }
}
