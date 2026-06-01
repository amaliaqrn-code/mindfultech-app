import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _isSecond = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startSplash();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  /// 🔥 LOGIC SPLASH - Navigation flow
  void _startSplash() async {
    try {
      // Splash pertama (putih)
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      setState(() {
        _isSecond = true;
      });
      _animationController.forward();

      // Splash kedua (gradient)
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      // Navigate to Onboarding using GetX
      Get.offAllNamed(AppRoutes.onboarding);
    } catch (e) {
      debugPrint('Splash navigation error: $e');
      // Fallback navigation if error occurs
      if (mounted) {
        Get.offAllNamed(AppRoutes.onboarding);
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _isSecond ? _splashGradient() : _splashWhite(),
      ),
    );
  }

  /// 🔹 SPLASH PERTAMA (PUTIH)
  Widget _splashWhite() {
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
              height: 120,
              fit: BoxFit.contain,
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
  Widget _splashGradient() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
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
                height: 120,
                fit: BoxFit.contain,
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
      ),
    );
  }
}