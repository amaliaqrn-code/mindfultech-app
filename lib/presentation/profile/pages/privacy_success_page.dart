import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';

class PrivacySuccessScreen extends StatefulWidget {
  const PrivacySuccessScreen({super.key});

  @override
  State<PrivacySuccessScreen> createState() => _PrivacySuccessScreenState();
}

class _PrivacySuccessScreenState extends State<PrivacySuccessScreen> {
  late ConfettiController _confettiController;

  bool showText = false;
  bool showButton = false;

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));

    _confettiController.play();

    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    setState(() {
      showText = true;
    });

    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    setState(() {
      showButton = true;
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/profile/background_profile.png',
              fit: BoxFit.cover,
            ),
          ),

          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF4D96E8), width: 4),
                ),
                child: const Icon(
                  Icons.check,
                  size: 70,
                  color: Color(0xFF4D96E8),
                ),
              ),

              const SizedBox(height: 24),

              AnimatedOpacity(
                opacity: showText ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: const Column(
                  children: [
                    Text(
                      'Berhasil!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Persetujuanmu sudah tersimpan.'),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              AnimatedOpacity(
                opacity: showButton ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.homepage,
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4D96E8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Kembali Ke Beranda',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
