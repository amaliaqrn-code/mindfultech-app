import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/models/mindy_base_theme.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/widgets/mindy_widgets.dart';

/// ============================================================
/// MINDY BANTU AKU - BLUE (Medium Energy)
/// ============================================================

class MindyBantuAkuBlueScreen extends StatefulWidget {
  const MindyBantuAkuBlueScreen({super.key});

  @override
  State<MindyBantuAkuBlueScreen> createState() => _MindyBantuAkuBlueScreenState();
}

class _MindyBantuAkuBlueScreenState extends State<MindyBantuAkuBlueScreen> {
  // Theme
  final MindyThemeColors theme = MindyBaseTheme.blue;

  // State
  int _currentStep = 0;
  int _selectedCategoryIndex = -1;
  int _selectedTaskIndex = -1;

  // Tasks for MEDIUM energy
  final Map<String, List<Map<String, dynamic>>> _tasksByCategory = {
    'Belajar': [
      {'title': 'Belajar UI/UX dasar', 'duration': '2 jam', 'category': 'Belajar', 'color': const Color(0xFF4597E6)},
      {'title': 'Kerjakan tugas kuliah', 'duration': '1.5 jam', 'category': 'Belajar', 'color': const Color(0xFF4597E6)},
      {'title': 'Baca materi baru', 'duration': '45 menit', 'category': 'Belajar', 'color': const Color(0xFF4597E6)},
    ],
    'Pekerjaan': [
      {'title': 'Baca email klien', 'duration': '1 jam', 'category': 'Kerja', 'color': const Color(0xFF7BBEFF)},
      {'title': 'Buat laporan harian', 'duration': '1.5 jam', 'category': 'Kerja', 'color': const Color(0xFF7BBEFF)},
    ],
    'Kesehatan': [
      {'title': 'Olahraga 30 menit', 'duration': '30 menit', 'category': 'Kesehatan', 'color': const Color(0xFFE91E63)},
      {'title': 'Yoga session', 'duration': '45 menit', 'category': 'Kesehatan', 'color': const Color(0xFFE91E63)},
    ],
    'Pribadi': [
      {'title': 'Buat jadwal mingguan', 'duration': '1 jam', 'category': 'Pribadi', 'color': const Color(0xFF9C27B0)},
      {'title': 'Planning bulan ini', 'duration': '45 menit', 'category': 'Pribadi', 'color': const Color(0xFF9C27B0)},
    ],
    'Rumah': [
      {'title': 'Bersihkan kamar', 'duration': '1 jam', 'category': 'Rumah', 'color': const Color(0xFFFF9800)},
      {'title': 'Organisir ruang kerja', 'duration': '45 menit', 'category': 'Rumah', 'color': const Color(0xFFFF9800)},
    ],
    'Lainnya': [
      {'title': 'Buat tugas poster', 'duration': '1.5 jam', 'category': 'Lainnya', 'color': const Color(0xFF607D8B)},
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

            // Bottom Button (Gradient)
            _buildGradientButton(),

            // Bottom Nav Bar
            MindyBottomNavBar(theme: theme, activeIndex: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton() {
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
          child: Center(child: Text(_currentStep == 0 ? 'Lanjut' : 'Yuk, mulai fokus!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isEnabled ? Colors.white : Colors.grey.shade500))),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getCurrentTasks() {
    if (_selectedCategoryIndex < 0) return [];
    return _tasksByCategory[MindyCategory.categories[_selectedCategoryIndex].name] ?? [];
  }
}