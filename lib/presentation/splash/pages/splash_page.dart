import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';

/// 🔥 SPLASH SCREEN - Authentication Flow Entry Point

/// Fungsi utama:
/// 1. Menampilkan animasi splash
/// 2. Mengecek apakah user sudah login (auto-login)
/// 3. Navigasi ke halaman yang sesuai berdasarkan status loging
/// Alur:
/// - Token ada & valid → Homepage
/// - Token tidak ada → Onboarding (kemudian login)
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  int _step = 0;

  late AnimationController _fadeCtrl;
  late AnimationController _scaleCtrl;
  late AnimationController _btnCtrl;

  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  late Animation<double> _btnAnim;

  final AuthLocalDataSource _authLocalDataSource = AuthLocalDataSource();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _runFlow();
  }

  void _setupAnimations() {
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _btnCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn));
    _scaleAnim = Tween<double>(
      begin: 0.75,
      end: 1,
    ).animate(CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeOutBack));
    _btnAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _btnCtrl, curve: Curves.easeIn));
  }

  Future<void> _resetAndPlay() async {
    _fadeCtrl.reset();
    _scaleCtrl.reset();

    await Future.wait([_fadeCtrl.forward(), _scaleCtrl.forward()]);
  }

  Future<void> _runFlow() async {
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;

    setState(() => _step = 1);
    await _resetAndPlay();

    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;

    await _fadeCtrl.reverse();
    setState(() => _step = 2);
    await _resetAndPlay();

    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;

    await _fadeCtrl.reverse();
    setState(() => _step = 3);
    await _resetAndPlay();

    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    await _fadeCtrl.reverse();
    setState(() => _step = 4);
    await _resetAndPlay();

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    _btnCtrl.forward();
  }

  Future<void> _onMulai() async {
    try {
      final isLoggedIn = _authLocalDataSource.isLoggedIn();
      final token = _authLocalDataSource.getToken();
      if (!mounted) return;
      if (isLoggedIn && token != null && token.isNotEmpty) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.homepage,
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.onboarding,
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.onboarding,
          (route) => false,
        );
      }
    }
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _scaleCtrl.dispose();
    _btnCtrl.dispose();
    super.dispose();
  }

  static const mindfulBlue = Color(0xFF4597E6);
  static const techBlue = Color(0xFF79D1DF);

  static const _gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF4597E6),
      Color(0xFF66C3E8),
      Color(0xFF79D1DF),
      Color(0xFF8CDED5),
    ],
  );

  Widget _logoText({
    required Color mindfulColor,
    required Color techColor,
    required double size,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Mindful',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: size,
              fontWeight: FontWeight.w600,
              color: mindfulColor,
            ),
          ),
          TextSpan(
            text: '-',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: size,
              fontWeight: FontWeight.w400,
              color: techColor,
            ),
          ),
          TextSpan(
            text: 'Tech',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: size,
              fontWeight: FontWeight.w400,
              color: techColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _mulaiButton() {
    return FadeTransition(
      opacity: _btnAnim,
      child: GestureDetector(
        onTap: _onMulai,
        child: Container(
          width: 364,
          height: 55,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4597E6), Color(0xFF7BBEFF), Color(0xFF83DFC6)],
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Mulai',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    if (_step == 0) {
      return const ColoredBox(color: Colors.white, child: SizedBox.expand());
    }

    if (_step == 1) {
      return Container(
        decoration: const BoxDecoration(gradient: _gradient),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/splashScreen2.png',
                    width: 285,
                    height: 187,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 18),
                  _logoText(
                    mindfulColor: Colors.white,
                    techColor: Colors.white,
                    size: 26,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (_step == 2) {
      return ColoredBox(
        color: Colors.white,
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/splashScreen1.png',
                    width: 285,
                    height: 187,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 12),
                  _logoText(
                    mindfulColor: mindfulBlue,
                    techColor: techBlue,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (_step == 3) {
      return ColoredBox(
        color: Colors.white,
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/splashScreen1.png',
                    width: 35,
                    height: 25,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  _logoText(
                    mindfulColor: mindfulBlue,
                    techColor: techBlue,
                    size: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (_step == 4) {
      return ColoredBox(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeTransition(
                opacity: _fadeAnim,
                child: ScaleTransition(
                  scale: _scaleAnim,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/splashScreen1.png',
                        width: 285,
                        height: 187,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 12),
                      _logoText(
                        mindfulColor: mindfulBlue,
                        techColor: techBlue,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _mulaiButton(),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
