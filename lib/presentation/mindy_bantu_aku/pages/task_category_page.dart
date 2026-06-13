import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/widgets/green_category_grid_widget.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/widgets/blue_category_grid_widget.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/widgets/purple_category_grid_widget.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/theme/green_theme.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/theme/blue_theme.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/theme/purple_theme.dart';

/// ============================================================
/// TASK CATEGORY SELECTION SCREEN
/// Halaman pilih kategori setelah memilih energi
/// Menampilkan 3 tema kategori: Green, Blue, Purple
/// ============================================================

class TaskCategoryPage extends StatefulWidget {
  final EnergyLevel energyLevel;

  const TaskCategoryPage({
    super.key,
    required this.energyLevel,
  });

  @override
  State<TaskCategoryPage> createState() => _TaskCategoryPageState();
}

class _TaskCategoryPageState extends State<TaskCategoryPage> {
  TaskCategory? _selectedCategory;

  EnergyLevel get _energyLevel => widget.energyLevel;

  // Get theme colors based on energy level
  Color get _primaryColor {
    switch (_energyLevel) {
      case EnergyLevel.rendah:
        return GreenTheme.sageGreen;
      case EnergyLevel.sedang:
        return BlueTheme.primaryBlue;
      case EnergyLevel.tinggi:
        return PurpleTheme.primaryPurple;
    }
  }

  Color get _backgroundPage {
    switch (_energyLevel) {
      case EnergyLevel.rendah:
        return GreenTheme.backgroundPage;
      case EnergyLevel.sedang:
        return BlueTheme.backgroundPage;
      case EnergyLevel.tinggi:
        return PurpleTheme.backgroundPage;
    }
  }

  Color get _backgroundWhite {
    switch (_energyLevel) {
      case EnergyLevel.rendah:
        return GreenTheme.backgroundWhite;
      case EnergyLevel.sedang:
        return BlueTheme.backgroundWhite;
      case EnergyLevel.tinggi:
        return PurpleTheme.backgroundWhite;
    }
  }

  Color get _textDark {
    switch (_energyLevel) {
      case EnergyLevel.rendah:
        return GreenTheme.textDark;
      case EnergyLevel.sedang:
        return BlueTheme.textDark;
      case EnergyLevel.tinggi:
        return PurpleTheme.textDark;
    }
  }

  Color get _textGrey {
    switch (_energyLevel) {
      case EnergyLevel.rendah:
        return GreenTheme.textGrey;
      case EnergyLevel.sedang:
        return BlueTheme.textGrey;
      case EnergyLevel.tinggi:
        return PurpleTheme.textGrey;
    }
  }

  LinearGradient get _buttonGradient {
    switch (_energyLevel) {
      case EnergyLevel.rendah:
        return GreenTheme.primaryButtonGradient;
      case EnergyLevel.sedang:
        return BlueTheme.primaryButtonGradient;
      case EnergyLevel.tinggi:
        return PurpleTheme.primaryButtonGradient;
    }
  }


  String get _energyLabel {
    switch (_energyLevel) {
      case EnergyLevel.rendah:
        return 'Energi Rendah';
      case EnergyLevel.sedang:
        return 'Energi Sedang';
      case EnergyLevel.tinggi:
        return 'Energi Tinggi';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundPage,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    _buildTitle(),

                    const SizedBox(height: 24),

                    _buildEnergyImage(),

                    const SizedBox(height: 32),

                    _buildCategoryGrid(),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _primaryColor.withValues(alpha: 0.5),
                  width: 2,
                ),
                color: _backgroundWhite,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: _primaryColor,
                size: 18,
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _primaryColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  _selectedCategory != null ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: _primaryColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  _selectedCategory != null ? 'Kategori dipilih' : _energyLabel,
                  style: TextStyle(
                    fontSize: 12,
                    color: _primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'Pilih Kategori',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: _textDark,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Pilih kategori tugas yang sesuai dengan\nenergimu hari ini',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: _textGrey,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildEnergyImage() {
  String imagePath;

  switch (_energyLevel) {
    case EnergyLevel.rendah:
      imagePath =
          'assets/images/pilihenergi/energi_rendah.png';
      break;

    case EnergyLevel.sedang:
      imagePath =
          'assets/images/pilihenergi/energi_sedang.png';
      break;

    case EnergyLevel.tinggi:
      imagePath =
          'assets/images/pilihenergi/energi_tinggi.png';
      break;
  }

  return Image.asset(
    imagePath,
    height: 180,
    fit: BoxFit.contain,
  );
}

  Widget _buildCategoryGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Green Category Grid (for low energy)
        Text(
          'Kategori untuk Energimu',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        const SizedBox(height: 16),

        // Use appropriate grid based on energy level
        _buildCategoryGridWidget(),
      ],
    );
  }

  Widget _buildCategoryGridWidget() {
    switch (_energyLevel) {
      case EnergyLevel.rendah:
        return GreenCategoryGridWidget(
          selectedCategory: _selectedCategory,
          onCategorySelected: (category) {
            setState(() {
              _selectedCategory = category;
            });
          },
        );
      case EnergyLevel.sedang:
        return BlueCategoryGridWidget(
          selectedCategory: _selectedCategory,
          onCategorySelected: (category) {
            setState(() {
              _selectedCategory = category;
            });
          },
        );
      case EnergyLevel.tinggi:
        return PurpleCategoryGridWidget(
          selectedCategory: _selectedCategory,
          onCategorySelected: (category) {
            setState(() {
              _selectedCategory = category;
            });
          },
        );
    }
  }

  Widget _buildBottomButton() {
    final bool hasSelection = _selectedCategory != null;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: _backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: hasSelection ? _onContinue : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: hasSelection ? _buttonGradient : null,
            color: hasSelection ? null : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
            boxShadow: hasSelection
                ? [
                    BoxShadow(
                      color: _primaryColor.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              'Lanjut ke Rekomendasi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: hasSelection ? Colors.white : Colors.grey.shade500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onContinue() {
    if (_selectedCategory == null) return;

    // Navigate to appropriate recommendation page based on energy level
    switch (_energyLevel) {
      case EnergyLevel.rendah:
        Navigator.pushNamed(
          context,
          AppRoutes.greenTaskRecommendation,
          arguments: {
            'category': _selectedCategory,
            'energyLevel': _energyLevel,
          },
        );
        break;
      case EnergyLevel.sedang:
        Navigator.pushNamed(
          context,
          AppRoutes.blueTaskRecommendation,
          arguments: {
            'category': _selectedCategory,
            'energyLevel': _energyLevel,
          },
        );
        break;
      case EnergyLevel.tinggi:
        Navigator.pushNamed(
          context,
          AppRoutes.purpleTaskRecommendation,
          arguments: {
            'category': _selectedCategory,
            'energyLevel': _energyLevel,
          },
        );
        break;
    }
  }
}