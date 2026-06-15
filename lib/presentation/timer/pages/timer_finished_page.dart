import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/data/repositories/auth_repository.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_cubit.dart';
import 'package:mindfultech_app/presentation/journey/pages/level_result_page.dart';
import 'package:mindfultech_app/presentation/main_page.dart';
import 'package:mindfultech_app/presentation/timer/bloc/timer/timer_bloc.dart';
import 'package:mindfultech_app/presentation/widgets/custom_bottom_nav_bar.dart';

class TimerFinishedPage extends StatefulWidget {
  const TimerFinishedPage({super.key});

  @override
  State<TimerFinishedPage> createState() => _TimerFinishedPageState();
}

class _TimerFinishedPageState extends State<TimerFinishedPage> {
  int? selectedEmojiIndex;

  bool _isWidgetActive = true;

  @override
  void initState() {
    super.initState();
    _isWidgetActive = true;
  }

  @override
  void deactivate() {
    _isWidgetActive = false;
    super.deactivate();
  }

  @override
  void dispose() {
    _isWidgetActive = false;
    super.dispose();
  }

  // ✅ Menggunakan list asset emoji asli milikmu (Cloud1 sampai Cloud6)
  final List<String> cloudEmojis = [
    'assets/icon/homepage/Cloud1.png',
    'assets/icon/homepage/Cloud2.png',
    'assets/icon/homepage/Cloud3.png',
    'assets/icon/homepage/Cloud4.png',
    'assets/icon/homepage/Cloud5.png',
    'assets/icon/homepage/Cloud6.png',
  ];

  @override
  Widget build(BuildContext context) {
    final journeyCubit = context.read<JourneyCubit>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // ✅ Menggunakan asset background asli milikmu
          image: DecorationImage(
            image: AssetImage('assets/images/timerpage/backcground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              children: [
                const Spacer(),

                // ✅ 1. Maskot Utama: energi_sedang.png
                Image.asset(
                  'assets/images/pilihenergi/energi_sedang.png',
                  height: 180,
                  fit: BoxFit.contain,
                ),
                
                const SizedBox(height: 24),
                
                // Text Judul & Subjudul sesuai gambar
                const Text(
                  'Yeay, selesai!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Bagaimana perasaanmu?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF34495E),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Pilih salah satu yaa',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 32),

                // ✅ 2. Kontainer Biru Tempat 6 Emoji Awan
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF42A5F5), // Biru cerah sesuai mockup
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: selectedEmojiIndex == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(cloudEmojis.length, (index) {
                      final isSelected = selectedEmojiIndex == index;
                      return GestureDetector(
                        onTap: () {
                          if (selectedEmojiIndex == index) return;

                          setState(() {
                            selectedEmojiIndex = index;
                          });

                          // ✅ FIX: Simpan emoji KE DATABASE + STORAGE
                          //    (bukan hanya ke memory state)
                          // Ambil duration dari TimerState
                          final timerState = context.read<TimerBloc>().state;
                          final durationSeconds = timerState.durationPerSession * 60;
                          context.read<JourneyCubit>().saveEmojiWithSession(
                            index,
                            durationSeconds,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.transparent,
                              width: 2.5,
                            ),
                          ),
                          child: Image.asset(
                            cloudEmojis[index],
                            width: 32,
                            height: 32,
                          ),
                        ),
                      );
                    }),
                  )    : Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Image.asset(
                        cloudEmojis[selectedEmojiIndex!],
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ), 
                ),

                const Spacer(),

                // ✅ 3. Tombol "Lanjut" (Tombol Putih Sekunder)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: selectedEmojiIndex == null
                        ? null // Mati jika belum memilih emoji harian
                        : () => _handleContinueToJourney(context, journeyCubit),
                    child: const Text(
                      'Lanjut',
                      style: TextStyle(
                        color: Color(0xFF4DA1A9), // Menyesuaikan warna tema teks tombol
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ✅ 4. Tombol Utama "Mulai Fokus Lagi" (Tombol Biru dengan Icon Play)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5AC8FA),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      // Kembali ke halaman timer/focus tanpa memicu increment hari baru
                      Navigator.pop(context); 
                    },
                    icon: const Icon(Icons.play_arrow, color: Colors.white, size: 28),
                    label: const Text(
                      'Mulai Fokus Lagi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      
      // ✅ 5. Bottom Navigation Bar menggunakan CustomBottomNavBar
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1, // Fokus aktif
        onTap: (index) => _onNavTap(context, index),
      ),
    );
  }

  void _onNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainPage, (route) => false);
        break;
      case 1:
        // Already on Fokus, do nothing
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.journey, (route) => false);
        break;
      case 3:
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.streak, (route) => false);
        break;
      case 4:
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.profile, (route) => false);
        break;
    }
  }

  Future<void> _handleContinueToJourney(BuildContext context, JourneyCubit cubit) async {
    if (!_isWidgetActive) return;
    final timerState = context.read<TimerBloc>().state;
    final durationSeconds = timerState.durationPerSession * 60;
    await cubit.completeLevelSession(durationSeconds);
    final int updatedTotalDays = cubit.state.totalDays;

    if (!_isWidgetActive) return;

    final bool isLevelCompleted = updatedTotalDays > 0 && updatedTotalDays % 5 == 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isWidgetActive) return;

      if (isLevelCompleted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => LevelResultPage(currentLevel: updatedTotalDays ~/ 5),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainPage(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        );
      }
    });
  }
}

