import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindfultech_app/presentation/profile/screens/profile_screen.dart';

import 'core/network/dio_client.dart';
import 'data/datasources/auth_local_datasource.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'data/repositories/auth_repository.dart';
import 'presentation/auth/bloc/login/login_bloc.dart';
import 'presentation/auth/bloc/register/register_bloc.dart';
import 'presentation/auth/login_page.dart';
import 'presentation/auth/register/register_page.dart';
import 'presentation/splash/splash_screen.dart';
import 'presentation/onboarding/onboarding_screen.dart';
import 'presentation/homepage/homepage_screen.dart';
import 'presentation/tutorial/screens/totorial_screen.dart';
import 'presentation/journey/controllers/journey_controller.dart';
import 'presentation/journey/screens/journey_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Initialize dependencies
  final dioClient = DioClient();
  final localDataSource = AuthLocalDataSource();
  final remoteDataSource = AuthRemoteDataSource(dioClient);
  final authRepository = AuthRepository(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );

  // Put controllers
  Get.put(JourneyController());
  Get.put<AuthRepository>(authRepository);

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => LoginBloc(authRepository: authRepository),
                child: LoginPage(),
              ),
            );
          case '/register':
            return MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => RegisterBloc(authRepository: authRepository),
                child: RegisterPage(),
              ),
            );
          default:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
        }
      },
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnBoardingScreen(),
        '/homepage': (context) => const HomepageScreen(),
        '/tutorial': (context) => const TutorialScreen(),
        '/journey': (context) => const JourneyScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
