import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';

/// DatabaseHelper untuk mengelola operasi SQLite lokal
/// Mendukung Multi-User Isolation dan Default System Tasks
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  /// Ambil instance database, buat jika belum ada
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Inisialisasi database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mindfultech_new.db');

    return await openDatabase(
      path,
      version: 2, // Diupgrade untuk mendukung userId dan isDefault
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Handle migrasi schema
    );
  }

  /// Buat tabel saat database pertama kali dibuat
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        namaTugas TEXT NOT NULL,
        kategori INTEGER NOT NULL,
        energi INTEGER NOT NULL,
        estimasiWaktu INTEGER NOT NULL,
        prioritas INTEGER NOT NULL,
        createdAt TEXT NOT NULL,
        userId TEXT,
        isDefault INTEGER DEFAULT 0
      )
    ''');

    // Buat index untuk query berdasarkan userId (performance optimization)
    await db.execute('''
      CREATE INDEX idx_tasks_userId ON tasks(userId)
    ''');
  }

  /// Handle upgrade database schema (migrasi dari versi 1 ke 2)
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Tambahkan kolom userId dan isDefault
      try {
        await db.execute('ALTER TABLE tasks ADD COLUMN userId TEXT');
      } catch (_) {
        // Kolom mungkin sudah ada
      }
      try {
        await db.execute('ALTER TABLE tasks ADD COLUMN isDefault INTEGER DEFAULT 0');
      } catch (_) {
        // Kolom mungkin sudah ada
      }
      // Buat index jika belum ada
      try {
        await db.execute('CREATE INDEX idx_tasks_userId ON tasks(userId)');
      } catch (_) {
        // Index mungkin sudah ada
      }
    }
  }

  /// Insert task baru ke database
  Future<int> insertTask(TaskModel task) async {
    final db = await database;
    return await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Insert task baru dengan userId spesifik (untuk multi-user)
  Future<int> insertTaskForUser(TaskModel task, String userId) async {
    final db = await database;
    final taskWithUser = task.copyWith(userId: userId);
    return await db.insert(
      'tasks',
      taskWithUser.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Ambil semua task dari database (SEMUA user - gunakan dengan hati-hati)
  Future<List<TaskModel>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      orderBy: 'createdAt DESC',
    );

    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  /// Ambil semua task milik user tertentu (REKOMENDASI - gunakan ini)
  Future<List<TaskModel>> getAllTasksForUser(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC',
    );

    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  /// Ambil task berdasarkan ID (hanya milik user tertentu)
  Future<TaskModel?> getTaskById(String id, {String? userId}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps;

    if (userId != null) {
      maps = await db.query(
        'tasks',
        where: 'id = ? AND userId = ?',
        whereArgs: [id, userId],
      );
    } else {
      // Fallback: query tanpa userId (deprecated - gunakan dengan hati-hati)
      maps = await db.query(
        'tasks',
        where: 'id = ?',
        whereArgs: [id],
      );
    }

    if (maps.isNotEmpty) {
      return TaskModel.fromMap(maps.first);
    }
    return null;
  }

  /// Update task yang sudah ada
  Future<int> updateTask(TaskModel task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  /// Hapus task berdasarkan ID (hanya milik user tertentu)
  Future<int> deleteTask(String id, {String? userId}) async {
    final db = await database;

    if (userId != null) {
      // Secure: hanya hapus jika milik user tersebut
      return await db.delete(
        'tasks',
        where: 'id = ? AND userId = ?',
        whereArgs: [id, userId],
      );
    } else {
      // Fallback: hapus tanpa проверка userId (deprecated)
      return await db.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }

  /// Hapus semua task (SEMUA user - gunakan dengan hati-hati)
  Future<int> deleteAllTasks() async {
    final db = await database;
    return await db.delete('tasks');
  }

  /// Hapus semua task milik user tertentu
  Future<int> deleteAllTasksForUser(String userId) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  /// Ambil task berdasarkan kategori dan user
  Future<List<TaskModel>> getTasksByCategory(TaskCategory category, {String? userId}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps;

    if (userId != null) {
      maps = await db.query(
        'tasks',
        where: 'kategori = ? AND userId = ?',
        whereArgs: [category.index, userId],
        orderBy: 'createdAt DESC',
      );
    } else {
      maps = await db.query(
        'tasks',
        where: 'kategori = ?',
        whereArgs: [category.index],
        orderBy: 'createdAt DESC',
      );
    }

    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  // ============================================================
  // MINDY BANTU AKU - Filter berdasarkan Energi (dengan User Isolation)
  // ============================================================

  /// Ambil task berdasarkan level energi
  /// Digunakan untuk fitur "Mindy Bantu Aku"
  /// Wajib menggunakan userId untuk security
  ///
  /// Logic rekomendasi:
  /// - energi = 0 (Rendah/Low)    → Task dengan energi=0 (easy tasks)
  /// - energi = 1 (Sedang/Medium) → Task dengan energi=0 atau 1
  /// - energi = 2 (Tinggi/High)   → Semua task (energi=0, 1, atau 2)
  Future<List<TaskModel>> getTasksByEnergyLevel(
    EnergyLevel energyLevel, {
    required String userId,
  }) async {
    final db = await database;
    final List<Map<String, dynamic>> maps;

    switch (energyLevel) {
      case EnergyLevel.rendah:
        maps = await db.query(
          'tasks',
          where: 'energi = ? AND userId = ?',
          whereArgs: [0, userId],
          orderBy: 'prioritas ASC, createdAt DESC',
        );
        break;
      case EnergyLevel.sedang:
        maps = await db.query(
          'tasks',
          where: 'energi IN (?, ?) AND userId = ?',
          whereArgs: [0, 1, userId],
          orderBy: 'prioritas ASC, createdAt DESC',
        );
        break;
      case EnergyLevel.tinggi:
        maps = await db.query(
          'tasks',
          where: 'userId = ?',
          whereArgs: [userId],
          orderBy: 'prioritas ASC, createdAt DESC',
        );
        break;
    }

    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  /// Ambil task berdasarkan level energi DAN kategori
  /// Untuk rekomendasi yang lebih spesifik
  Future<List<TaskModel>> getTasksByEnergyAndCategory(
    EnergyLevel energyLevel,
    TaskCategory category, {
    required String userId,
  }) async {
    final db = await database;
    final List<Map<String, dynamic>> maps;

    switch (energyLevel) {
      case EnergyLevel.rendah:
        maps = await db.query(
          'tasks',
          where: 'energi = ? AND kategori = ? AND userId = ?',
          whereArgs: [0, category.index, userId],
          orderBy: 'prioritas ASC, createdAt DESC',
        );
        break;
      case EnergyLevel.sedang:
        maps = await db.query(
          'tasks',
          where: 'energi IN (?, ?) AND kategori = ? AND userId = ?',
          whereArgs: [0, 1, category.index, userId],
          orderBy: 'prioritas ASC, createdAt DESC',
        );
        break;
      case EnergyLevel.tinggi:
        maps = await db.query(
          'tasks',
          where: 'kategori = ? AND userId = ?',
          whereArgs: [category.index, userId],
          orderBy: 'prioritas ASC, createdAt DESC',
        );
        break;
    }

    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  // ============================================================
  // DEFAULT TASKS - Seeding untuk daily default tasks
  // ============================================================

  /// Cek apakah user sudah memiliki default tasks hari ini
  Future<bool> hasDefaultTasksForToday(String userId) async {
    final db = await database;
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final result = await db.query(
      'tasks',
      where: 'userId = ? AND isDefault = 1 AND createdAt >= ? AND createdAt < ?',
      whereArgs: [
        userId,
        startOfDay.toIso8601String(),
        endOfDay.toIso8601String(),
      ],
    );

    return result.isNotEmpty;
  }

  /// Insert multiple default tasks
  Future<void> insertDefaultTasks(List<TaskModel> tasks) async {
    final db = await database;
    final batch = db.batch();

    for (final task in tasks) {
      batch.insert(
        'tasks',
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  /// Tutup koneksi database
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
