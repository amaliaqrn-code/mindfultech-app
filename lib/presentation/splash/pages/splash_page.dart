import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';

/// 🔥 SPLASH SCREEN - Authentication Flow Entry Point
///
/// Fungsi utama:
/// 1. Menampilkan animasi splash
/// 2. Mengecek apakah user sudah login (auto-login)
/// 3. Navigasi ke halaman yang sesuai berdasarkan status login
///
/// Alur:
/// - Token ada & valid → Homepage
/// - Token tidak ada → Onboarding (kemudian login)
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  bool _isSecond = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Instance AuthLocalDataSource untuk cek status login
  final AuthLocalDataSource _authLocalDataSource = AuthLocalDataSource();

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

  /// 🔥 LOGIC SPLASH - Navigation flow dengan Auto-Login Check
  void _startSplash() async {
    try {
      // Splash pertama (putih)
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;
      setState(() {
        _isSecond = true;
      });
      _animationController.forward();

      // Splash kedua (gradient) dengan loading check
      await Future.delayed(const Duration(milliseconds: 1500));

      if (!mounted) return;

      // 🔥 CEK STATUS LOGIN - Auto Login Logic
      final isLoggedIn = _authLocalDataSource.isLoggedIn();
      final token = _authLocalDataSource.getToken();

      debugPrint('=== SPLASH AUTH CHECK ===');
      debugPrint('Is Logged In: $isLoggedIn');
      debugPrint('Has Token: ${token != null && token.isNotEmpty}');

      // Navigate berdasarkan status login
      if (isLoggedIn && token != null && token.isNotEmpty) {
        // ✅ User SUDAH LOGIN → Langsung ke Homepage
        debugPrint('🔄 Auto-login: Redirecting to Homepage');
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homepage, (route) => false);
      } else {
        // ❌ User BELUM LOGIN → Ke Onboarding
        debugPrint('🔄 New user: Redirecting to Onboarding');
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.onboarding, (route) => false);
      }
    } catch (e) {
      debugPrint('Splash navigation error: $e');
      // Fallback navigation if error occurs
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.onboarding, (route) => false);
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
              const SizedBox(height: 24),
              // Loading indicator saat cek auth
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
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