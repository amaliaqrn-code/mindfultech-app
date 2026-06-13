import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import 'models/journey_progress_model.dart';
import 'models/focus_session_model.dart';

export 'models/journey_progress_model.dart';
export 'models/focus_session_model.dart';

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
      version: 4,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
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

    await db.execute('''
      CREATE INDEX idx_tasks_userId ON tasks(userId)
    ''');

    // Create journey_progress table
    await db.execute('''
      CREATE TABLE journey_progress (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT NOT NULL,
        totalDays INTEGER DEFAULT 0,
        todayFocusSeconds INTEGER DEFAULT 0,
        dailyTargetSeconds INTEGER DEFAULT 300,
        streakCount INTEGER DEFAULT 0,
        lastFocusDate TEXT,
        currentLevel INTEGER DEFAULT 1,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');
    await db.execute('CREATE INDEX idx_journey_userId ON journey_progress(userId)');

    // Create focus_sessions table for tracking completed focus sessions
    await db.execute('''
      CREATE TABLE focus_sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        taskId TEXT,
        userId TEXT NOT NULL,
        durationSeconds INTEGER NOT NULL,
        emotion INTEGER NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
    await db.execute('CREATE INDEX idx_focus_sessions_userId ON focus_sessions(userId)');
  }

  /// Handle upgrade database schema
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      try {
        await db.execute('ALTER TABLE tasks ADD COLUMN userId TEXT');
      } catch (_) {}
      try {
        await db.execute('ALTER TABLE tasks ADD COLUMN isDefault INTEGER DEFAULT 0');
      } catch (_) {}
      try {
        await db.execute('CREATE INDEX idx_tasks_userId ON tasks(userId)');
      } catch (_) {}
    }

    // Migrasi untuk journey table (versi 3)
    if (oldVersion < 3) {
      try {
        await db.execute('''
          CREATE TABLE journey_progress (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId TEXT NOT NULL,
            totalDays INTEGER DEFAULT 0,
            todayFocusSeconds INTEGER DEFAULT 0,
            dailyTargetSeconds INTEGER DEFAULT 300,
            streakCount INTEGER DEFAULT 0,
            lastFocusDate TEXT,
            currentLevel INTEGER DEFAULT 1,
            createdAt TEXT NOT NULL,
            updatedAt TEXT NOT NULL
          )
        ''');
        await db.execute('CREATE INDEX idx_journey_userId ON journey_progress(userId)');
      } catch (_) {}
    }

    // Migrasi untuk focus_sessions table (versi 4)
    if (oldVersion < 4) {
      try {
        await db.execute('''
          CREATE TABLE focus_sessions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            taskId TEXT,
            userId TEXT NOT NULL,
            durationSeconds INTEGER NOT NULL,
            emotion INTEGER NOT NULL,
            createdAt TEXT NOT NULL
          )
        ''');
        await db.execute('CREATE INDEX idx_focus_sessions_userId ON focus_sessions(userId)');
      } catch (_) {}
    }
  }

  // ============================================================
  // JOURNEY PROGRESS - CRUD Operations
  // ============================================================

  /// Insert atau update journey progress untuk user
  Future<void> upsertJourneyProgress(JourneyProgress progress) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();

    // Cek apakah sudah ada data untuk user ini
    final existing = await getJourneyProgress(progress.userId);

    if (existing != null) {
      // Update existing record
      await db.update(
        'journey_progress',
        progress.copyWith(
          id: existing.id,
          updatedAt: now,
        ).toMap(),
        where: 'id = ?',
        whereArgs: [existing.id],
      );
    } else {
      // Insert new record
      await db.insert(
        'journey_progress',
        progress.copyWith(
          createdAt: now,
          updatedAt: now,
        ).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  /// Ambil journey progress untuk user tertentu
  Future<JourneyProgress?> getJourneyProgress(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'journey_progress',
      where: 'userId = ?',
      whereArgs: [userId],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return JourneyProgress.fromMap(maps.first);
    }
    return null;
  }

  /// Ambil atau buat journey progress baru untuk user
  Future<JourneyProgress> getOrCreateJourneyProgress(String userId) async {
    final existing = await getJourneyProgress(userId);
    if (existing != null) return existing;

    final now = DateTime.now().toIso8601String();
    final newProgress = JourneyProgress(
      userId: userId,
      totalDays: 0,
      todayFocusSeconds: 0,
      dailyTargetSeconds: 300,
      streakCount: 0,
      lastFocusDate: null,
      currentLevel: 1,
      createdAt: now,
      updatedAt: now,
    );

    await upsertJourneyProgress(newProgress);
    return newProgress;
  }

  /// Update journey progress (partial update)
  Future<void> updateJourneyProgress({
    required String userId,
    int? totalDays,
    int? todayFocusSeconds,
    int? streakCount,
    String? lastFocusDate,
    int? currentLevel,
  }) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();

    final updates = <String, dynamic>{'updatedAt': now};
    if (totalDays != null) updates['totalDays'] = totalDays;
    if (todayFocusSeconds != null) updates['todayFocusSeconds'] = todayFocusSeconds;
    if (streakCount != null) updates['streakCount'] = streakCount;
    if (lastFocusDate != null) updates['lastFocusDate'] = lastFocusDate;
    if (currentLevel != null) updates['currentLevel'] = currentLevel;

    await db.update(
      'journey_progress',
      updates,
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  /// Reset daily focus untuk user (panggil di awal hari baru)
  Future<void> resetDailyFocus(String userId) async {
    await updateJourneyProgress(
      userId: userId,
      todayFocusSeconds: 0,
    );
  }

  /// Increment totalDays dan update level
  Future<void> incrementTotalDays(String userId, int newTotalDays, int newLevel) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();

    await db.update(
      'journey_progress',
      {
        'totalDays': newTotalDays,
        'currentLevel': newLevel,
        'updatedAt': now,
      },
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  /// Increment streak
  Future<void> incrementStreak(String userId, int newStreak) async {
    await updateJourneyProgress(
      userId: userId,
      streakCount: newStreak,
    );
  }

  /// Reset streak
  Future<void> resetStreak(String userId) async {
    await updateJourneyProgress(
      userId: userId,
      streakCount: 0,
    );
  }

  /// Hapus journey progress user
  Future<int> deleteJourneyProgress(String userId) async {
    final db = await database;
    return await db.delete(
      'journey_progress',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  // ============================================================
  // TASK Operations
  // ============================================================

  Future<int> insertTask(TaskModel task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> insertTaskForUser(TaskModel task, String userId) async {
    final db = await database;
    final taskWithUser = task.copyWith(userId: userId);
    return await db.insert('tasks', taskWithUser.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TaskModel>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks', orderBy: 'createdAt DESC');
    return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
  }

  Future<List<TaskModel>> getAllTasksForUser(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'prioritas ASC, createdAt DESC',
    );
    return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
  }

  Future<TaskModel?> getTaskById(String id, {String? userId}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps;

    if (userId != null) {
      maps = await db.query('tasks', where: 'id = ? AND userId = ?', whereArgs: [id, userId]);
    } else {
      maps = await db.query('tasks', where: 'id = ?', whereArgs: [id]);
    }

    if (maps.isNotEmpty) return TaskModel.fromMap(maps.first);
    return null;
  }

  Future<int> updateTask(TaskModel task) async {
    final db = await database;
    return await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(String id, {String? userId}) async {
    final db = await database;
    if (userId != null) {
      return await db.delete('tasks', where: 'id = ? AND userId = ?', whereArgs: [id, userId]);
    }
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllTasks() async {
    final db = await database;
    return await db.delete('tasks');
  }

  Future<int> deleteAllTasksForUser(String userId) async {
    final db = await database;
    return await db.delete('tasks', where: 'userId = ?', whereArgs: [userId]);
  }

  Future<List<TaskModel>> getTasksByCategory(TaskCategory category, {String? userId}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps;

    if (userId != null) {
      maps = await db.query('tasks', where: 'kategori = ? AND userId = ?', whereArgs: [category.index, userId], orderBy: 'prioritas ASC, createdAt DESC');
    } else {
      maps = await db.query('tasks', where: 'kategori = ?', whereArgs: [category.index], orderBy: 'prioritas ASC, createdAt DESC');
    }

    return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
  }

  Future<List<TaskModel>> getTasksByEnergyLevel(EnergyLevel energyLevel, {required String userId}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps;

    switch (energyLevel) {
      case EnergyLevel.rendah:
        maps = await db.query('tasks', where: 'energi = ? AND userId = ?', whereArgs: [0, userId], orderBy: 'prioritas ASC, createdAt DESC');
        break;
      case EnergyLevel.sedang:
        maps = await db.query('tasks', where: 'energi IN (?, ?) AND userId = ?', whereArgs: [0, 1, userId], orderBy: 'prioritas ASC, createdAt DESC');
        break;
      case EnergyLevel.tinggi:
        maps = await db.query('tasks', where: 'userId = ?', whereArgs: [userId], orderBy: 'prioritas ASC, createdAt DESC');
        break;
    }

    return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
  }

  Future<List<TaskModel>> getTasksByEnergyAndCategory(EnergyLevel energyLevel, TaskCategory category, {required String userId}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps;

    switch (energyLevel) {
      case EnergyLevel.rendah:
        maps = await db.query('tasks', where: 'energi = ? AND kategori = ? AND userId = ?', whereArgs: [0, category.index, userId], orderBy: 'prioritas ASC, createdAt DESC');
        break;
      case EnergyLevel.sedang:
        maps = await db.query('tasks', where: 'energi IN (?, ?) AND kategori = ? AND userId = ?', whereArgs: [0, 1, category.index, userId], orderBy: 'prioritas ASC, createdAt DESC');
        break;
      case EnergyLevel.tinggi:
        maps = await db.query('tasks', where: 'kategori = ? AND userId = ?', whereArgs: [category.index, userId], orderBy: 'prioritas ASC, createdAt DESC');
        break;
    }

    return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
  }

  Future<bool> hasDefaultTasksForToday(String userId) async {
    final db = await database;
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final result = await db.query(
      'tasks',
      where: 'userId = ? AND isDefault = 1 AND createdAt >= ? AND createdAt < ?',
      whereArgs: [userId, startOfDay.toIso8601String(), endOfDay.toIso8601String()],
    );

    return result.isNotEmpty;
  }

  Future<void> insertDefaultTasks(List<TaskModel> tasks) async {
    final db = await database;
    final batch = db.batch();

    for (final task in tasks) {
      batch.insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  // ============================================================
  // FOCUS SESSIONS - CRUD Operations (Emotion Tracking)
  // ============================================================

  /// Insert focus session after user completes a focus session
  Future<int> insertFocusSession(FocusSessionModel session) async {
    final db = await database;
    return await db.insert('focus_sessions', session.toMap());
  }

  /// Get all focus sessions for a user
  Future<List<FocusSessionModel>> getFocusSessionsForUser(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'focus_sessions',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC',
    );
    return List.generate(maps.length, (i) => FocusSessionModel.fromMap(maps[i]));
  }

  /// Get focus sessions for today for a user
  Future<List<FocusSessionModel>> getTodayFocusSessions(String userId) async {
    final db = await database;
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final List<Map<String, dynamic>> maps = await db.query(
      'focus_sessions',
      where: 'userId = ? AND createdAt >= ? AND createdAt < ?',
      whereArgs: [userId, startOfDay.toIso8601String(), endOfDay.toIso8601String()],
      orderBy: 'createdAt DESC',
    );
    return List.generate(maps.length, (i) => FocusSessionModel.fromMap(maps[i]));
  }

  /// Get count of completed focus sessions for a user
  Future<int> getFocusSessionCount(String userId) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM focus_sessions WHERE userId = ?',
      [userId],
    );
    return result.first['count'] as int? ?? 0;
  }

  /// Get unique emotion types used by a user (for emotion recap progress)
  Future<List<int>> getUniqueEmotionsUsed(String userId) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT DISTINCT emotion FROM focus_sessions WHERE userId = ? ORDER BY emotion',
      [userId],
    );
    return result.map((r) => r['emotion'] as int).toList();
  }

  /// Delete focus session by ID
  Future<int> deleteFocusSession(int id) async {
    final db = await database;
    return await db.delete(
      'focus_sessions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete all focus sessions for a user
  Future<int> deleteAllFocusSessionsForUser(String userId) async {
    final db = await database;
    return await db.delete(
      'focus_sessions',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  /// Tutup koneksi database
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}