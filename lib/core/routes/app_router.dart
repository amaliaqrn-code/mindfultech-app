import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/core/network/dio_client.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/data/datasources/auth_remote_datasource.dart';
import 'package:mindfultech_app/data/datasources/task_remote_datasource.dart';
import 'package:mindfultech_app/data/repositories/auth_repository.dart';
import 'package:mindfultech_app/data/repositories/task_repository.dart';
import 'package:mindfultech_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:mindfultech_app/presentation/auth/bloc/register/register_bloc.dart';
import 'package:mindfultech_app/presentation/auth/pages/login_page.dart';
import 'package:mindfultech_app/presentation/auth/pages/register_page.dart';
import 'package:mindfultech_app/presentation/auth/pages/forgot_password_page.dart';
import 'package:mindfultech_app/presentation/auth/pages/password_success_page.dart';
import 'package:mindfultech_app/presentation/splash/pages/splash_page.dart';
import 'package:mindfultech_app/presentation/onboarding/pages/onboarding_page.dart';
import 'package:mindfultech_app/presentation/homepage/pages/homepage_page.dart';
import 'package:mindfultech_app/presentation/homepage/bloc/homepage/homepage_cubit.dart';
import 'package:mindfultech_app/presentation/main_page.dart';
import 'package:mindfultech_app/presentation/timer/pages/timer_page.dart';
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
import 'package:mindfultech_app/presentation/mindy_bantu_aku/pages/task_category_page.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/cubit/mindy_bantu_aku_cubit.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import 'package:mindfultech_app/presentation/timer/pages/setup_timer_page.dart';
import '../../presentation/timer/bloc/timer/timer_bloc.dart';
import 'package:mindfultech_app/presentation/task/pages/all_tasks_page.dart';
import 'package:mindfultech_app/presentation/task/pages/create_task_category_page.dart';
import 'package:mindfultech_app/presentation/task/pages/create_custom_task_page.dart';

