import 'package:flutter/material.dart';
import '../widgets/notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8DC9E8),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4A90E2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  const Expanded(
                    child: Text(
                      "Notifikasi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A90E2),
                      ),
                    ),
                  ),

                  const SizedBox(width: 36),
                ],
              ),
            ),

            // Card Notification
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Hari ini",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const Spacer(),

                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Lihat semua",
                            style: TextStyle(color: Color(0xFF4A90E2)),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    const Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            NotificationTile(
                              icon: Icons.local_fire_department,
                              title: "Streak - mu berlanjut",
                              description:
                                  "Keren! kamu sudah 121 hari berturut turut menggunakan Mindful Tech.",
                              time: "Baru saja",
                            ),

                            NotificationTile(
                              icon: Icons.notifications_none,
                              title: "Batasi Waktu layar",
                              description:
                                  "Kamu sudah mencapai 3 jam 45 menit hari ini.",
                              time: "08:45",
                            ),

                            NotificationTile(
                              icon: Icons.visibility,
                              title: "Saatnya fokus",
                              description:
                                  "Sudah 45 menit sejak sesi fokus terakhirmu.",
                              time: "09:30",
                            ),

                            NotificationTile(
                              icon: Icons.self_improvement,
                              title: "Jangan lupa bernafas",
                              description:
                                  "Ambil jeda sejenak dan lakukan latihan pernapasan.",
                              time: "07:50",
                            ),

                            NotificationTile(
                              icon: Icons.favorite_border,
                              title: "Tips hari ini",
                              description:
                                  "Gunakan teknologi dengan sadar, bukan berlebihan.",
                              time: "05:50",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
