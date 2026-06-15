import 'package:mindfultech_app/core/database/database_helper.dart';
import 'package:mindfultech_app/core/sync/sync_manager.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/data/datasources/task_remote_datasource.dart';
import 'package:mindfultech_app/data/models/task_request.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';

/// Repository untuk Task
/// Mendukung Multi-User Isolation, Otomatisasi Default System Tasks, & Custom User Tasks
class TaskRepository {
  final SyncManager _syncManager = SyncManager();
  final AuthLocalDataSource _localDataSource;
  final DatabaseHelper _databaseHelper;

  TaskRepository({
    required TaskRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    DatabaseHelper? databaseHelper,
  })  : 
        _localDataSource = localDataSource,
        _databaseHelper = databaseHelper ?? DatabaseHelper();

  int _getCurrentUserId() => _localDataSource.getUser()?.id ?? 0;
  String? _getCurrentUserIdString() => _localDataSource.getUser()?.id.toString();
  bool get isUserLoggedIn => _localDataSource.isLoggedIn();

  // ============================================================
  // MASTER DATA DEFAULT SYSTEM TASKS
  // ============================================================
  static final List<TaskModel> _masterDefaultTasks = [
    TaskModel(
      id: 1, // 🟢 Sekarang aman bertipe int
      namaTugas: 'Mengulang pembelajaran di kelas hari ini 30 menit',
      kategori: TaskCategory.belajar,
      energi: EnergyLevel.sedang,
      estimasiWaktu: 30,
      prioritas: TaskPriority.penting,
      createdAt: DateTime.now(),
      isDefault: true,
    ),
    TaskModel(
      id: 2,
      namaTugas: 'Membersihkan kamar tidur',
      kategori: TaskCategory.rumah,
      energi: EnergyLevel.rendah,
      estimasiWaktu: 15,
      prioritas: TaskPriority.santai,
      createdAt: DateTime.now(),
      isDefault: true,
    ),
    TaskModel(
      id: 3,
      namaTugas: 'Membuat laporan bulanan/harian',
      kategori: TaskCategory.pekerjaan,
      energi: EnergyLevel.tinggi,
      estimasiWaktu: 45,
      prioritas: TaskPriority.mendesak,
      createdAt: DateTime.now(),
      isDefault: true,
    ),
    TaskModel(
      id: 4,
      namaTugas: 'Pengecekan kesehatan berkala/stretching',
      kategori: TaskCategory.kesehatan,
      energi: EnergyLevel.rendah,
      estimasiWaktu: 10,
      prioritas: TaskPriority.penting,
      createdAt: DateTime.now(),
      isDefault: true,
    ),
    TaskModel(
      id: 5, // 🟢 Diperbaiki dari id: 4 ganda menjadi 5
      namaTugas: 'Minum air putih 2 liter & istirahat teratur',
      kategori: TaskCategory.kesehatan,
      energi: EnergyLevel.rendah,
      estimasiWaktu: 5,
      prioritas: TaskPriority.penting,
      createdAt: DateTime.now(),
      isDefault: true,
    ),
  ];

  // ============================================================
  // AUTOMATIC SEEDING LOGIC
  // ============================================================

  /// Menanam data default ke SQLite dan Server jika belum ada untuk hari ini
  Future<void> seedDefaultTasksIfNeeded() async {
    final userId = _getCurrentUserIdString();
    if (userId == null) return;

    try {
      // 1. Validasi harian ke SQLite
      final hasDefaults = await _databaseHelper.hasDefaultTasksForToday(userId);
      if (hasDefaults) return; 

      final apiUserId = _getCurrentUserId();
      final List<TaskModel> tasksToInsert = [];

      // 2. Loop data master dan siapkan properti uniknya
      for (int i = 0; i < _masterDefaultTasks.length; i++) {
        final task = _masterDefaultTasks[i];
        
        // 🟢 UBAH KE INT: Kombinasi menit, detik, index kategori, dan loop index agar membentuk kode angka unik
        final now = DateTime.now();
        final int generatedId = int.parse('${now.minute}${now.second}${task.kategori.index}$i');
        
        final baseTask = task.copyWith(
          id: generatedId,
          userId: userId,
          createdAt: now,
        );

        tasksToInsert.add(baseTask);

        // 3. Masukkan ke antrean SyncManager menggunakan .toString() pada entityId
        await _syncManager.addToPendingQueue(SyncOperation(
          type: SyncOperationType.create,
          entity: 'tasks',
          entityId: generatedId.toString(), // 🟢 Dikonversi ke String hanya untuk SyncManager
          data: TaskRequest.fromTaskModel(baseTask, userId: apiUserId).toMap(),
          createdAt: DateTime.now(),
        ));
      }

      // 4. Masukkan kumpulan data default secara massal ke SQLite lokal
      await _databaseHelper.insertDefaultTasks(tasksToInsert);
    } catch (e) {
      print("Gagal seeding harian otomatis: $e");
    }
  }

