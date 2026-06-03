import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/models/mindy_base_theme.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/widgets/mindy_widgets.dart';

/// ============================================================
/// MINDY BANTU AKU - PURPLE (High Energy)
/// ============================================================

class MindyBantuAkuPurpleScreen extends StatefulWidget {
  const MindyBantuAkuPurpleScreen({super.key});

  @override
  State<MindyBantuAkuPurpleScreen> createState() => _MindyBantuAkuPurpleScreenState();
}

class _MindyBantuAkuPurpleScreenState extends State<MindyBantuAkuPurpleScreen> {
  // Theme
  final MindyThemeColors theme = MindyBaseTheme.purple;

  // State
  int _currentStep = 0;
  int _selectedCategoryIndex = -1;
  int _selectedTaskIndex = -1;

  // Tasks for HIGH energy
  final Map<String, List<Map<String, dynamic>>> _tasksByCategory = {
    'Belajar': [
      {'title': 'Belajar coding dasar', 'duration': '3 jam', 'category': 'Belajar', 'color': const Color(0xFF7C4DFF)},
      {'title': 'Buat project web', 'duration': '4 jam', 'category': 'Belajar', 'color': const Color(0xFF7C4DFF)},
    ],
    'Pekerjaan': [
      {'title': 'Bahas email klien', 'duration': '2 jam', 'category': 'Kerja', 'color': const Color(0xFFE91E63)},
      {'title': 'Meeting project', 'duration': '2 jam', 'category': 'Kerja', 'color': const Color(0xFFE91E63)},
    ],
    'Kesehatan': [
      {'title': 'Jogging 30 menit', 'duration': '45 menit', 'category': 'Kesehatan', 'color': const Color(0xFF4CAF50)},
      {'title': 'Gym session', 'duration': '1.5 jam', 'category': 'Kesehatan', 'color': const Color(0xFF4CAF50)},
    ],
    'Pribadi': [
      {'title': 'Buat side project', 'duration': '3 jam', 'category': 'Pribadi', 'color': const Color(0xFF7BBEFF)},
      {'title': 'Learning skill baru', 'duration': '2 jam', 'category': 'Pribadi', 'color': const Color(0xFF7BBEFF)},
    ],
    'Rumah': [
      {'title': 'Deep clean rumah', 'duration': '3 jam', 'category': 'Rumah', 'color': const Color(0xFFFF9800)},
    ],
    'Lainnya': [
      {'title': 'Kerja project besar', 'duration': '4 jam', 'category': 'Lainnya', 'color': const Color(0xFF607D8B)},
    ],
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
                        useGradientTitle: true,
                      ),
                      const SizedBox(height: 24),
                      MindyCategoryGrid(
                        theme: theme,
                        selectedIndex: _selectedCategoryIndex,
                        onSelected: (i) => setState(() => _selectedCategoryIndex = i),
                      ),
                    ] else ...[
                      // Step 2: Task
                      ShaderMask(
                        shaderCallback: (b) => LinearGradient(colors: theme.gradient).createShader(b),
                        child: const Text('Task yang cocok untukmu', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
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

            // Bottom Button (Gradient + Icon)
            _buildGradientButtonWithIcon(),

            // Bottom Nav Bar
            MindyBottomNavBar(theme: theme, activeIndex: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButtonWithIcon() {
    final isEnabled = _currentStep == 0 ? _selectedCategoryIndex >= 0 : _selectedTaskIndex >= 0;

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: MediaQuery.of(context).padding.bottom + 20),
      child: GestureDetector(
        onTap: isEnabled
            ? () => _currentStep == 0
                ? setState(() { _currentStep = 1; _selectedTaskIndex = -1; })
                : Navigator.pushNamed(context, AppRoutes.timer)
            : null,
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            gradient: isEnabled ? LinearGradient(colors: theme.gradient) : null,
            color: isEnabled ? null : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(100),
            boxShadow: isEnabled ? [BoxShadow(color: theme.primary.withValues(alpha: 0.35), blurRadius: 12, offset: const Offset(0, 4))] : null,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentStep == 0) ...[
                  Icon(Icons.more_horiz_rounded, color: Colors.white.withValues(alpha: 0.8), size: 20),
                  const SizedBox(width: 8),
                ],
                Text(_currentStep == 0 ? 'Lanjut' : 'Yuk, mulai fokus!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isEnabled ? Colors.white : Colors.grey.shade500)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getCurrentTasks() {
    if (_selectedCategoryIndex < 0) return [];
    return _tasksByCategory[MindyCategory.categories[_selectedCategoryIndex].name] ?? [];
  }
}