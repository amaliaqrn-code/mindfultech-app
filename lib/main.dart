import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindfultech_app/core/routes/app_router.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/data/repositories/auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Initialize dependencies (controllers, repositories, etc.)
  final authRepository = AppRouter.initDependencies();

  runApp(MindfulTechApp(authRepository: authRepository));
}

class MindfulTechApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MindfulTechApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    // Build routes with authRepository for BLoC providers
    final appRoutes = AppRouter.routes(authRepository);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindfulTech',

      // Initial route - SplashScreen handles redirection logic
      initialRoute: AppRoutes.splash,

      // Define all app routes
      getPages: [
        GetPage(
          name: AppRoutes.splash,
          page: () => appRoutes[AppRoutes.splash]!(null),
        ),
        GetPage(
          name: AppRoutes.onboarding,
          page: () => appRoutes[AppRoutes.onboarding]!(null),
        ),
        GetPage(
          name: AppRoutes.login,
          page: () => appRoutes[AppRoutes.login]!(null),
        ),
        GetPage(
          name: AppRoutes.register,
          page: () => appRoutes[AppRoutes.register]!(null),
        ),
        GetPage(
          name: AppRoutes.forgotPassword,
          page: () => appRoutes[AppRoutes.forgotPassword]!(null),
        ),
        GetPage(
          name: AppRoutes.passwordSuccess,
          page: () => appRoutes[AppRoutes.passwordSuccess]!(null),
        ),
        GetPage(
          name: AppRoutes.tutorial,
          page: () => appRoutes[AppRoutes.tutorial]!(null),
        ),
        GetPage(
          name: AppRoutes.homepage,
          page: () => appRoutes[AppRoutes.homepage]!(null),
        ),
        GetPage(
          name: AppRoutes.journey,
          page: () => appRoutes[AppRoutes.journey]!(null),
        ),
        GetPage(
          name: AppRoutes.chooseEnergy,
          page: () => appRoutes[AppRoutes.chooseEnergy]!(null),
        ),
        GetPage(
          name: AppRoutes.mindyBantuAku,
          page: () => appRoutes[AppRoutes.mindyBantuAku]!(null),
        ),
        GetPage(
          name: AppRoutes.mindyBantuAkuBlue,
          page: () => appRoutes[AppRoutes.mindyBantuAkuBlue]!(null),
        ),
        GetPage(
          name: AppRoutes.mindyBantuAkuPurple,
          page: () => appRoutes[AppRoutes.mindyBantuAkuPurple]!(null),
        ),
        GetPage(
          name: AppRoutes.mindyBantuAkuRendah,
          page: () => appRoutes[AppRoutes.mindyBantuAkuRendah]!(null),
        ),
        GetPage(
          name: AppRoutes.mindyBantuAkuSedang,
          page: () => appRoutes[AppRoutes.mindyBantuAkuSedang]!(null),
        ),
        GetPage(
          name: AppRoutes.mindyBantuAkuTinggi,
          page: () => appRoutes[AppRoutes.mindyBantuAkuTinggi]!(null),
        ),
        GetPage(
          name: AppRoutes.timer,
          page: () => appRoutes[AppRoutes.timer]!(null),
        ),
      ],

      // Handle routes that need BLoC providers
      onGenerateRoute: AppRouter.generateRoute,

      // Default transition animation
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}