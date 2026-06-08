import 'package:flutter/material.dart';
import 'package:mindfultech_app/models/task_model.dart'; // Sesuaikan path modelmu

class TaskSuccessPage extends StatelessWidget {
  final TaskModel task; // Menerima data dari halaman sebelumnya

  const TaskSuccessPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ilustrasi Gambar
              Image.asset(
                'assets/images/image_cefb85.png', // Sesuaikan dengan nama gambar awan suksesmu
                height: 220,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 32),

              // Teks Judul
              const Text(
                'Hore! Tugas Baru\nDitambahkan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF4191FF), // Biru utama
                  height: 1.3,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),

              // Teks Deskripsi
              const Text(
                'Satu langkah lebih dekat menuju tujuanmu. Yuk, selesaikan dengan penuh semangat!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF718096),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // --- KOTAK DATA TUGAS YANG DITAMBAHKAN ---
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF4FF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF4191FF).withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.task_alt_rounded, color: Color(0xFF4191FF)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.namaTugas, // Menampilkan nama tugas
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A56B1),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${task.kategori.displayName} • ${task.estimasiWaktu} Menit', // Menampilkan kategori & waktu
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF709CE0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // ----------------------------------------

              const SizedBox(height: 48),

              // Tombol "Lihat Daftar Tugas"
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    // Pindah ke halaman semua tugas
                    Navigator.pushReplacementNamed(context, '/all-tasks'); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4191FF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  child: const Text(
                    'Lihat Daftar Tugas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Tombol "Kembali ke Beranda"
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF4191FF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  child: const Text(
                    'Kembali ke Beranda',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4191FF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}