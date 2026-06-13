import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import 'package:mindfultech_app/presentation/task/bloc/task/task_bloc.dart';
import 'package:mindfultech_app/presentation/task/bloc/task/task_event.dart';
import 'package:mindfultech_app/presentation/task/bloc/task/task_state.dart';
import 'package:mindfultech_app/presentation/task/pages/task_success_page.dart';

class CreateCustomTaskPage extends StatefulWidget {
  const CreateCustomTaskPage({super.key});

  @override
  State<CreateCustomTaskPage> createState() => _CreateCustomTaskPageState();
}

class _CreateCustomTaskPageState extends State<CreateCustomTaskPage> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _customDurationController = TextEditingController();

  TaskModel? _createdTask;

  int _selectedEnergyIndex = 0; // Mengikuti gambar: Default Rendah terpilih
  int _selectedDurationIndex = 2; // Mengikuti gambar: Default 15 Menit terpilih
  int _selectedPriorityIndex = 0; // Mengikuti gambar: Default Mendesak terpilih
  Map<String, dynamic>? _selectedCategory;

  // Opsi Tingkat Energi berdasarkan jalur SVG dan skema warna gambar rujukan
  final List<Map<String, dynamic>> _energyOptions = [
    {
      'name': 'Rendah',
      'icon': 'assets/icon/input_tugas/rendah.svg',
      'activeBg': const Color(0xFF6D9E62),
      'activeText': Colors.white,
      'inactiveBg': const Color(0xFFEDF4EC),
      'inactiveText': const Color(0xFF6D9E62),
    },
    {
      'name': 'Sedang',
      'icon': 'assets/icon/input_tugas/sedang.svg',
      'activeBg': const Color(0xFF4FA5FF),
      'activeText': Colors.white,
      'inactiveBg': const Color(0xFFEBF4FF),
      'inactiveText': const Color(0xFF4FA5FF),
    },
    {
      'name': 'Tinggi',
      'icon': 'assets/icon/input_tugas/tinggi.svg',
      'activeBg': const Color(0xFFB9A0EB),
      'activeText': Colors.white,
      'inactiveBg': const Color(0xFFF5F0FF),
      'inactiveText': const Color(0xFFB9A0EB),
    },
  ];

  // Durasi disesuaikan persis dengan opsi grid pada gambar rujukan
  final List<int> _durations = [5, 10, 15, 20, 25, 30];

  // Opsi Prioritas berdasarkan jalur SVG dan skema warna gambar rujukan
  final List<Map<String, dynamic>> _priorityOptions = [
    {
      'name': 'Mendesak',
      'icon': 'assets/icon/input_tugas/mendesak.svg',
      'activeBg': const Color(0xFFFF0000),
      'activeText': Colors.white,
      'inactiveBg': const Color(0xFFFFEBEB),
      'inactiveText': const Color(0xFFFF0000),
    },
    {
      'name': 'Penting',
      'icon': 'assets/icon/input_tugas/penting.svg',
      'activeBg': const Color(0xFFFFB84D),
      'activeText': Colors.white,
      'inactiveBg': const Color(0xFFFFF6E6),
      'inactiveText': const Color(0xFFFFB84D),
    },
    {
      'name': 'Santai',
      'icon': 'assets/icon/input_tugas/santai.svg',
      'activeBg': const Color(0xFF2EAA42),
      'activeText': Colors.white,
      'inactiveBg': const Color(0xFFEAF8EC),
      'inactiveText': const Color(0xFF2EAA42),
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_selectedCategory == null) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args.containsKey('category')) {
        _selectedCategory = args['category'] as Map<String, dynamic>;
      }
    }
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _customDurationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryName = _selectedCategory?['name'] as String? ?? 'Belajar';
    const primaryBlue = Color(0xFF4191FF);

    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state.status == TaskStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tugas berhasil disimpan!'),
              backgroundColor: primaryBlue,
              duration: Duration(seconds: 2),
            ),
          );
          if (_createdTask != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TaskSuccessPage(task: _createdTask!),
              ),
            );
          }
        } else if (state.status == TaskStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Gagal menyimpan tugas ke server'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tombol Back Kustom agar menyatu dengan body halaman tanpa AppBar kaku
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 22),
                  ),
                ),

                // Elemen Header Utama: Ilustrasi Awan Mindy & Teks
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/input_tugas_mindy.png',
                        height: 90,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Buat Tugasmu Sendiri',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: primaryBlue,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Isi detail tugas sesuai kebutuhan mu',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Card Badge Penanda Kategori Pilihan
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF3FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.menu_book_rounded, color: Color(0xFF1A56B1), size: 28),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Kategori', style: TextStyle(fontSize: 11, color: Color(0xFF709CE0))),
                            Text(
                              categoryName,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1A56B1)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Bagian Input Nama Tugas
                const Text(
                  'Nama Tugas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryBlue),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _taskNameController,
                  style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama tugas...',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.normal),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.edit, color: Colors.black87, size: 22),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Color(0xFF4FA5FF), width: 1.2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: primaryBlue, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Bagian Tingkat Energi (Label teks di gambar rujukan tertulis "Prioritas")
                const Text(
                  'Prioritas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryBlue),
                ),
                const SizedBox(height: 12),
                Row(
                  children: List.generate(_energyOptions.length, (index) {
                    final opt = _energyOptions[index];
                    final isSelected = _selectedEnergyIndex == index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedEnergyIndex = index),
                        child: Container(
                          margin: EdgeInsets.only(right: index == 2 ? 0 : 10),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: isSelected ? opt['activeBg'] : opt['inactiveBg'],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                opt['icon'],
                                colorFilter: ColorFilter.mode(
                                  isSelected ? opt['activeText'] : opt['inactiveText'],
                                  BlendMode.srcIn,
                                ),
                                width: 18,
                                height: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                opt['name'],
                                style: TextStyle(
                                  color: isSelected ? opt['activeText'] : opt['inactiveText'],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),

                // Bagian Estimasi Waktu (Susunan 3 Kolom Grid Berjajar)
                const Text(
                  'Estimasi Waktu',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryBlue),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _durations.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.6,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    if (index < _durations.length) {
                      final minutes = _durations[index];
                      final isSelected = _selectedDurationIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedDurationIndex = index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? primaryBlue : const Color(0xFFEBF4FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icon/input_tugas/timer.svg',
                                colorFilter: ColorFilter.mode(
                                  isSelected ? Colors.white : primaryBlue,
                                  BlendMode.srcIn,
                                ),
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '$minutes Menit',
                                style: TextStyle(
                                  color: isSelected ? Colors.white : primaryBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      // Opsi Tombol Durasi Kustom
                      final isSelected = _selectedDurationIndex == _durations.length;
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedDurationIndex = _durations.length);
                          _showCustomDurationBottomSheet();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? primaryBlue : const Color(0xFFEBF4FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icon/input_tugas/timer.svg',
                                colorFilter: ColorFilter.mode(
                                  isSelected ? Colors.white : primaryBlue,
                                  BlendMode.srcIn,
                                ),
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _customDurationController.text.isNotEmpty
                                    ? '${_customDurationController.text} Mnt'
                                    : 'Kustom +',
                                style: TextStyle(
                                  color: isSelected ? Colors.white : primaryBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 24),

                // Bagian Opsi Manajemen Prioritas Bawah
                const Text(
                  'Prioritas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryBlue),
                ),
                const SizedBox(height: 12),
                Row(
                  children: List.generate(_priorityOptions.length, (index) {
                    final opt = _priorityOptions[index];
                    final isSelected = _selectedPriorityIndex == index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedPriorityIndex = index),
                        child: Container(
                          margin: EdgeInsets.only(right: index == 2 ? 0 : 10),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: isSelected ? opt['activeBg'] : opt['inactiveBg'],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                opt['icon'],
                                colorFilter: ColorFilter.mode(
                                  isSelected ? opt['activeText'] : opt['inactiveText'],
                                  BlendMode.srcIn,
                                ),
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                opt['name'],
                                style: TextStyle(
                                  color: isSelected ? opt['activeText'] : opt['inactiveText'],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 44),

                // Tombol Simpan dengan Gradasi Linear Sesuai Gambar Rujukan
                BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state.status == TaskStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return GestureDetector(
                      onTap: () {

                        final taskName = _taskNameController.text.trim();
                        if (taskName.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Nama tugas tidak boleh kosong!'), backgroundColor: Colors.amber),
                          );
                          return;
                        }

                        final energyMap = {
                          0: EnergyLevel.rendah,
                          1: EnergyLevel.sedang,
                          2: EnergyLevel.tinggi,
                        };

                        final priorityMap = {
                          0: TaskPriority.mendesak,
                          1: TaskPriority.penting,
                          2: TaskPriority.santai,
                        };

                        final categoryNameMap = {
                          'Belajar': TaskCategory.belajar,
                          'Pekerjaan': TaskCategory.pekerjaan,
                          'Kesehatan': TaskCategory.kesehatan,
                          'Pribadi': TaskCategory.pribadi,
                          'Rumah': TaskCategory.rumah,
                          'Lainnya': TaskCategory.lainnya,
                        };

                        final category = categoryNameMap[categoryName] ?? TaskCategory.lainnya;
                        final energy = energyMap[_selectedEnergyIndex]!;
                        final priority = priorityMap[_selectedPriorityIndex]!;


                        int duration;
                        if (_selectedDurationIndex == _durations.length) {
                          duration = int.tryParse(_customDurationController.text) ?? 5;
                        } else {
                          duration = _durations[_selectedDurationIndex];
                        }

                        final newTask = TaskModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          namaTugas: taskName,
                          kategori: category,
                          energi: energy,
                          estimasiWaktu: duration,
                          prioritas: priority,
                          createdAt: DateTime.now(),
                        );

                        // TAMBAHKAN BARIS INI: Simpan ke variabel global sebelum dikirim ke Bloc
                        _createdTask = newTask;

                        context.read<TaskBloc>().add(AddTaskEvent(newTask));
                      },

                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF42A5F5), Color(0xFF76E4CE)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'Simpan Tugas',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 100), // Extra padding for bottom nav bar
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCustomDurationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Masukkan Durasi Kustom', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  controller: _customDurationController,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 25 (dalam menit)',
                    filled: true,
                    fillColor: const Color(0xFFF1F5F9),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF42A5F5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text('Terapkan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}