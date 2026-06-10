import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
// TODO: Sesuaikan import ini dengan lokasi model Task di proyekmu
import '../bloc/timer/timer_bloc.dart';
import '../bloc/timer/timer_event.dart';

class SetupTimerPage extends StatefulWidget {
  // Ubah parameter agar menerima objek data tugas yang dinamis
  final dynamic task; 

  const SetupTimerPage({super.key, required this.task});

  @override
  State<SetupTimerPage> createState() => _SetupTimerPageState();
}

class _SetupTimerPageState extends State<SetupTimerPage> {
  late final TextEditingController sessionController;
  late final TextEditingController breakController;

  @override
  void initState() {
    super.initState();
    sessionController = TextEditingController(text: "25");
    breakController = TextEditingController(text: "5");
  }

  @override
  void dispose() {
    sessionController.dispose();
    breakController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF4A90E2);

    final taskData = widget.task as TaskModel?;
    
  // Ambil data secara aman dari objek task (sesuaikan properti model tugasmu)
  final String taskTitle = taskData?.namaTugas ?? "Nama Tugas"; // Sesuaikan properti model Anda (misal: namaTugas)
  final int taskDuration = taskData?.estimasiWaktu ?? 25;      // Sesuaikan properti model Anda (misal: estimasiWaktu)
  final String taskCategory = taskData?.kategori.toString() ?? "Belajar";

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detail Fokus",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CARD DETAIL TUGAS (Sesuai Layout Atas Mockup image_ef01c3.png)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.withOpacity(0.15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: primaryBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.assignment_outlined, color: primaryBlue, size: 24),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    taskCategory,
                                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    taskTitle,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.schedule, color: Colors.grey, size: 18),
                                const SizedBox(width: 6),
                                Text(
                                  "Target Waktu:",
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                                ),
                              ],
                            ),
                            Text(
                              "$taskDuration Menit",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryBlue),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 28),
                  const Text(
                    "Pengaturan Pomodoro",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),

                  // INPUT DURASI SESI BELAJAR
                  _buildInputField(
                    label: "Durasi Kerja Per Sesi (Menit)",
                    controller: sessionController,
                    icon: Icons.timer_outlined,
                  ),
                  const SizedBox(height: 18),

                  // INPUT DURASI ISTIRAHAT
                  _buildInputField(
                    label: "Durasi Istirahat Sesi (Menit)",
                    controller: breakController,
                    icon: Icons.coffee_outlined,
                  ),
                ],
              ),
            ),
          ),

          // BOTTOM BUTTON "MULAI FOKUS"
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.1))),
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    final int perSession = int.tryParse(sessionController.text) ?? 25;
                    final int breakDuration = int.tryParse(breakController.text) ?? 5;
                    
                    context.read<TimerBloc>().add(
                      TimerEvent.setupTimer(
                        totalTarget: taskDuration, 
                        perSession: perSession,                
                        breakDuration: breakDuration,          
                      ),
                    );

                    Navigator.pushNamed(context, AppRoutes.timer);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Mulai Fokus",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({required String label, required TextEditingController controller, required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black54)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF4A90E2), size: 22),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4A90E2), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}