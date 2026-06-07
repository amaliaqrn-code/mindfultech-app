import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/core/network/dio_client.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/data/datasources/auth_remote_datasource.dart';
import 'package:mindfultech_app/data/repositories/auth_repository.dart';
import 'package:mindfultech_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:mindfultech_app/presentation/auth/bloc/register/register_bloc.dart';
import 'package:mindfultech_app/presentation/auth/pages/login_page.dart';
import 'package:mindfultech_app/presentation/auth/pages/register/register_page.dart';
import 'package:mindfultech_app/presentation/auth/pages/forgot_password_page.dart';
import 'package:mindfultech_app/presentation/auth/pages/password_success_page.dart';
import 'package:mindfultech_app/presentation/splash/pages/splash_page.dart';
import 'package:mindfultech_app/presentation/onboarding/pages/onboarding_page.dart';
import 'package:mindfultech_app/presentation/homepage/pages/homepage_page.dart';
import 'package:mindfultech_app/presentation/homepage/pages/all_tasks_page.dart';
import 'package:mindfultech_app/presentation/homepage/pages/create_task_category_page.dart';
import 'package:mindfultech_app/presentation/homepage/pages/create_custom_task_page.dart';
import 'package:mindfultech_app/presentation/homepage/bloc/homepage_cubit.dart';
import 'package:mindfultech_app/presentation/main_page.dart';
import 'package:mindfultech_app/presentation/tutorial/pages/tutorial_page.dart';
import 'package:mindfultech_app/presentation/journey/pages/journey_page.dart';
import 'package:mindfultech_app/presentation/streak/pages/streak_page.dart';
import 'package:mindfultech_app/presentation/choose_energy/pages/choose_energy_page.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/pages/green_task_recommendation_page.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/pages/green_alternative_task_list_page.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/pages/green_task_confirmation_page.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/pages/blue_task_recommendation_page.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/pages/blue_alternative_task_list_page.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/pages/blue_task_confirmation_page.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/pages/purple_task_recommendation_page.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/pages/purple_alternative_task_list_page.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/pages/purple_task_confirmation_page.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/models/task_model.dart';
import 'package:mindfultech_app/presentation/timer/pages/timer_page.dart';
import 'package:mindfultech_app/presentation/timer/bloc/timer_cubit.dart';