/// App Router - Centralized routing configuration using Flutter Navigator
class AppRouter {
  /// Generate routes with BLoC providers
  static Route<dynamic>? generateRoute(
    RouteSettings settings,
    AppDependencies dependencies,
  ) {
    final uri = Uri.parse(settings.name ?? '/');
    final taskRepository = dependencies.taskRepository;
    final authRepository = dependencies.authRepository;

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
        return _buildPageRoute(
          settings,
          MainPage(authRepository: authRepository),
        );
      case AppRoutes.journey:
        return _buildPageRoute(settings, JourneyPage());
      case AppRoutes.streak:
        return _buildPageRoute(settings, const StreakPage());
      case AppRoutes.chooseEnergy:
        return _buildPageRoute(settings, ChooseEnergyPage());

      case AppRoutes.greenTaskRecommendation:
        final args = settings.arguments as Map<String, dynamic>?;
        final category = args?['category'] as TaskCategory? ?? TaskCategory.pribadi;
        final energyLevel = args?['energyLevel'] as EnergyLevel? ?? EnergyLevel.rendah;

        // 🟢 Cek apakah ada lemparan data asli, jika tidak ada gunakan DefaultTaskHelper agar aman
        final selectedTask = args?['selectedTask'] as TaskModel? ??
            DefaultTaskHelper.createDefaultTask(
              energi: energyLevel,
              kategori: category,
            );

        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => MindyBantuAkuCubit(taskRepository: taskRepository),
            child: GreenTaskRecommendationPage(
              selectedCategory: category,
              energyLevel: energyLevel,
              selectedTask: selectedTask,
            ),
          ),
        );

      case AppRoutes.greenAlternativeTaskList:
        final args = settings.arguments as Map<String, dynamic>?;
        final category = args?['category'] as TaskCategory? ?? TaskCategory.pribadi;
        final excludeTaskId = args?['excludeTaskId'] as int?;
        final energyLevel = args?['energyLevel'] as EnergyLevel? ?? EnergyLevel.rendah;
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => MindyBantuAkuCubit(taskRepository: taskRepository),
            child: GreenAlternativeTaskListPage(
              category: category,
              excludeTaskId: excludeTaskId,
              energyLevel: energyLevel,
            ),
          ),
        );

      case AppRoutes.greenTaskConfirmation:
        final args = settings.arguments as Map<String, dynamic>?;
        final selectedTask = args?['selectedTask'] as TaskModel? ??
            DefaultTaskHelper.createDefaultTask(
              energi: EnergyLevel.rendah,
              kategori: TaskCategory.pribadi,
            );
        return _buildPageRoute(
          settings,
          GreenTaskConfirmationPage(selectedTask: selectedTask),
        );

      case AppRoutes.blueTaskRecommendation:
        final blueArgs = settings.arguments as Map<String, dynamic>?;
        final blueCategory = blueArgs?['category'] as TaskCategory? ?? TaskCategory.pribadi;
        final blueEnergyLevel = blueArgs?['energyLevel'] as EnergyLevel? ?? EnergyLevel.sedang;

        // 🟢 Menggunakan data lembaran asli atau fallback terpadu
        final blueSelectedTask = blueArgs?['selectedTask'] as TaskModel? ??
            DefaultTaskHelper.createDefaultTask(
              energi: blueEnergyLevel,
              kategori: blueCategory,
            );

        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => MindyBantuAkuCubit(taskRepository: taskRepository),
            child: BlueTaskRecommendationPage(
              selectedCategory: blueCategory,
              energyLevel: blueEnergyLevel,
              selectedTask: blueSelectedTask,
            ),
          ),
        );

      case AppRoutes.blueAlternativeTaskList:
        final blueArgs = settings.arguments as Map<String, dynamic>?;
        final blueCategory = blueArgs?['category'] as TaskCategory? ?? TaskCategory.pribadi;
        final blueExcludeTaskId = blueArgs?['excludeTaskId'] as int?;
        final blueEnergyLevel = blueArgs?['energyLevel'] as EnergyLevel? ?? EnergyLevel.sedang;
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => MindyBantuAkuCubit(taskRepository: taskRepository),
            child: BlueAlternativeTaskListPage(
              category: blueCategory,
              excludeTaskId: blueExcludeTaskId,
              energyLevel: blueEnergyLevel,
            ),
          ),
        );

      case AppRoutes.blueTaskConfirmation:
        final blueArgs = settings.arguments as Map<String, dynamic>?;
        final blueSelectedTask = blueArgs?['selectedTask'] as TaskModel? ??
            DefaultTaskHelper.createDefaultTask(
              energi: EnergyLevel.sedang,
              kategori: TaskCategory.pribadi,
            );
        return _buildPageRoute(
          settings,
          BlueTaskConfirmationPage(selectedTask: blueSelectedTask),
        );

      case AppRoutes.purpleTaskRecommendation:
        final purpleArgs = settings.arguments as Map<String, dynamic>?;
        final purpleCategory = purpleArgs?['category'] as TaskCategory? ?? TaskCategory.belajar;
        final purpleEnergyLevel = purpleArgs?['energyLevel'] as EnergyLevel? ?? EnergyLevel.tinggi;

        // 🟢 Menggunakan data lembaran asli atau fallback terpadu
        final purpleSelectedTask = purpleArgs?['selectedTask'] as TaskModel? ??
            DefaultTaskHelper.createDefaultTask(
              energi: purpleEnergyLevel,
              kategori: purpleCategory,
            );

        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => MindyBantuAkuCubit(taskRepository: taskRepository),
            child: PurpleTaskRecommendationPage(
              selectedCategory: purpleCategory,
              energyLevel: purpleEnergyLevel,
              selectedTask: purpleSelectedTask,
            ),
          ),
        );

      case AppRoutes.purpleAlternativeTaskList:
        final purpleArgs = settings.arguments as Map<String, dynamic>?;
        final purpleCategory = purpleArgs?['category'] as TaskCategory? ?? TaskCategory.belajar;
        final excludeTaskId = purpleArgs?['excludeTaskId'] as int?;
        final purpleEnergyLevel = purpleArgs?['energyLevel'] as EnergyLevel? ?? EnergyLevel.tinggi;
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => MindyBantuAkuCubit(taskRepository: taskRepository),
            child: PurpleAlternativeTaskListPage(
              category: purpleCategory,
              excludeTaskId: excludeTaskId,
              energyLevel: purpleEnergyLevel,
            ),
          ),
        );

      case AppRoutes.purpleTaskConfirmation:
        final purpleArgs = settings.arguments as Map<String, dynamic>?;
        final purpleSelectedTask = purpleArgs?['selectedTask'] as TaskModel? ??
            DefaultTaskHelper.createDefaultTask(
              energi: EnergyLevel.tinggi,
              kategori: TaskCategory.belajar,
            );
        return _buildPageRoute(
          settings,
          PurpleTaskConfirmationPage(selectedTask: purpleSelectedTask),
        );

      case AppRoutes.setupTimer:
        final task = settings.arguments as TaskModel?;
      
        return _buildPageRoute(
          settings,
          BlocProvider(
            create: (_) => TimerBloc(),
            child: SetupTimerPage(task: task),
          ),
        );
      case AppRoutes.activeTimer:
        return _buildPageRoute(
          settings,
          BlocProvider(create: (_) => TimerBloc(), child: const TimerPage()),
        );

      case AppRoutes.allTasks:
        return _buildPageRoute(settings, const AllTasksPage());
      case AppRoutes.createTaskCategory:
        return _buildPageRoute(settings, const CreateTaskCategoryPage());
      case AppRoutes.createCustomTask:
        return _buildPageRoute(settings, const CreateCustomTaskPage());
      case AppRoutes.taskCategory:
        final args = settings.arguments as Map<String, dynamic>?;
        final energyLevel = args?['energyLevel'] as EnergyLevel? ?? EnergyLevel.sedang;
        return _buildPageRoute(
          settings,
          TaskCategoryPage(energyLevel: energyLevel),
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

  static AppDependencies initDependencies() {
    final dioClient = DioClient();
    final localDataSource = AuthLocalDataSource();
    final authRemoteDataSource = AuthRemoteDataSource(dioClient);
    final taskRemoteDataSource = TaskRemoteDataSource(dioClient);

    final authRepository = AuthRepository(
      remoteDataSource: authRemoteDataSource,
      localDataSource: localDataSource,
    );
    final taskRepository = TaskRepository(
      remoteDataSource: taskRemoteDataSource,
      localDataSource: localDataSource,
    );

    return AppDependencies(
      authRepository: authRepository,
      taskRepository: taskRepository,
    );
  }
}

/// Container for app dependencies
class AppDependencies {
  final AuthRepository authRepository;
  final TaskRepository taskRepository;

  const AppDependencies({
    required this.authRepository,
    required this.taskRepository,
  });
}