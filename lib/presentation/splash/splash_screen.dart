import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isSecond = false;

  @override
  void initState() {
    super.initState();
    startSplash();
  }

  /// 🔥 LOGIC SPLASH
  void startSplash() async {
    // Splash pertama (putih)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() {
      isSecond = true;
    });

    // Splash kedua (gradient)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const OnBoardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: isSecond ? splashGradient() : splashWhite(),
      ),
    );
  }

  /// 🔹 SPLASH PERTAMA (PUTIH)
  Widget splashWhite() {
    return Container(
      key: const ValueKey('white'),
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splashScreen1.png',
              width: 120,
            ),
            const SizedBox(height: 20),
            const Text(
              "MindfulTech",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 SPLASH KEDUA (GRADIENT)
  Widget splashGradient() {
    return Container(
      key: const ValueKey('gradient'),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF7BC6CC),
            Color(0xFFBE93C5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splashScreen2.png',
              width: 120,
            ),
            const SizedBox(height: 20),
            const Text(
              "MindfulTech",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}