/// App Router - Centralized routing configuration using Flutter Navigator
class AppRouter {
  /// Generate routes with BLoC providers
  static Route<dynamic>? generateRoute(RouteSettings settings, AuthRepository authRepository) {
    final uri = Uri.parse(settings.name ?? '/');

    switch (uri.path) {
      case AppRoutes.splash:
        return _buildPageRoute(settings, SplashPage());
      case AppRoutes.onboarding:
        return _buildPageRoute(settings, OnBoardingPage());
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
        return _buildPageRoute(settings, TutorialPage());
      case AppRoutes.homepage:
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => HomepageCubit(),
            child: const HomepagePage(),
          ),
        );
      case AppRoutes.mainPage:
        return _buildPageRoute(settings, const MainPage());
      case AppRoutes.journey:
        return _buildPageRoute(settings, JourneyPage());
      case AppRoutes.streak:
        return _buildPageRoute(settings, const StreakPage());
      case AppRoutes.chooseEnergy:
        return _buildPageRoute(settings, ChooseEnergyPage());
      case AppRoutes.greenTaskRecommendation:
        final args = settings.arguments as Map<String, dynamic>?;
        final category = args?['category'] as TaskCategory? ?? TaskCategory.selfCare;
        final recommendedTask = args?['recommendedTask'] as TaskModel? ??
            const TaskModel(
              id: 'default_green_task',
              title: 'Menulis Jurnal',
              description: 'Menuangkan isi pikiran dan perasaan melalui tulisan',
              category: TaskCategory.selfCare,
              energyLevel: EnergyLevel.low,
              iconName: 'edit',
              estimatedMinutes: 10,
            );
        return _buildPageRoute(
          settings,
          GreenTaskRecommendationPage(
            selectedCategory: category,
            recommendedTask: recommendedTask,
          ),
        );
      case AppRoutes.greenAlternativeTaskList:
        final args = settings.arguments as Map<String, dynamic>?;
        final category = args?['category'] as TaskCategory? ?? TaskCategory.selfCare;
        final excludeTaskId = args?['excludeTaskId'] as String?;
        return _buildPageRoute(
          settings,
          GreenAlternativeTaskListPage(
            category: category,
            excludeTaskId: excludeTaskId,
          ),
        );
      case AppRoutes.greenTaskConfirmation:
        final args = settings.arguments as Map<String, dynamic>?;
        final selectedTask = args?['selectedTask'] as TaskModel? ??
            const TaskModel(
              id: 'default_confirm_task',
              title: 'Menulis Jurnal',
              description: 'Menuangkan isi pikiran dan perasaan melalui tulisan',
              category: TaskCategory.selfCare,
              energyLevel: EnergyLevel.low,
              iconName: 'edit',
              estimatedMinutes: 10,
            );
        return _buildPageRoute(
          settings,
          GreenTaskConfirmationPage(
            selectedTask: selectedTask,
          ),
        );
      case AppRoutes.blueTaskRecommendation:
        final blueArgs = settings.arguments as Map<String, dynamic>?;
        final blueCategory = blueArgs?['category'] as TaskCategory? ?? TaskCategory.selfCare;
        final blueRecommendedTask = blueArgs?['recommendedTask'] as TaskModel? ??
            const TaskModel(
              id: 'default_blue_task',
              title: 'Meditasi 15 menit',
              description: 'Menenangkan pikiran dengan guided meditation',
              category: TaskCategory.selfCare,
              energyLevel: EnergyLevel.medium,
              iconName: 'self_improvement',
              estimatedMinutes: 15,
            );
        return _buildPageRoute(
          settings,
          BlueTaskRecommendationPage(
            selectedCategory: blueCategory,
            recommendedTask: blueRecommendedTask,
          ),
        );
      case AppRoutes.blueAlternativeTaskList:
        final blueArgs = settings.arguments as Map<String, dynamic>?;
        final blueCategory = blueArgs?['category'] as TaskCategory? ?? TaskCategory.selfCare;
        final blueExcludeTaskId = blueArgs?['excludeTaskId'] as String?;
        return _buildPageRoute(
          settings,
          BlueAlternativeTaskListPage(
            category: blueCategory,
            excludeTaskId: blueExcludeTaskId,
          ),
        );
      case AppRoutes.blueTaskConfirmation:
        final blueArgs = settings.arguments as Map<String, dynamic>?;
        final blueSelectedTask = blueArgs?['selectedTask'] as TaskModel? ??
            const TaskModel(
              id: 'default_blue_confirm',
              title: 'Meditasi 15 menit',
              description: 'Menenangkan pikiran dengan guided meditation',
              category: TaskCategory.selfCare,
              energyLevel: EnergyLevel.medium,
              iconName: 'self_improvement',
              estimatedMinutes: 15,
            );
        return _buildPageRoute(
          settings,
          BlueTaskConfirmationPage(
            selectedTask: blueSelectedTask,
          ),
        );
      case AppRoutes.purpleTaskRecommendation:
        final purpleArgs = settings.arguments as Map<String, dynamic>?;
        final purpleCategory = purpleArgs?['category'] as TaskCategory? ?? TaskCategory.selfCare;
        final purpleRecommendedTask = purpleArgs?['recommendedTask'] as TaskModel? ??
            const TaskModel(
              id: 'default_purple_task',
              title: 'Belajar coding intensif',
              description: 'Belajar coding intensif selama 2 jam',
              category: TaskCategory.belajar,
              energyLevel: EnergyLevel.high,
              iconName: 'computer',
              estimatedMinutes: 120,
            );
        return _buildPageRoute(
          settings,
          PurpleTaskRecommendationPage(
            selectedCategory: purpleCategory,
            recommendedTask: purpleRecommendedTask,
          ),
        );
      case AppRoutes.purpleAlternativeTaskList:
        final purpleArgs = settings.arguments as Map<String, dynamic>?;
        final purpleCategory = purpleArgs?['category'] as TaskCategory? ?? TaskCategory.selfCare;
        final purpleExcludeTaskId = purpleArgs?['excludeTaskId'] as String?;
        return _buildPageRoute(
          settings,
          PurpleAlternativeTaskListPage(
            category: purpleCategory,
            excludeTaskId: purpleExcludeTaskId,
          ),
        );
      case AppRoutes.purpleTaskConfirmation:
        final purpleArgs = settings.arguments as Map<String, dynamic>?;
        final purpleSelectedTask = purpleArgs?['selectedTask'] as TaskModel? ??
            const TaskModel(
              id: 'default_purple_confirm',
              title: 'Belajar coding intensif',
              description: 'Belajar coding intensif selama 2 jam',
              category: TaskCategory.belajar,
              energyLevel: EnergyLevel.high,
              iconName: 'computer',
              estimatedMinutes: 120,
            );
        return _buildPageRoute(
          settings,
          PurpleTaskConfirmationPage(
            selectedTask: purpleSelectedTask,
          ),
        );
      case AppRoutes.timer:
        final args = settings.arguments as Map<String, dynamic>?;
        final taskName = args?['taskName'] as String? ?? 'Tugas Fokus';
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => TimerCubit(taskName: taskName),
            child: const TimerPage(),
          ),
        );
      case AppRoutes.allTasks:
        return _buildPageRoute(settings, const AllTasksPage());
      case AppRoutes.createTaskCategory:
        return _buildPageRoute(settings, const CreateTaskCategoryPage());
      case AppRoutes.createCustomTask:
        return _buildPageRoute(settings, const CreateCustomTaskPage());
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

  /// Helper to convert int value to EnergyLevel
  /// Initialize dependencies and return AuthRepository
  static AuthRepository initDependencies() {
    // Network& Data layer
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
