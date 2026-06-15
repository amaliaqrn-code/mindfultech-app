import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http; // Sesuaikan jika kamu pakai Dio

enum SyncOperationType { create, update, delete }

/// Model untuk membungkus data operasi yang tertunda (pending)
class SyncOperation {
  final SyncOperationType type;
  final String entity;   // Contoh: 'tasks', 'journey'
  final String entityId; // ID lokal (SQLite) dari data tersebut
  final Map<String, dynamic> data;
  final DateTime createdAt;

  SyncOperation({
    required this.type,
    required this.entity,
    required this.entityId,
    required this.data,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'type': type.index,
    'entity': entity,
    'entityId': entityId,
    'data': data,
    'createdAt': createdAt.toIso8601String(),
  };

  factory SyncOperation.fromMap(Map<String, dynamic> map) => SyncOperation(
    type: SyncOperationType.values[map['type']],
    entity: map['entity'],
    entityId: map['entityId'],
    data: Map<String, dynamic>.from(map['data']),
    createdAt: DateTime.parse(map['createdAt']),
  );
}

/// SyncManager dengan pola Singleton untuk mengelola antrean Offline-First
class SyncManager {
  static final SyncManager _instance = SyncManager._internal();
  factory SyncManager() => _instance;
  SyncManager._internal();

  final _storage = GetStorage();
  final _connectivity = Connectivity();
  static const String _keyPendingSync = 'pending_sync_queue';
  bool _isSyncing = false;

  /// Inisialisasi listener internet di main.dart
  Future<void> init() async {
    await GetStorage.init(); // Pastikan GetStorage siap digunakan

    // Dengarkan perubahan koneksi internet secara real-time
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      final hasInternet = results.any((r) => 
        r == ConnectivityResult.wifi || r == ConnectivityResult.mobile
      );
      
      if (hasInternet) {
        _syncPendingOperations();
      }
    });

    // Cek sync pertama kali saat aplikasi dibuka
    await _syncPendingOperations();
  }

  /// Masukkan operasi baru ke dalam antrean offline
  Future<void> addToPendingQueue(SyncOperation operation) async {
    final queue = _getPendingQueue();
    queue.add(operation.toMap());
    await _storage.write(_keyPendingSync, queue);
    
    // Langsung coba sinkronisasi jika saat ini sedang online
    _syncPendingOperations();
  }

  List<Map<String, dynamic>> _getPendingQueue() {
    final data = _storage.read(_keyPendingSync);
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(data);
  }

  /// Proses menembak API Laravel satu per satu dari antrean
  Future<void> _syncPendingOperations() async {
    if (_isSyncing) return; // Kunci proses agar tidak bentrok (thread-safe)
    _isSyncing = true;

    final queue = _getPendingQueue();
    if (queue.isEmpty) {
      _isSyncing = false;
      return;
    }

    List<Map<String, dynamic>> failedOperations = [];

    for (final opMap in queue) {
      final operation = SyncOperation.fromMap(opMap);
      try {
        await _sendDataToLaravel(operation);
      } catch (e) {
        // Jika gagal (misal: timeout atau server down), amankan kembali ke antrean
        failedOperations.add(opMap);
      }
    }

    // Tulis ulang storage hanya dengan data yang gagal dikirim
    await _storage.write(_keyPendingSync, failedOperations);
    _isSyncing = false;
  }

  /// Logika HTTP Request ke backend Laravel kamu
  Future<void> _sendDataToLaravel(SyncOperation operation) async {
    // Sesuaikan dengan base URL Laravel API kamu
    final baseUrl = 'https://api.mindfultech.com/api/v1'; 
    final url = Uri.parse('$baseUrl/${operation.entity}');
    
    // Ambil Token auth (misal dari GetStorage atau SharedPreferences kamu)
    final token = _storage.read('auth_token') ?? ''; 

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    http.Response response;

    switch (operation.type) {
      case SyncOperationType.create:
        response = await http.post(url, headers: headers, body: jsonEncode(operation.data));
        break;
      case SyncOperationType.update:
        final updateUrl = Uri.parse('$url/${operation.entityId}');
        response = await http.put(updateUrl, headers: headers, body: jsonEncode(operation.data));
        break;
      case SyncOperationType.delete:
        final deleteUrl = Uri.parse('$url/${operation.entityId}');
        response = await http.delete(deleteUrl, headers: headers);
        break;
    }

    // Jika server merespon dengan error kode 4xx atau 5xx, lempar exception agar masuk catch
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Gagal sinkronisasi ke server: ${response.statusCode}');
    }
  }
}