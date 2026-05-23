import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/constants/colors.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final userName = storage.read('userName') ?? 'Aluna';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // ================= HEADER =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, $userName! 👋',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'Hari ini, mari bertumbuh bersama mindy.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage(
                      'assets/images/homepage/profile.jpg',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ================= CLOUD CARD =================
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffEAF0FA),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Yuk mulai hari\nproduktif bareng\nMindy!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.3,
                        ),
                      ),
                    ),

                    Image.asset(
                      'assets/images/homepage/awan.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ================= LANDSCAPE =================
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Image.asset(
                        'assets/images/homepage/background.png',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Positioned(
                      left: 14,
                      right: 14,
                      bottom: 14,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildMiniCard(
                              icon: Icons.local_fire_department,
                              title: 'Streak hari ini',
                              value: '5',
                              subtitle: '/ 30 hari',
                              color: Colors.orange,
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: _buildMiniCard(
                              icon: Icons.map,
                              title: 'Perjalananmu',
                              value: 'LEVEL 01',
                              subtitle: '',
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ================= BUTTON =================
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff4597E6),
                      Color(0xff83DFC6),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.primary,
                          size: 26,
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        'Mulai Fokus',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ================= TITLE =================
              const Text(
                'Tugas hari ini',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2E5BD7),
                ),
              ),

              const SizedBox(height: 14),

              // ================= TASK LIST =================
              _buildTaskCard(
                icon: Icons.menu_book,
                title: 'Belajar',
                duration: '20 Menit Fokus',
                category: 'Belajar',
                categoryColor: AppColors.primary,
              ),

              const SizedBox(height: 10),

              _buildTaskCard(
                icon: Icons.directions_run,
                title: 'Olahraga Lari',
                duration: '15 Menit Fokus',
                category: 'Kesehatan',
                categoryColor: Colors.green,
              ),

              const SizedBox(height: 10),

              _buildTaskCard(
                icon: Icons.movie,
                title: 'Menonton Film',
                duration: '20 Menit Fokus',
                category: 'Pribadi',
                categoryColor: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= MINI CARD =================

  Widget _buildMiniCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),

              const SizedBox(width: 6),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(width: 4),

              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= TASK CARD =================

  Widget _buildTaskCard({
    required IconData icon,
    required String title,
    required String duration,
    required String category,
    required Color categoryColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.black,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  duration,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}