// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindfultech_app/data/repositories/auth_repository.dart';
import 'package:mindfultech_app/presentation/homepage/pages/homepage_page.dart';
import 'package:mindfultech_app/presentation/journey/pages/journey_page.dart';
import 'package:mindfultech_app/presentation/profile/pages/profile_page.dart';
import 'package:mindfultech_app/presentation/streak/pages/streak_page.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import 'package:mindfultech_app/presentation/timer/bloc/timer/timer_bloc.dart';
import 'package:mindfultech_app/presentation/timer/pages/setup_timer_page.dart';
import 'package:mindfultech_app/presentation/widgets/custom_bottom_nav_bar.dart';

/// ============================================================
/// MAIN PAGE - Base Shell dengan Bottom Navigation Bar
/// ============================================================

class MainPage extends StatefulWidget {
  final AuthRepository authRepository;
  final int initialIndex;

  const MainPage({
    super.key,
    required this.authRepository,
    this.initialIndex = 0,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentNavIndex = 0;

  late final List<Widget> _pages;

  /// Default task for SetupTimerPage
  TaskModel get _defaultFocusTask => DefaultTaskHelper.createDefaultTask(
    energi: EnergyLevel.sedang,
    kategori: TaskCategory.pribadi,
  );

  @override
  void initState() {
    super.initState();

    /// FIX: pakai initialIndex dari constructor
    _currentNavIndex = widget.initialIndex;

    /// FIX: pindahkan pages ke initState (hindari context error)
    _pages = [
      const HomepagePage(),

      BlocProvider.value(
        value: context.read<TimerBloc>(),
        child: SetupTimerPage(task: _defaultFocusTask),
      ),

      const JourneyPage(),
      const StreakPage(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _currentNavIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: _onNavTap,
      ),
    );
  }

  void _onNavTap(int index) {
    setState(() => _currentNavIndex = index);
  }
}