import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'package:mindfultech_app/core/routes/app_router.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/auth/bloc/auth/auth_cubit.dart';
import 'package:mindfultech_app/presentation/homepage/bloc/homepage/homepage_cubit.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_cubit.dart';
import 'package:mindfultech_app/presentation/profile/bloc/profile/profile_bloc.dart';
import 'package:mindfultech_app/presentation/task/bloc/task/task_bloc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize sqflite FFI for database operations.
  // This is required for sqflite_common_ffi package.
  // On Android/iOS, it will use the native SQLite driver automatically.

  await GetStorage.init();
  final dependencies = AppRouter.initDependencies();

  runApp(MindfulTechApp(dependencies: dependencies));
}

class MindfulTechApp extends StatelessWidget {
  final AppDependencies dependencies;

  const MindfulTechApp({super.key, required this.dependencies});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(authRepository: dependencies.authRepository),
        ),
        BlocProvider<JourneyCubit>(create: (_) => JourneyCubit()),
        BlocProvider<HomepageCubit>(create: (_) => HomepageCubit()),
        BlocProvider<TaskBloc>(
          create: (_) => TaskBloc(taskRepository: dependencies.taskRepository),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc()..add(const ProfileEvent.started()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MindfulTech',
        initialRoute: AppRoutes.splash,
        onGenerateRoute: (settings) =>
            AppRouter.generateRoute(settings, dependencies.authRepository),
      ),
    );
  }
}

