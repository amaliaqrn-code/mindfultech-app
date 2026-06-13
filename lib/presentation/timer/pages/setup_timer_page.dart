import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Tambahkan import ini
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import '../bloc/timer/timer_bloc.dart';
import '../bloc/timer/timer_event.dart';

class SetupTimerPage extends StatefulWidget {
  final dynamic task; 

  const SetupTimerPage({super.key, required this.task});

  @override
  State<SetupTimerPage> createState() => _SetupTimerPageState();
}

class _SetupTimerPageState extends State<SetupTimerPage> {
  late final TextEditingController totalTargetController; // Ditambahkan agar input total target bisa dinamis sesuai mockup
  late final TextEditingController sessionController;
  late final TextEditingController breakController;

  @override
  void initState() {
    super.initState();
    
    final taskData = widget.task as TaskModel?;
    final int taskDuration = taskData?.estimasiWaktu ?? 60; // Default ke 60 sesuai mockup gambar

    totalTargetController = TextEditingController(text: taskDuration.toString());
    sessionController = TextEditingController(text: "0"); // Default 30 menit sesuai gambar
    breakController = TextEditingController(text: "0");

    // Listener agar nilai menit di bagian atas otomatis terupdate saat durasi sesi diubah
    sessionController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    totalTargetController.dispose();
    sessionController.dispose();
    breakController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskData = widget.task as TaskModel?;
    
    final String taskTitle = taskData?.namaTugas ?? "Membuat Rangkuman UI/UX"; 
    final String taskCategory = taskData?.kategori.toString() ?? "Tujuan fokus hari ini";

    return Scaffold(
      body: Container(
        // Menggunakan asset background sesuai request
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/timerpage/backcground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // CUSTOM APP BAR (Tombol Back Bulat & Title "Focus")
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 44), // Jika belum ada tombol back, pakai ini dulu sebagai penyeimbang kiri

                    const Expanded(
                      child: Text(
                        "Focus",
                        textAlign: TextAlign.center, // <-- Kunci ke tengah
                        style: TextStyle(
                          color: Color(0xFF4A90E2),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // 3. Penyeimbang kanan (harus sama lebarnya dengan yang di kiri)
                    const SizedBox(width: 44), 
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      
                      // CARD ATAS: TUJUAN FOKUS HARI INI
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icon/timerpage/papanpanah.svg',
                              width: 38,
                              height: 38,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    taskCategory,
                                    style: const TextStyle(color: Color(0xFF4A90E2), fontSize: 13, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    taskTitle,
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                            // Tombol Keluar dengan Gradasi Ringan
                            Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF64B5F6), Color(0xFF4DD0E1)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  "Keluar",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),

                      // DROPDOWN MENIT INDIKATOR
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  sessionController.text,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            "Menit",
                            style: TextStyle(fontSize: 22, color: Colors.black54, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      
                      // JUDUL PENGATURAN SESI BELAJAR
                      const Text(
                        "Pengaturan sesi belajar",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Atur durasi sesuai kebutuhan",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      
                      const SizedBox(height: 24),

                      // TIGA PILIHAN PENGATURAN (Sesuai Layout Gambar)
                      _buildConfigCard(
                        title: "Target Belajar (Total)",
                        subtitle: "Total waktu yang ingin dicapai",
                        controller: totalTargetController,
                      ),
                      _buildConfigCard(
                        title: "Durasi Belajar (Per-Sesi)",
                        subtitle: "Waktu belajar di setiap sesi",
                        controller: sessionController,
                      ),
                      _buildConfigCard(
                        title: "Durasi Istirahat",
                        subtitle: "Waktu istirahat setiap jeda",
                        controller: breakController,
                      ),
                    ],
                  ),
                ),
              ),

              // BOTTOM BUTTON "MULAI FOKUS" DENGAN GRADIEN & ICON PLAY
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A90E2), Color(0xFF6FE3E1)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      final int totalTarget = int.tryParse(totalTargetController.text) ?? 60;
                      final int perSession = int.tryParse(sessionController.text) ?? 30;
                      final int breakDuration = int.tryParse(breakController.text) ?? 5;
                      
                      context.read<TimerBloc>().add(
                        TimerEvent.setupTimer(
                          totalTarget: totalTarget, 
                          perSession: perSession,                
                          breakDuration: breakDuration,          
                        ),
                      );

                      Navigator.pushNamed(context, AppRoutes.timer);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
                        SizedBox(width: 8),
                        Text(
                          "Mulai Fokus",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // REUSABLE CONFIG CARD WIDGET
  Widget _buildConfigCard({
    required String title,
    required String subtitle,
    required TextEditingController controller,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icon/timerpage/papanpanah.svg',
            width: 36,
            height: 36,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF4A90E2),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 65,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "Menit",
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}