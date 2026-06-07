import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindfultech_app/core/routes/app_router.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/data/repositories/auth_repository.dart';
import 'package:mindfultech_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey_cubit.dart';
import 'package:mindfultech_app/presentation/homepage/bloc/homepage_cubit.dart';
import 'package:mindfultech_app/blocs/task/task_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Initialize dependencies (repositories, etc.)
  final authRepository = AppRouter.initDependencies();

  runApp(MindfulTechApp(authRepository: authRepository));
}

class MindfulTechApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MindfulTechApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(authRepository: authRepository),
        ),
        BlocProvider<JourneyCubit>(create: (_) => JourneyCubit()),
        BlocProvider<HomepageCubit>(create: (_) => HomepageCubit()),
        BlocProvider<TaskBloc>(create: (_) => TaskBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MindfulTech',
        initialRoute: AppRoutes.splash,
        onGenerateRoute: (settings) =>
            AppRouter.generateRoute(settings, authRepository),
      ),
    );
  }
}