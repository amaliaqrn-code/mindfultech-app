import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'presentation/splash/splash_screen.dart';
import 'presentation/onboarding/onboarding_screen.dart';
import 'presentation/homepage/homepage_screen.dart';
import 'presentation/journey/controllers/journey_controller.dart';
import 'presentation/journey/screens/journey_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(JourneyController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnBoardingScreen(),
        '/homepage': (context) => const HomepageScreen(),
        '/journey': (context) => const JourneyScreen(),
      },
    );
  }
}