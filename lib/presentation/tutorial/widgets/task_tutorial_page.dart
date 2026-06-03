import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/tutorial_model.dart';

class TaskTutorialPage extends StatelessWidget {
  final TutorialModel data;

  const TaskTutorialPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ================= BACKGROUND =================
        Positioned.fill(
          child: Container(
            color: const Color(0xFFF4FAFF),
          ),
        ),

        // ================= MAIN CONTENT =================
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 44),

              // ================= HEADER SECTION =================
              // Title with gradient
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: [
                      Color(0xff4597E6),
                      Color(0xff7BBEFF),
                      Color(0xff83DFC6),
                    ],
                  ).createShader(bounds);
                },
                child: Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  data.description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    height: 1.4,
                    color: const Color(0xFF7BBEFF),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ================= MINDY ILLUSTRATION =================
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      data.image,
                      height: 260,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint("Error loading image: $error");
                        return Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4597E6).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.cloud,
                            size: 80,
                            color: Color(0xFF4597E6),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),

        // ================= TASK CARD (Positioned) =================
        Positioned(
          top: 400,
          left: 24,
          right: 24,
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card title text
                Text(
                  "Tugas hari ini",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF374151),
                  ),
                ),

                const SizedBox(height: 16),

                // Task 1: Bersihkan kamar
                _buildTaskItem(
                  iconPath: "assets/images/tutorial/bersihkankamar.png",
                  title: "Bersihkan kamar",
                  time: "30 menit",
                  category: "Rumah",
                ),

                const SizedBox(height: 12),

                // Task 2: Balas email klien
                _buildTaskItem(
                  iconPath: "assets/images/tutorial/bahasemailklien.png",
                  title: "Balas email klien",
                  time: "45 menit",
                  category: "Kerja",
                ),

                const SizedBox(height: 12),

                // Task 3: Tugas Poster
                _buildTaskItem(
                  iconPath: "assets/images/tutorial/tugasposter.png",
                  title: "Tugas Poster",
                  time: "45 menit",
                  category: "Kerja",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem({
    required String iconPath,
    required String title,
    required String time,
    required String category,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Row(
        children: [
          // Task Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F4FD),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.task_alt,
                    size: 20,
                    color: Color(0xFF4597E6),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Task Title & Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF374151),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: GoogleFonts.montserrat(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),

          // Category Label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F4FD),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              style: GoogleFonts.montserrat(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4597E6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
