import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:mindfultech_app/blocs/task/task_bloc.dart';
import 'package:mindfultech_app/core/routes/app_router.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/data/repositories/auth_repository.dart';
import 'package:mindfultech_app/presentation/auth/bloc/auth/auth_cubit.dart';
import 'package:mindfultech_app/presentation/homepage/bloc/homepage/homepage_cubit.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize sqflite FFI for database operations.
  // This is required for sqflite_common_ffi package.
  // On Android/iOS, it will use the native SQLite driver automatically.
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  await GetStorage.init();

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