  // ============================================================
  // CUSTOM USER TASKS (FITUR TAMBAH TUGAS OLEH USER)
  // ============================================================

  /// Membuat task custom baru hasil inputan jari user sendiri
  Future<TaskModel> createTask(TaskModel task) async {
    if (!isUserLoggedIn) {
      throw Exception('User belum login. Task tidak dapat disimpan.');
    }

    try {
      final userId = _getCurrentUserIdString();
      
      // 🟢 PERBAIKAN LOGIKA ID: Jika ID kiriman bernilai 0 atau kosong, buatkan integer ID berbasis waktu unik
      final int finalId = task.id == 0 
          ? DateTime.now().millisecondsSinceEpoch 
          : task.id;

      final preparedTask = task.copyWith(
        id: finalId,
        userId: userId,
        isDefault: false,
      );

      // 1. Simpan ke SQLite lokal
      final dynamic resultFromDb = await _databaseHelper.insertTask(preparedTask);
      
      // Pastikan data id yang didapat dari kembalian DB dikonversi kembali ke int secara aman
      final int idFromDb = resultFromDb is int ? resultFromDb : int.parse(resultFromDb.toString());
      
      final savedTask = preparedTask.copyWith(id: idFromDb);

      // 2. Kirim antrean offline ke SyncManager (Gunakan .toString() khusus untuk parameter antrean cloud)
      final apiUserId = _getCurrentUserId();
      await _syncManager.addToPendingQueue(SyncOperation(
        type: SyncOperationType.create,
        entity: 'tasks',
        entityId: savedTask.id.toString(), // 🟢 Ditambahkan .toString() untuk mencocokkan payload String sync
        data: TaskRequest.fromTaskModel(savedTask, userId: apiUserId).toMap(),
        createdAt: DateTime.now(),
      ));

      return savedTask;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  // ============================================================
  // UPDATE, DELETE & FETCH
  // ============================================================

  Future<TaskModel> updateTask(TaskModel task) async {
    if (!isUserLoggedIn) throw Exception('User belum login.');
    try {
      await _databaseHelper.updateTask(task);
      final apiUserId = _getCurrentUserId();
      await _syncManager.addToPendingQueue(SyncOperation(
        type: SyncOperationType.update,
        entity: 'tasks',
        entityId: task.id.toString(), // 🟢 Ditambahkan .toString()
        data: TaskRequest.fromTaskModel(task, userId: apiUserId).toMap(),
        createdAt: DateTime.now(),
      ));
      return task;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  // 🟢 PERBAIKAN PARAMETER: Ubah String taskId menjadi int taskId agar sinkron dengan signature baru DatabaseHelper
  Future<void> deleteTask(int taskId) async {
    if (!isUserLoggedIn) throw Exception('User belum login.');
    try {
      await _databaseHelper.deleteTask(taskId); // 🟢 Mengirim int langsung tanpa parsing string
      await _syncManager.addToPendingQueue(SyncOperation(
        type: SyncOperationType.delete,
        entity: 'tasks',
        entityId: taskId.toString(), // 🟢 Hanya diubah ke String demi kontrak payload SyncManager
        data: {},
        createdAt: DateTime.now(),
      ));
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Mengambil semua tugas (Hasil gabungan data default harian + data custom buatan user)
  Future<List<TaskModel>> getAllTasks() async {
    final userId = _getCurrentUserIdString();
    if (userId == null) return [];
    try {
      await seedDefaultTasksIfNeeded();
      return await _databaseHelper.getAllTasksForUser(userId);
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<List<TaskModel>> getRecommendedTasks(EnergyLevel userEnergyLevel) async {
    final userId = _getCurrentUserIdString();
    if (userId == null) return [];
    try {
      return await _databaseHelper.getTasksByEnergyLevel(userEnergyLevel, userId: userId);
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<List<TaskModel>> getRecommendedTasksByCategory(EnergyLevel userEnergyLevel, TaskCategory category) async {
    final userId = _getCurrentUserIdString();
    if (userId == null) return [];
    try {
      return await _databaseHelper.getTasksByEnergyAndCategory(userEnergyLevel, category, userId: userId);
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}