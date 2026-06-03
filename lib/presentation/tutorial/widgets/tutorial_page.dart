import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/tutorial_model.dart';
import '../widgets/task_card.dart';
import '../widgets/focus_card.dart';
import '../widgets/journey_card.dart';

class TutorialPage extends StatelessWidget {
  final TutorialModel data;
  final int index;

  const TutorialPage({
    super.key,
    required this.data,
    required this.index,
  });

  Widget _buildCard() {
    switch (index) {
      case 1:
        return const TaskCard();
      case 2:
        return const FocusCard();
      case 3:
        return const JourneyCard();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4FAFF),
      child: Column(
        children: [
          // ================= HEADER SECTION =================
          const SizedBox(height: 44),

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

          const SizedBox(height: 8),

          // Description
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

          // ================= DYNAMIC CONTENT CARD =================
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildCard(),
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}