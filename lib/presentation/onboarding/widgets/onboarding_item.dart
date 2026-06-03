import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../onboarding_model.dart';

class OnBoardingItem extends StatelessWidget {
  final OnBoardingModel data;

  const OnBoardingItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // IMAGE AREA
          Expanded(
            flex: 4,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Mindy image - centered and larger
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Image.asset(
                      data.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('Error loading image ${data.image}: $error');
                        return const Icon(Icons.image, size: 100, color: Colors.grey);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ENERGY CARDS - only for special slide (positioned below image)
          if (data.isSpecial)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildEnergyCard(
                    iconPath: 'assets/icon/onboarding/low.svg',
                    label: 'Low',
                  ),
                  const SizedBox(width: 12),
                  _buildEnergyCard(
                    iconPath: 'assets/icon/onboarding/medium.svg',
                    label: 'Medium',
                  ),
                  const SizedBox(width: 12),
                  _buildEnergyCard(
                    iconPath: 'assets/icon/onboarding/high.svg',
                    label: 'High',
                  ),
                ],
              ),
            ),

          const SizedBox(height: 16),

          // TEXT AREA
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // TITLE with gradient
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
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // DESCRIPTION
                  Text(
                    data.desc,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      height: 1.5,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build Low/Medium/High cards for the energy selection slide
  Widget _buildEnergyCard({
    required String iconPath,
    required String label,
  }) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 32,
            height: 32,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }
}