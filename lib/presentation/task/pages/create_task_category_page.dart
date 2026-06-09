import 'package:flutter/material.dart';

class CreateTaskCategoryPage extends StatefulWidget {
  const CreateTaskCategoryPage({super.key});

  @override
  State<CreateTaskCategoryPage> createState() => _CreateTaskCategoryPageState();
}

class _CreateTaskCategoryPageState extends State<CreateTaskCategoryPage> {
  int? _selectedCategoryIndex;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Belajar', 'icon': Icons.menu_book_rounded, 'color': const Color(0xFF4FA5FF)},
    {'name': 'Pekerjaan', 'icon': Icons.work_rounded, 'color': const Color(0xFFB9A0EB)},
    {'name': 'Kesehatan', 'icon': Icons.favorite_rounded, 'color': const Color(0xFFFF6B6B)},
    {'name': 'Pribadi', 'icon': Icons.person_rounded, 'color': const Color(0xFFFFB84D)},
    {'name': 'Rumah', 'icon': Icons.home_rounded, 'color': const Color(0xFF6D9E62)},
    {'name': 'Lainnya', 'icon': Icons.auto_awesome_rounded, 'color': const Color(0xFFA55EEA)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),

      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [                              
                    // Judul & Subjudul
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFF4191FF), // Biru utama
                            Color(0xFF76E4CE), // Tosca terang (bisa diganti sesuai selera)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                        child: const Text(
                          'Pilih Kategori Tugasmu',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            // color: Color(0xFF4191FF), <--- HAPUS properti color ini
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Pilih salah satu kategori yang paling sesuai dengan tugasmu. Kamu juga bisa membuat kategori baru nanti, kok!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Gambar Maskot Mindy
                    Image.asset(
                      'assets/images/pilihenergi/energi_sedang.png',
                      height: 100,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback jika gambar belum ada di folder assets
                        return const Icon(Icons.cloud_queue_rounded, size: 80, color: Color(0xFF4FA5FF));
                      },
                    ),
                    const SizedBox(height: 30),

                    // Grid Kategori (2 Baris, 3 Kolom)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // <-- UBAH DI SINI: Menjadi 3 kolom
                        crossAxisSpacing: 12, // Sedikit dirapatkan agar pas di layar
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.95, // <-- UBAH DI SINI: Disesuaikan agar tinggi kotak tetap proporsional (tidak gepeng)
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
                              color: isSelected ? color : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? color : Colors.grey.shade300,
                                width: 1.5,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: color.withValues(alpha: 0.3),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  category['icon'],
                                  size: 28, // Sedikit dikecilkan ukurannya agar pas di kotak 3 kolom
                                  color: isSelected ? Colors.white : color,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category['name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12, // Sedikit dikecilkan agar teks tidak terpotong
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                    color: isSelected ? Colors.white : Colors.black87,
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
            // Tombol Bawah
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    final bool hasSelection = _selectedCategoryIndex != null;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
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
          height: 56,
          decoration: BoxDecoration(
            gradient: hasSelection
                ? const LinearGradient(
                    colors: [Color(0xFF42A5F5), Color(0xFF76E4CE)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : const LinearGradient(
                    colors: [Color(0xFFE2E8F0), Color(0xFFCBD5E1)],
                  ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: hasSelection
                ? [
                    BoxShadow(
                      color: const Color(0xFF42A5F5).withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: const Center(
            child: Text(
              'Lanjut',
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}