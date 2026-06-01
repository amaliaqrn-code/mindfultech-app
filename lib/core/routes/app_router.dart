library;

export 'app_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/core/network/dio_client.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/data/datasources/auth_remote_datasource.dart';
import 'package:mindfultech_app/data/repositories/auth_repository.dart';
import 'package:mindfultech_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:mindfultech_app/presentation/auth/bloc/register/register_bloc.dart';
import 'package:mindfultech_app/presentation/auth/login_page.dart';
import 'package:mindfultech_app/presentation/auth/register/register_page.dart';
import 'package:mindfultech_app/presentation/auth/forgot_password.dart';
import 'package:mindfultech_app/presentation/auth/password_success_page.dart';
import 'package:mindfultech_app/presentation/splash/splash_screen.dart';
import 'package:mindfultech_app/presentation/onboarding/onboarding_screen.dart';
import 'package:mindfultech_app/presentation/homepage/homepage_screen.dart';
import 'package:mindfultech_app/presentation/tutorial/screens/totorial_screen.dart';
import 'package:mindfultech_app/presentation/journey/controllers/journey_controller.dart';
import 'package:mindfultech_app/presentation/journey/screens/journey_screen.dart';
import 'package:mindfultech_app/presentation/choose_energy/choose_energy_screen.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/mindy_bantu_aku_screen.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/mindy_bantu_aku_blue_screen.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/mindy_bantu_aku_purple_screen.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/mindy_bantu_aku_rendah_screen.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/mindy_bantu_aku_sedang_screen.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/mindy_bantu_aku_tinggi_screen.dart';
import 'package:mindfultech_app/presentation/timer/screens/timer_screen.dart';

/// App Router - Centralized routing configuration using GetX
class AppRouter {
  /// All routes configuration for GetMaterialApp
  static Map<String, Widget Function(Object?)> routes(AuthRepository authRepository) {
    return {
      AppRoutes.splash: (_) => SplashScreen(),
      AppRoutes.onboarding: (_) => OnBoardingScreen(),
      AppRoutes.login: (_) => BlocProvider(
        create: (_) => LoginBloc(authRepository: authRepository),
        child: LoginPage(),
      ),
      AppRoutes.register: (_) => BlocProvider(
        create: (_) => RegisterBloc(authRepository: authRepository),
        child: RegisterPage(),
      ),
      AppRoutes.forgotPassword: (_) => ForgotPasswordPage(),
      AppRoutes.passwordSuccess: (_) => PasswordSuccessPage(),
      AppRoutes.tutorial: (_) => TutorialScreen(),
      AppRoutes.homepage: (_) => HomepageScreen(),
      AppRoutes.journey: (_) => JourneyMapScreen(),
      AppRoutes.chooseEnergy: (_) => ChooseEnergyScreen(),
      AppRoutes.mindyBantuAku: (_) => MindyBantuAkuScreen(),
      AppRoutes.mindyBantuAkuBlue: (_) => MindyBantuAkuBlueScreen(),
      AppRoutes.mindyBantuAkuPurple: (_) => MindyBantuAkuPurpleScreen(),
      AppRoutes.mindyBantuAkuRendah: (_) => MindyBantuAkuRendahScreen(),
      AppRoutes.mindyBantuAkuSedang: (_) => MindyBantuAkuSedangScreen(),
      AppRoutes.mindyBantuAkuTinggi: (_) => MindyBantuAkuTinggiScreen(),
      AppRoutes.timer: (_) => TimerScreen(),
    };
  }

  /// Initialize dependencies and return AuthRepository
  static AuthRepository initDependencies() {
    // Network & Data layer
    final dioClient = DioClient();
    final localDataSource = AuthLocalDataSource();
    final remoteDataSource = AuthRemoteDataSource(dioClient);
    final authRepository = AuthRepository(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );

    // Controllers
    Get.put<AuthRepository>(authRepository);
    Get.put(JourneyController());

    return authRepository;
  }

  /// Generate routes with BLoC providers
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '/');

    switch (uri.path) {
      case AppRoutes.login:
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => LoginBloc(authRepository: Get.find<AuthRepository>()),
            child: LoginPage(),
          ),
        );
      case AppRoutes.register:
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => RegisterBloc(authRepository: Get.find<AuthRepository>()),
            child: RegisterPage(),
          ),
        );
      default:
        return null;
    }
  }

  static MaterialPageRoute<dynamic> _buildPageRoute(
    RouteSettings settings,
    Widget child,
  ) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => child,
      settings: settings,
    );
  }
}