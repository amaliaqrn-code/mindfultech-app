import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';

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
              // Teks Judul
              const Text(
                'Yeay! Tugasmu\nberhasil disimpan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4191FF), // Biru utama
                  height: 1.3,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),

              // Teks Deskripsi
              const Text(
                'Kamu bisa melihat dan mulai mengerjakannya di halaman beranda',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF718096),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              // Maskot mindy
              Image.asset(
                'assets/images/page_success.png', // Sesuaikan dengan nama gambar awan suksesmu
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),

              // Ringkasan Tugas
              Column(
                children: [
                  // Nama Tugas
                  buildInfoCard(
                    icon: Icons.assignment,
                    title: 'Nama Tugas',
                    value: task.namaTugas,
                    chipColor: const Color(0xFFE8F0FF),
                    chipTextColor: const Color(0xFF2F66D0),
                  ),

                  const SizedBox(height: 6),

                  // Tingkat Energi
                  buildInfoCard(
                    icon: Icons.eco,
                    title: 'Tingkat Energi',
                    value: task.energi.displayName,
                    chipColor: const Color(0xFFE7F3DF),
                    chipTextColor: const Color(0xFF6A8E4D),
                  ),

                  const SizedBox(height: 6),

                  // Estimasi Waktu
                  buildInfoCard(
                    icon: Icons.access_time_filled,
                    title: 'Estimasi Waktu',
                    value: '${task.estimasiWaktu} Menit',
                    chipColor: const Color(0xFFFFF1D9),
                    chipTextColor: const Color(0xFFFF9800),
                  ),

                  const SizedBox(height: 6),

                  // Prioritas
                  buildInfoCard(
                    icon: Icons.star,
                    title: 'Prioritas',
                    value: task.prioritas.displayName,
                    chipColor: const Color(0xFFFFE1E1),
                    chipTextColor: Colors.red,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Tombol "Lihat Daftar Tugas"
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    // Pindah ke halaman semua tugas menggunakan named route
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.mainPage,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4191FF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  child: const Text(
                    'Kembali ke Beranda',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color chipColor,
    required Color chipTextColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF2F66D0),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Color(0xFF2F66D0),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: chipColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: chipTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}