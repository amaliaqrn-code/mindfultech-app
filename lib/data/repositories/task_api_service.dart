import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindfultech_app/models/task_model.dart';

class TaskApiService {
  // Ganti dengan URL Laravel kamu. 
  // Jika pakai emulator Android dan Laravel jalan di localhost:8000, gunakan 10.0.2.2
  // Jika pakai device asli, gunakan IP Address WiFi laptop kamu (misal: 192.168.1.5)
  final String baseUrl = 'http://10.0.2.2:8000/api'; 

  // Fungsi untuk mengirim POST request (Membuat tugas)
  Future<void> createTask(TaskModel task) async {
    final url = Uri.parse('$baseUrl/tasks');

    // MENGUBAH FORMAT FLUTTER (TaskModel) MENJADI FORMAT LARAVEL (JSON)
    // Berdasarkan file TaskController.php milikmu
    String mappedDifficulty = 'easy';
    if (task.energi == EnergyLevel.sedang) mappedDifficulty = 'medium';
    if (task.energi == EnergyLevel.tinggi) mappedDifficulty = 'hard';

    final body = jsonEncode({
      'title': task.namaTugas,
      'category_id': 1, // CATATAN: Ini masih di-hardcode 1. Nanti harus diambil dari ID kategori asli
      'difficulty': mappedDifficulty,
      'deadline': task.createdAt.toIso8601String(),
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // Jika Laravel kamu pakai token login (Sanctum), wajib tambahkan ini:
          // 'Authorization': 'Bearer TOKEN_USER_DISINI',
        },
        body: body,
      );

      // Status 201 berarti 'Created' di Laravel
      if (response.statusCode != 201) {
        throw Exception('Gagal menyimpan ke server. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }

  // Fungsi untuk mengirim PUT request (Memperbarui tugas)
  Future<void> updateTask(TaskModel task) async {
    final url = Uri.parse('$baseUrl/tasks/${task.id}');

    // MENGUBAH FORMAT FLUTTER (TaskModel) MENJADI FORMAT LARAVEL (JSON)
    String mappedDifficulty = 'easy';
    if (task.energi == EnergyLevel.sedang) mappedDifficulty = 'medium';
    if (task.energi == EnergyLevel.tinggi) mappedDifficulty = 'hard';

    final body = jsonEncode({
      'title': task.namaTugas,
      'category_id': 1, // CATATAN: Ini masih di-hardcode 1. Nanti harus diambil dari ID kategori asli
      'difficulty': mappedDifficulty,
      'deadline': task.createdAt.toIso8601String(),
    });

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // Jika Laravel kamu pakai token login (Sanctum), wajib tambahkan ini:
          // 'Authorization': 'Bearer TOKEN_USER_DISINI',
        },
        body: body,
      );

      // Status 200 berarti 'OK' di Laravel
      if (response.statusCode != 200) {
        throw Exception('Gagal mengupdate di server. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }

  // Fungsi untuk mengirim DELETE request (Menghapus tugas)
  Future<void> deleteTask(String taskId) async {
    final url = Uri.parse('$baseUrl/tasks/$taskId');

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // Jika Laravel kamu pakai token login (Sanctum), wajib tambahkan ini:
          // 'Authorization': 'Bearer TOKEN_USER_DISINI',
        },
      );

      // Status 200 atau 204 berarti 'OK' atau 'No Content' di Laravel
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Gagal menghapus di server. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }
}