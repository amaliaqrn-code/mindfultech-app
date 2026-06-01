import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';

/// Layar "Mindy Bantu Aku" - Pemilihan Kategori ENERGI RENDAH
/// Tema: Hijau Hutan dengan nuansa menenangkan
class MindyBantuAkuRendahScreen extends StatefulWidget {
  const MindyBantuAkuRendahScreen({super.key});

  @override
  State<MindyBantuAkuRendahScreen> createState() => _MindyBantuAkuRendahScreenState();
}

class _MindyBantuAkuRendahScreenState extends State<MindyBantuAkuRendahScreen> {
  // Category definitions - using assets
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Belajar', 'image': 'assets/images/pilihenergi/belajar.png', 'isSelected': true},
    {'name': 'Pekerjaan', 'image': 'assets/images/pilihenergi/pekerjaan.png', 'isSelected': false},
    {'name': 'Kesehatan', 'image': 'assets/images/pilihenergi/kesehatan.png', 'isSelected': false},
    {'name': 'Pribadi', 'image': 'assets/images/pilihenergi/pribadi.png', 'isSelected': false},
    {'name': 'Rumah', 'image': 'assets/images/pilihenergi/rumah.png', 'isSelected': false},
    {'name': 'Lainnya', 'image': 'assets/images/pilihenergi/lainnya.png', 'isSelected': false},
  ];

  // Colors - Hijau Hutan
  static const Color primaryColor = Color(0xFF5D8A57);
  static const Color cardBg = Color(0xFFE3EFE0);
  static const Color subtitleColor = Color(0xFF8FA88B);

  void _selectCategory(int index) {
    setState(() {
      for (int i = 0; i < _categories.length; i++) {
        _categories[i]['isSelected'] = (i == index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildBackButton(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildMascot(),
                    const SizedBox(height: 32),
                    _buildCategoryGrid(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: primaryColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: primaryColor,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'Mau fokus kategori apa?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: primaryColor,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Pilih kategori agar Mindy bisa membantumu memilih cara terbaik',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: subtitleColor,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMascot() {
    return SizedBox(
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 10,
            top: 20,
            child: _buildFloatingLeaf(rotation: -0.4, size: 24),
          ),
          Positioned(
            right: 20,
            top: 10,
            child: _buildFloatingLeaf(rotation: 0.3, size: 20),
          ),
          Positioned(
            right: 0,
            top: 50,
            child: _buildFloatingLeaf(rotation: 0.5, size: 18),
          ),
          _buildCloudMascot(),
        ],
      ),
    );
  }

  Widget _buildFloatingLeaf({double rotation = 0, double size = 20}) {
    return Transform.rotate(
      angle: rotation,
      child: Image.asset(
        'assets/images/tutorial/daun.png',
        width: size,
        height: size,
        fit: BoxFit.contain,
        color: primaryColor.withValues(alpha: 0.75),
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.eco_rounded,
            size: size,
            color: primaryColor.withValues(alpha: 0.75),
          );
        },
      ),
    );
  }

  Widget _buildCloudMascot() {
    return Image.asset(
      'assets/images/energirendah/awanmindy1.png',
      width: 120,
      height: 100,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 100,
          height: 65,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Text('😴', style: TextStyle(fontSize: 30)),
          ),
        );
      },
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        final isSelected = category['isSelected'] as bool;
        return _buildCategoryCard(
          imagePath: category['image'] as String,
          label: category['name'] as String,
          isSelected: isSelected,
          onTap: () => _selectCategory(index),
        );
      },
    );
  }

  Widget _buildCategoryCard({
    required String imagePath,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : cardBg,
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? Border.all(color: primaryColor, width: 1.5) : null,
          boxShadow: isSelected
              ? [BoxShadow(color: primaryColor.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 2))]
              : [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(imagePath, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => _buildFallbackIcon(label)),
            ),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isSelected ? primaryColor : primaryColor.withValues(alpha: 0.8)), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackIcon(String label) {
    IconData icon;
    switch (label) {
      case 'Belajar': icon = Icons.menu_book_rounded; break;
      case 'Pekerjaan': icon = Icons.work_rounded; break;
      case 'Kesehatan': icon = Icons.favorite_rounded; break;
      case 'Pribadi': icon = Icons.person_rounded; break;
      case 'Rumah': icon = Icons.home_rounded; break;
      default: icon = Icons.auto_awesome_rounded;
    }
    return Container(
      width: 50, height: 50,
      decoration: BoxDecoration(color: primaryColor.withValues(alpha: 0.15), shape: BoxShape.circle),
      child: Icon(icon, color: primaryColor, size: 26),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.of(context).padding.bottom + 20),
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.timer),
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [BoxShadow(color: primaryColor.withValues(alpha: 0.35), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: const Center(child: Text('Lanjut', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
        ),
      ),
    );
  }
}