import 'package:flutter/material.dart';
import '../onboarding_model.dart';

class OnBoardingItem extends StatelessWidget {
  final OnBoardingModel data;

  const OnBoardingItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [

          // 🌤 IMAGE FULL WIDTH
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                data.image,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),

          // 🔥 TEXT AREA
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [

                // TITLE
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
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // tetap wajib tapi nanti ditimpa shader
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // DESCRIPTION
                Text(
                  data.desc,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}