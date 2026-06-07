import 'package:flutter/material.dart';

class CreateCustomTaskPage extends StatefulWidget {
  const CreateCustomTaskPage({super.key});

  @override
  State<CreateCustomTaskPage> createState() => _CreateCustomTaskPageState();
}

class _CreateCustomTaskPageState extends State<CreateCustomTaskPage> {
  final TextEditingController _taskNameController = TextEditingController();
  // 1. TAMBAHAN: Controller untuk teks durasi kustom
  final TextEditingController _customDurationController = TextEditingController();

  int _selectedEnergyIndex = 1; // Default: Sedang
  int _selectedDurationIndex = 0; // Default: 5 Menit
  int _selectedPriorityIndex = 0; // Default: Mendesak
  Map<String, dynamic>? _selectedCategory;

  // Konfigurasi Pilihan Sesuai Gambar UI
  final List<Map<String, dynamic>> _energyOptions = [
    {
      'name': 'Rendah', 
      'icon': Icons.warning_amber_rounded, 
      'activeBg': const Color(0xFFE8F5E9), 
      'activeText': const Color(0xFF4CAF50)
    },
    {
      'name': 'Sedang', 
      'icon': Icons.stars_rounded, 
      'activeBg': const Color(0xFFE3F2FD), 
      'activeText': const Color(0xFF1E88E5)
    },
    {
      'name': 'Tinggi', 
      'icon': Icons.spa_rounded, 
      'activeBg': const Color(0xFFF3E5F5), 
      'activeText': const Color(0xFF8E24AA)
    },
  ];

  // 2. PERUBAHAN: Menambah variasi data durasi awal agar enak di-scroll
  final List<int> _durations = [5, 10, 15, 20, 25, 30, 45, 60];

