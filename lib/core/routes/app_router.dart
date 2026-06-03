import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:mindfultech_app/presentation/homepage/cubit/homepage_cubit.dart';
import 'package:mindfultech_app/presentation/main_page.dart';
import 'package:mindfultech_app/presentation/tutorial/screens/totorial_screen.dart';
import 'package:mindfultech_app/presentation/journey/screens/journey_screen.dart';
import 'package:mindfultech_app/presentation/streak/screens/streak_screen.dart';
import 'package:mindfultech_app/presentation/choose_energy/choose_energy_screen.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/mindy_bantu_aku_screen.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/mindy_bantu_aku_blue_screen.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/mindy_bantu_aku_purple_screen.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/mindy_bantu_aku_green_screen.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/mindy_bantu_aku_generic_screen.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/mindy_task_recommendation_screen.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/models/mindy_theme.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/models/task_model.dart' hide EnergyLevel;
import 'package:mindfultech_app/presentation/mindy_bantu_aku/cubit/choose_energy_cubit.dart';
import 'package:mindfultech_app/presentation/timer/screens/timer_screen.dart';
import 'package:mindfultech_app/presentation/timer/cubit/timer_cubit.dart';

/// App Router - Centralized routing configuration using Flutter Navigator
class AppRouter {
  /// Generate routes with BLoC providers
  static Route<dynamic>? generateRoute(RouteSettings settings, AuthRepository authRepository) {
    final uri = Uri.parse(settings.name ?? '/');

    switch (uri.path) {
      case AppRoutes.splash:
        return _buildPageRoute(settings, SplashScreen());
      case AppRoutes.onboarding:
        return _buildPageRoute(settings, OnBoardingScreen());
      case AppRoutes.login:
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => LoginBloc(authRepository: authRepository),
            child: LoginPage(),
          ),
        );
      case AppRoutes.register:
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => RegisterBloc(authRepository: authRepository),
            child: RegisterPage(),
          ),
        );
      case AppRoutes.forgotPassword:
        return _buildPageRoute(settings, ForgotPasswordPage());
      case AppRoutes.passwordSuccess:
        return _buildPageRoute(settings, PasswordSuccessPage());
      case AppRoutes.tutorial:
        return _buildPageRoute(settings, TutorialScreen());
      case AppRoutes.homepage:
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => HomepageCubit(),
            child: const HomepageScreen(),
          ),
        );
      case AppRoutes.mainPage:
        return _buildPageRoute(settings, const MainPage());
      case AppRoutes.journey:
        return _buildPageRoute(settings, JourneyMapScreen());
      case AppRoutes.streak:
        return _buildPageRoute(settings, const StreakScreen());
      case AppRoutes.chooseEnergy:
        return _buildPageRoute(settings, ChooseEnergyScreen());
      case AppRoutes.mindyBantuAku:
        final args = settings.arguments as Map<String, dynamic>?;
        final energyValue = args?['energy'] as int? ?? 0;
        final energy = EnergyLevelExtension.fromValue(energyValue);
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => ChooseEnergyCubit(energy: energy),
            child: const MindyBantuAkuScreen(),
          ),
        );
      case AppRoutes.mindyBantuAkuBlue:
        return _buildPageRoute(settings, MindyBantuAkuBlueScreen());
      case AppRoutes.mindyBantuAkuPurple:
        return _buildPageRoute(settings, MindyBantuAkuPurpleScreen());
      case AppRoutes.mindyBantuAkuGreen:
        return _buildPageRoute(settings, const MindyBantuAkuGreenScreen());
      case AppRoutes.mindyBantuAkuGeneric:
        final args = settings.arguments as Map<String, dynamic>?;
        final energyLevel = args?['energy'] as int?;
        final level = energyLevel != null
            ? EnergyLevel.fromValue(energyLevel)
            : EnergyLevel.low;
        return _buildPageRoute(settings, MindyBantuAkuGenericScreen(energyLevel: level));
      case AppRoutes.mindyTaskRecommendation:
        return _buildPageRoute(settings, const MindyTaskRecommendationScreen());
      case AppRoutes.timer:
        final args = settings.arguments as Map<String, dynamic>?;
        final taskName = args?['taskName'] as String? ?? 'Tugas Fokus';
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => TimerCubit(taskName: taskName),
            child: const TimerScreen(),
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

    return authRepository;
  }
}