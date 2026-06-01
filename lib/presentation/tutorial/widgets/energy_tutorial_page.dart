import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/tutorial_model.dart';

class EnergyTutorialPage extends StatelessWidget {
  final TutorialModel data;

  const EnergyTutorialPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
              // Mindy Cloud Image
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
                            borderRadius: BorderRadius.circular(50), 
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

              // ================= ENERGY CARD (Positioned) =================
              // Positioned card using Stack
              const SizedBox(height: 20),
            ],
          ),
        ),

        // Positioned Energy Card - WAJIB PRESISI
        Positioned(
          top: 420,
          left: 20,
          right: 20,
          child: Container(
            width: 364,
            height: 202,
            padding: const EdgeInsets.fromLTRB(43, 22, 47, 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Card title text
                Text(
                  "Cek energimu hari ini",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF374151),
                  ),
                ),

                const SizedBox(height: 20),

                // Energy options row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Low Energy
                    _buildEnergyOption(
                      iconPath: "assets/images/tutorial/daun.png",
                      label: "Low",
                      isSelected: false,
                    ),

                    // Medium Energy (Active)
                    _buildEnergyOption(
                      iconPath: "assets/images/tutorial/batrai.png",
                      label: "Medium",
                      isSelected: true,
                    ),

                    // High Energy
                    _buildEnergyOption(
                      iconPath: "assets/images/tutorial/petir.png",
                      label: "High",
                      isSelected: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ================= PERBAIKAN: _buildEnergyOption =================
  Widget _buildEnergyOption({
    required String iconPath,
    required String label,
    required bool isSelected,
  }) {
    // Container ini membungkus gambar Ikon sekaligus Teks Label-nya
    return Container(
      width: 80,
      height: 96,
      decoration: BoxDecoration(
        color: Colors.white, // Latar kotak selalu putih
        borderRadius: BorderRadius.circular(16), // Sudut kotak membulat
        border: isSelected
            ? Border.all(color: const Color(0xFF7BBEFF), width: 1.5) // Garis biru jika aktif
            : Border.all(color: Colors.transparent, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? const Color(0xFF4597E6).withValues(alpha: 0.4) // Warna sedikit ditebalkan agar jelas
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: isSelected ? 12 : 8,
            // KUNCI: spreadRadius negatif agar bayangan tidak bocor ke atas dan samping
            spreadRadius: isSelected ? -2 : 0, 
            // Mendorong bayangan lebih jauh ke bawah (sumbu Y) saat aktif
            offset: isSelected ? const Offset(0, 10) : const Offset(0, 4), 
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ikon
          Image.asset(
            iconPath,
            width: 36,
            height: 36,
            fit: BoxFit.contain,
            // HAPUS parameter `color` agar gradasi asli ikonmu tetap terlihat
          ),
          
          const SizedBox(height: 10),
          
          // Label Teks
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              color: const Color(0xFF374151), // Warna teks selalu gelap seperti di desain
            ),
          ),
        ],
      ),
    );
  }
}