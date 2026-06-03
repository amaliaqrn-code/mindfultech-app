import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/models/mindy_base_theme.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/widgets/mindy_widgets.dart';

/// ============================================================
/// MINDY BANTU AKU - GREEN (Low Energy)
/// ============================================================

class MindyBantuAkuGreenScreen extends StatefulWidget {
  const MindyBantuAkuGreenScreen({super.key});

  @override
  State<MindyBantuAkuGreenScreen> createState() => _MindyBantuAkuGreenScreenState();
}

class _MindyBantuAkuGreenScreenState extends State<MindyBantuAkuGreenScreen> {
  // Theme
  final MindyThemeColors theme = MindyBaseTheme.green;

  // State
  int _currentStep = 0;
  int _selectedCategoryIndex = -1;
  int _selectedTaskIndex = -1;

  // Tasks for LOW energy
  final Map<String, List<Map<String, dynamic>>> _tasksByCategory = {
    'Belajar': [
      {'title': 'Baca buku 5 menit', 'duration': '5 menit', 'category': 'Belajar', 'color': const Color(0xFF5D8A57)},
      {'title': 'Belajar vocabulary baru', 'duration': '10 menit', 'category': 'Belajar', 'color': const Color(0xFF5D8A57)},
    ],
    'Pekerjaan': [{'title': 'Baca email', 'duration': '10 menit', 'category': 'Kerja', 'color': const Color(0xFF4597E6)}],
    'Kesehatan': [{'title': 'Stretching ringan', 'duration': '5 menit', 'category': 'Kesehatan', 'color': const Color(0xFFE91E63)}],
    'Pribadi': [
      {'title': 'Journaling', 'duration': '10 menit', 'category': 'Pribadi', 'color': const Color(0xFF9C27B0)},
      {'title': 'Meditasi singkat', 'duration': '5 menit', 'category': 'Pribadi', 'color': const Color(0xFF9C27B0)},
    ],
    'Rumah': [{'title': 'Rapikan meja', 'duration': '5 menit', 'category': 'Rumah', 'color': const Color(0xFFFF9800)}],
    'Lainnya': [{'title': 'Update to-do list', 'duration': '5 menit', 'category': 'Lainnya', 'color': const Color(0xFF607D8B)}],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            MindyHeader(
              theme: theme,
              currentStep: _currentStep,
              onBack: () => _currentStep == 1 ? setState(() => _currentStep = 0) : Navigator.pop(context),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    if (_currentStep == 0) ...[
                      // Step 1: Category
                      MindyMascotSection(
                        theme: theme,
                        title: 'Mau fokus kategori apa?',
                        subtitle: 'Pilih kategori agar Mindy bisa\nmembantumu memilih cara terbaik',
                      ),
                      const SizedBox(height: 24),
                      MindyCategoryGrid(
                        theme: theme,
                        selectedIndex: _selectedCategoryIndex,
                        onSelected: (i) => setState(() => _selectedCategoryIndex = i),
                      ),
                    ] else ...[
                      // Step 2: Task
                      Text('Task yang cocok untukmu', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: theme.primary)),
                      const SizedBox(height: 4),
                      Text('Pilih task yang ingin kamu kerjakan', style: TextStyle(fontSize: 13, color: theme.subtitle)),
                      const SizedBox(height: 16),
                      MindyTaskList(
                        theme: theme,
                        mascotAsset: theme.mascotAsset,
                        selectedTaskIndex: _selectedTaskIndex,
                        tasks: _getCurrentTasks(),
                        onTaskSelected: (i) => setState(() => _selectedTaskIndex = i),
                        onResetSelection: () => setState(() => _selectedTaskIndex = -1),
                      ),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Button
            MindyBottomButton(
              theme: theme,
              isEnabled: _currentStep == 0 ? _selectedCategoryIndex >= 0 : _selectedTaskIndex >= 0,
              text: _currentStep == 0 ? 'Lanjut' : 'Yuk, mulai fokus!',
              onPressed: () => _currentStep == 0
                  ? setState(() { _currentStep = 1; _selectedTaskIndex = -1; })
                  : Navigator.pushNamed(context, AppRoutes.timer),
            ),

            // Bottom Nav Bar
            MindyBottomNavBar(theme: theme, activeIndex: 1),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getCurrentTasks() {
    if (_selectedCategoryIndex < 0) return [];
    return _tasksByCategory[MindyCategory.categories[_selectedCategoryIndex].name] ?? [];
  }
}