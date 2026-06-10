import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';

/// DatabaseHelper untuk mengelola operasi SQLite lokal
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
      version: 1,
      onCreate: _onCreate,
    );
  }

  /// Buat tabel saat database pertama kali dibuat
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        namaTugas TEXT NOT NULL,
        kategori TEXT NOT NULL,
        energi INTEGER NOT NULL,
        estimasiWaktu INTEGER NOT NULL,
        prioritas INTEGER NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
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

  /// Ambil semua task dari database
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

  /// Ambil task berdasarkan ID
  Future<TaskModel?> getTaskById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );

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

  /// Hapus task berdasarkan ID
  Future<int> deleteTask(String id) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Hapus semua task
  Future<int> deleteAllTasks() async {
    final db = await database;
    return await db.delete('tasks');
  }

  /// Ambil task berdasarkan kategori
  Future<List<TaskModel>> getTasksByCategory(TaskCategory category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'kategori = ?',
      whereArgs: [category.index], // Gunakan index int, bukan displayName
      orderBy: 'createdAt DESC',
    );

    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  // ============================================================
  // MINDY BANTU AKU - Filter berdasarkan Energi
  // ============================================================

  /// Ambil task berdasarkan level energi
  /// Digunakan untuk fitur "Mindy Bantu Aku"
  ///
  /// Logic rekomendasi:
  /// - energi = 0 (Rendah/Low)    → Task dengan energi=0 (easy tasks)
  /// - energi = 1 (Sedang/Medium) → Task dengan energi=0 atau 1
  /// - energi = 2 (Tinggi/High)   → Semua task (energi=0, 1, atau 2)
  Future<List<TaskModel>> getTasksByEnergyLevel(EnergyLevel energyLevel) async {
    final db = await database;
    final List<Map<String, dynamic>> maps;

    switch (energyLevel) {
      case EnergyLevel.rendah:
        // Energi rendah: hanya task dengan difficulty rendah (energi=0)
        maps = await db.query(
          'tasks',
          where: 'energi = ?',
          whereArgs: [0],
          orderBy: 'prioritas ASC, createdAt DESC',
        );
        break;
      case EnergyLevel.sedang:
        // Energi sedang: task dengan difficulty rendah-sedang (energi=0 atau 1)
        maps = await db.query(
          'tasks',
          where: 'energi IN (?, ?)',
          whereArgs: [0, 1],
          orderBy: 'prioritas ASC, createdAt DESC',
        );
        break;
      case EnergyLevel.tinggi:
        // Energi tinggi: semua task tersedia
        maps = await db.query(
          'tasks',
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
    TaskCategory category,
  ) async {
    final db = await database;
    final List<Map<String, dynamic>> maps;

    switch (energyLevel) {
      case EnergyLevel.rendah:
        maps = await db.query(
          'tasks',
          where: 'energi = ? AND kategori = ?',
          whereArgs: [0, category.index], // Gunakan index int
          orderBy: 'prioritas ASC, createdAt DESC',
        );
        break;
      case EnergyLevel.sedang:
        maps = await db.query(
          'tasks',
          where: 'energi IN (?, ?) AND kategori = ?',
          whereArgs: [0, 1, category.index], // Gunakan index int
          orderBy: 'prioritas ASC, createdAt DESC',
        );
        break;
      case EnergyLevel.tinggi:
        maps = await db.query(
          'tasks',
          where: 'kategori = ?',
          whereArgs: [category.index], // Gunakan index int
          orderBy: 'prioritas ASC, createdAt DESC',
        );
        break;
    }

    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  /// Tutup koneksi database
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
