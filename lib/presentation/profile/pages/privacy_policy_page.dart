import 'package:flutter/material.dart';
import 'privacy_success_page.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),

        title: const Text(
          'Kebijakan Privasi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),

          child: Column(
            children: [
              const SizedBox(height: 24),

              const Text(
                'Syarat & ketentuan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A90E2),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'Terakhir diperbarui: November 2025',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    '''
Aplikasi Mindful Tech dirancang untuk membantu pengguna menjaga keseimbangan penggunaan teknologi dan kesehatan digital dengan aman dan nyaman.

Aplikasi ini dapat mengumpulkan beberapa informasi dasar seperti:

• Nama profil atau akun yang digunakan

• Aktivitas penggunaan fitur Mindful Tech

• Pengaturan target fokus dan preferensi pengguna

• Data pengingat, waktu istirahat, dan statistik penggunaan aplikasi

Semua informasi digunakan hanya untuk:

• Meningkatkan performa aplikasi

• Memberikan pengalaman yang lebih personal

• Membantu pengguna memantau kebiasaan digital dengan lebih baik

• Mengembangkan fitur mindfulness dan fokus secara aman

Mindful Tech tidak menjual, menyebarkan, atau membagikan data pribadi pengguna kepada pihak ketiga tanpa izin.

Semua data disimpan menggunakan sistem keamanan yang sesuai untuk menjaga privasi pengguna.
                    ''',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.7,
                      color: Color(0xFF444444),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4A90E2), Color(0xFF78E6C8)],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PrivacySuccessScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Setuju',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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