  final List<Map<String, dynamic>> _priorities = [
    {
      'name': 'Mendesak', 
      'icon': Icons.report_problem_rounded, 
      'activeBg': const Color(0xFFFFCDD2), 
      'activeText': const Color(0xFFE53935)
    },
    {
      'name': 'Penting', 
      'icon': Icons.star_rate_rounded, 
      'activeBg': const Color(0xFFFFF3E0), 
      'activeText': const Color(0xFFFB8C00)
    },
    {
      'name': 'Santai', 
      'icon': Icons.spa_rounded, 
      'activeBg': const Color(0xFFE8F5E9), 
      'activeText': const Color(0xFF4CAF50)
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && _selectedCategory == null) {
      _selectedCategory = args['category'] as Map<String, dynamic>?;
    }
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    // 3. TAMBAHAN: Dispose controller custom duration agar tidak memakan memori
    _customDurationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSection(),
                    const SizedBox(height: 24),
                    _buildCategoryBadge(),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Nama Tugas'),
                    const SizedBox(height: 12),
                    _buildInputField(),
                    const SizedBox(height: 28),
                    _buildSectionTitle('Tingkat Energi Hari Ini'),
                    const SizedBox(height: 12),
                    _buildEnergySelector(),
                    const SizedBox(height: 28),
                    _buildSectionTitle('Estimasi Waktu'),
                    const SizedBox(height: 12),
                    _buildDurationSelector(), // Memanggil komponen scrollable baru
                    const SizedBox(height: 28),
                    _buildSectionTitle('Prioritas'),
                    const SizedBox(height: 12),
                    _buildPrioritySelector(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Buat Tugasmu\nSendiri',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF4597E6), height: 1.2),
              ),
              SizedBox(height: 8),
              Text(
                'Isi detail tugas sesuai kebutuhanmu.',
                style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Image.asset(
          'assets/images/homepage/awan.png',
          width: 80,
          height: 80,
          errorBuilder: (_, __, ___) => const Icon(Icons.cloud, size: 60, color: Color(0xFF4597E6)),
        ),
      ],
    );
  }

  Widget _buildCategoryBadge() {
    String categoryName = _selectedCategory != null ? _selectedCategory!['name'] : 'Belajar';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3FC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.style_rounded, color: Color(0xFF1E6091), size: 18),
          const SizedBox(width: 8),
          Text(
            'Kategori: $categoryName',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E6091), fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) => Text(
        text, 
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4597E6))
      );

  Widget _buildInputField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF90CAF9), width: 1.5),
      ),
      child: TextField(
        controller: _taskNameController,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
        decoration: const InputDecoration(
          hintText: 'Apa yang ingin kamu kerjakan?',
          hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
          suffixIcon: Icon(Icons.edit, color: Colors.black26, size: 18),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildEnergySelector() {
    return Row(
      children: _energyOptions.asMap().entries.map((entry) {
        final idx = entry.key; final opt = entry.value; final isSel = _selectedEnergyIndex == idx;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedEnergyIndex = idx),
            child: Container(
              margin: EdgeInsets.only(right: idx < 2 ? 12 : 0),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: isSel ? opt['activeBg'] : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(opt['icon'], color: isSel ? opt['activeText'] : Colors.grey, size: 28),
                  const SizedBox(height: 8),
                  Text(
                    opt['name'], 
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isSel ? opt['activeText'] : Colors.grey)
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // 4. PERUBAHAN TOTAL: Mengubah pemilih durasi statis menjadi Horizontal Scrollable + Tombol Kustom
  Widget _buildDurationSelector() {
    return SizedBox(
      height: 68, // Menentukan tinggi area scroll
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _durations.length + 1, // Ditambah 1 untuk tombol Kustom paling ujung
        itemBuilder: (context, index) {
          final isCustomBtn = index == _durations.length;
          final isSel = _selectedDurationIndex == index;
          
          final String minutesText = isCustomBtn ? '+' : '${_durations[index]}';
          final String labelText = isCustomBtn ? 'Kustom' : 'Menit';

          return GestureDetector(
            onTap: isCustomBtn 
                ? _showCustomDurationSheet 
                : () => setState(() => _selectedDurationIndex = index),
            child: Container(
              width: 64, // Mempertahankan boks persegi proporsional
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isSel ? const Color(0xFFE3F2FD) : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(16),
                border: isSel 
                    ? Border.all(color: const Color(0xFF1E88E5), width: 1.5) 
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time_filled_rounded, 
                    color: isSel ? const Color(0xFF1E88E5) : Colors.grey.shade400, 
                    size: 18,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    minutesText, 
                    style: TextStyle(
                      fontSize: 14, 
                      fontWeight: FontWeight.bold, 
                      color: isSel ? const Color(0xFF1E88E5) : Colors.black87,
                    ),
                  ),
                  Text(
                    labelText, 
                    style: TextStyle(
                      fontSize: 10, 
                      color: isSel ? const Color(0xFF1E88E5) : Colors.grey, 
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 5. TAMBAHAN: Fungsi Bottom Sheet untuk memasukkan angka kustom secara interaktif
  void _showCustomDurationSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, 
          top: 20, 
          left: 24, 
          right: 24,
        ),
        decoration: const BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, 
              height: 5, 
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(3)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Masukkan Durasi Fokus (Menit)', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _customDurationController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E88E5)),
              decoration: InputDecoration(
                hintText: '45', 
                hintStyle: TextStyle(color: Colors.grey.shade300),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF90CAF9), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                final text = _customDurationController.text.trim();
                if (text.isNotEmpty) {
                  final parsedDuration = int.tryParse(text);
                  if (parsedDuration != null && parsedDuration > 0) {
                    setState(() {
                      if (!_durations.contains(parsedDuration)) {
                        _durations.add(parsedDuration);
                        _durations.sort(); 
                      }
                      _selectedDurationIndex = _durations.indexOf(parsedDuration);
                    });
                    _customDurationController.clear();
                    Navigator.pop(context);
                  }
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF42A5F5), Color(0xFF80DEEA)]),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text(
                    'Terapkan Sesi', 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPrioritySelector() {
    return Row(
      children: _priorities.asMap().entries.map((entry) {
        final idx = entry.key; final opt = entry.value; final isSel = _selectedPriorityIndex == idx;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedPriorityIndex = idx),
            child: Container(
              margin: EdgeInsets.only(right: idx < 2 ? 12 : 0),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: isSel ? opt['activeBg'] : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(opt['icon'], color: isSel ? opt['activeText'] : Colors.grey, size: 26),
                  const SizedBox(height: 8),
                  Text(
                    opt['name'], 
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isSel ? opt['activeText'] : Colors.grey)
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20, top: 10),
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          if (_taskNameController.text.trim().isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mohon isi nama tugas terlebih dahulu!'), backgroundColor: Colors.orange)
            );
            return;
          }
          Navigator.pop(context);
        },
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF42A5F5), Color(0xFF80DEEA)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(27),
            boxShadow: [
              BoxShadow(color: const Color(0xFF42A5F5).withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))
            ],
          ),
          child: const Center(
            child: Text(
              'Simpan Tugas', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)
            )
          ),
        ),
      ),
    );
  }
}