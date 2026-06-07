import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/constants/colors.dart';

class CreateTaskCategoryPage extends StatefulWidget {
  const CreateTaskCategoryPage({super.key});

  @override
  State<CreateTaskCategoryPage> createState() => _CreateTaskCategoryPageState();
}

class _CreateTaskCategoryPageState extends State<CreateTaskCategoryPage> {
  int? _selectedCategoryIndex;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Belajar', 'icon': Icons.menu_book_rounded, 'color': const Color(0xFF4597E6)},
    {'name': 'Pekerjaan', 'icon': Icons.work_rounded, 'color': const Color(0xFF7B68EE)},
    {'name': 'Kesehatan', 'icon': Icons.favorite_rounded, 'color': const Color(0xFFFF6B6B)},
    {'name': 'Pribadi', 'icon': Icons.person_rounded, 'color': const Color(0xFFFF9F43)},
    {'name': 'Rumah', 'icon': Icons.home_rounded, 'color': const Color(0xFF26DE81)},
    {'name': 'Lainnya', 'icon': Icons.auto_awesome_rounded, 'color': const Color(0xFFA55EEA)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF2D3748), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Mau Input Tugas',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A202C),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Kategori Apa?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Pilih kategori tugasmu agar Mindy bisa membantu menentukan sesi fokus yang paling nyaman untukmu.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF718096),
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Mindy Section
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withValues(alpha: 0.05),
                          ),
                        ),
                        Positioned(top: 10, right: 15, child: _buildSparkle(const Color(0xFFFFD93D), 12)),
                        Positioned(top: 30, left: 10, child: _buildSparkle(const Color(0xFF83DFC6), 10)),
                        Positioned(bottom: 15, right: 20, child: _buildSparkle(const Color(0xFF7BBEFF), 12)),
                        Image.asset(
                          'assets/images/homepage/awan.png',
                          width: 85,
                          height: 85,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.cloud_queue_rounded, size: 55, color: AppColors.primary);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // GridView: 3 Baris (2 Kolom), Icon di Tengah, Label di Bawah
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,          // Tetap 2 kolom ke samping (Total 6 item = 3 baris)
                        crossAxisSpacing: 16,       // Jarak spasi horizontal antar boks
                        mainAxisSpacing: 14,        // Jarak spasi vertikal antar baris
                        childAspectRatio: 1.5,      // Rasio proporsional untuk meletakkan teks di bawah ikon dengan lega
                      ),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = _selectedCategoryIndex == index;
                        final color = category['color'] as Color;

                        return GestureDetector(
                          onTap: () => setState(() => _selectedCategoryIndex = index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? color : const Color(0xFFE2E8F0),
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelected 
                                      ? color.withValues(alpha: 0.12) 
                                      : Colors.black.withValues(alpha: 0.01),
                                  blurRadius: isSelected ? 10 : 4,
                                  offset: isSelected ? const Offset(0, 4) : const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // Background Icon besar samar di pojok bawah boks
                                Positioned(
                                  right: -10,
                                  bottom: -10,
                                  child: Icon(
                                    category['icon'],
                                    size: 60,
                                    color: color.withValues(alpha: 0.03),
                                  ),
                                ),
                                // Menggunakan Column untuk menumpuk Ikon di atas dan Label di bawah (Rata Tengah)
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: color.withValues(alpha: isSelected ? 0.15 : 0.08),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(category['icon'], size: 22, color: color),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          category['name'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                            color: isSelected ? color : const Color(0xFF4A5568),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
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

  Widget _buildBottomButton() {
    final bool hasSelection = _selectedCategoryIndex != null;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: GestureDetector(
        onTap: hasSelection
            ? () => Navigator.pushNamed(
                  context,
                  '/create-custom-task',
                  arguments: {'category': _categories[_selectedCategoryIndex!]},
                )
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            gradient: hasSelection
                ? const LinearGradient(colors: [Color(0xFF4597E6), Color(0xFF64B5F6), Color(0xFF83DFC6)])
                : const LinearGradient(colors: [Color(0xFFE2E8F0), Color(0xFFCBD5E1)]),
            borderRadius: BorderRadius.circular(27),
            boxShadow: hasSelection
                ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))]
                : null,
          ),
          child: const Center(
            child: Text(
              'Lanjut',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSparkle(Color color, double size) {
    return Icon(Icons.star_rounded, color: color, size: size);
  }
}