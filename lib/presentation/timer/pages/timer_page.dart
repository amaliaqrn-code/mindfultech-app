// lib/presentation/timer/pages/timer_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindfultech_app/presentation/journey/bloc/journey/journey_cubit.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import 'package:mindfultech_app/presentation/timer/pages/timer_finished_page.dart';
import 'package:mindfultech_app/presentation/timer/widgets/break_end_card.dart';
import '../bloc/timer/timer_bloc.dart';
import '../bloc/timer/timer_event.dart';
import '../bloc/timer/timer_state.dart';
import '../widgets/timer_circle_progress.dart';
import '../widgets/motivation_card.dart';
import '../widgets/break_start_card.dart';
import '../widgets/break_active_card.dart';

class TimerPage extends StatefulWidget {
  final TaskModel task;

  const TimerPage({super.key, required this.task});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  // ============================================================
  // UI-ONLY LOCAL STATE (Purely for UI transitions)
  // Tidak menyentuh Bloc/TimerState
  // ============================================================

  /// Flag untuk menentukan card mana yang sedang ditampilkan.
  /// Nilainya berubah berdasarkan state.isBreakTime dan transisi.
  ///
  /// Values:
  /// - _CardType.motivation  → Card motivasi fokus
  /// - _CardType.breakIntro → Card intro istirahat sementara (2-3 detik)
  /// - _CardType.breakActive → Card istirahat aktif final
  _CardType _currentCardType = _CardType.motivation;

  /// Tracks previous isBreakTime untuk mendeteksi transisi false → true
  bool _previousIsBreakTime = false;
  bool _isShowingBreakEnd = false;

  /// Timer untuk transisi dari breakIntro ke breakActive
  Timer? _breakIntroTimer;

  @override
  void dispose() {
    _breakIntroTimer?.cancel();
    super.dispose();
  }

  // ============================================================
  // METHOD: Handle state changes (UI-only logic)
  // ============================================================

void _handleStateChange(TimerState state) {
  // BREAK START
  if (state.isBreakTime && !_previousIsBreakTime) {
    _isShowingBreakEnd = false;
    _showBreakIntroCard();
  }

  // BREAK END
  else if (!state.isBreakTime && _previousIsBreakTime) {
    _isShowingBreakEnd = true;
    _showBreakEndCard();
  }

  _previousIsBreakTime = state.isBreakTime;
}

  void _showMotivationCard() {
    _breakIntroTimer?.cancel();

    setState(() {
      _currentCardType = _CardType.motivation;
      _isShowingBreakEnd = false; // reset state penting
    });
  }

  void _showBreakIntroCard() {
    setState(() {
      _currentCardType = _CardType.breakIntro;
    });

    // Setelah 2-3 detik, otomatis ganti ke breakActiveCard
    _breakIntroTimer?.cancel();
    _breakIntroTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _currentCardType = _CardType.breakActive;
        });
      }
    });
  }

  void _showBreakEndCard() {
    _breakIntroTimer?.cancel();

    setState(() {
      _currentCardType = _CardType.breakEndIntro;
    });

    _breakIntroTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      // ❗ pastikan masih dalam break-end flow
      if (_isShowingBreakEnd) {
        _showMotivationCard();
        setState(() {
          _currentCardType = _CardType.motivation;
          _isShowingBreakEnd = false;
        });
      }
    });
  }

  // ============================================================
  // Widget: Card Container dengan AnimatedSwitcher
  // ============================================================

  Widget _buildDynamicCard(TimerState state) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.15),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: _buildCardContent(state),
    );
  }

  Widget _buildCardContent(TimerState state) {
  switch (_currentCardType) {
    case _CardType.motivation:
      return const MotivationCard(key: ValueKey('motivation'));

    case _CardType.breakIntro:
      return BreakStartCard(
        key: const ValueKey('breakIntro'),
        breakDurationMinutes: state.breakDurationMinutes,
      );

    case _CardType.breakActive:
      return const BreakActiveCard(key: ValueKey('breakActive'));

    case _CardType.breakEndIntro:
      return const BreakEndCard(key: ValueKey('breakEnd'));
  }
}

  // ============================================================
  // MAIN BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimerBloc, TimerState>(
      listener: (context, state) {
        _handleStateChange(state);

        if (state.isAllCompleted) {
          // Send total focus time to JourneyCubit when all sessions complete
          final totalFocusSeconds = state.durationPerSession * 60;
          context.read<JourneyCubit>().onTimerSessionEnded(totalFocusSeconds);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => TimerFinishedPage(
                task: widget.task,
                focusDurationSeconds: totalFocusSeconds,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final String sessionText =
            "Sesi ${state.currentSession} dari ${state.totalSessions}";
        final String statusTitle = state.isBreakTime
            ? "Sesi Istirahat"
            : "Sesi tugas";
        final String subTitle = state.isBreakTime
            ? "Istirahatkan dirimu sejenak"
            : "Fokus dan raih tujuanmu";

        return Scaffold(
          body: Stack(
            children: [
              // 1. Background Image Penuh asli dari asetmu
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/timerpage/backcground.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // 2. Lapisan Konten Utama sesuai tata letak image_eff1a1.png
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // KARTU ATAS: "Tujuan fokus hari ini"
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Ikon Target Merah (Gunakan gambar panah atau fallback icon)
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFEBEE),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  'assets/icon/timerpage/papanpanah.svg',
                                  width: 32,
                                  height: 32,
                                )
                              ),
                              const SizedBox(width: 12),
                              // Teks Deskripsi Tugas
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Tujuan fokus hari ini",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      widget.task.namaTugas,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              // Tombol Keluar
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 32,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF5F5F5),
                                              borderRadius: BorderRadius.circular(32),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // ===== Maskot =====
                                                Image.asset(
                                                  "assets/images/timerpage/Cloud1.png",
                                                  width: 150,
                                                  height: 120,
                                                  fit: BoxFit.contain,
                                                ),

                                                const SizedBox(height: 24),

                                                const Text(
                                                  "Yakin ingin mengakhiri\nsesi mindy?",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFF263238),
                                                    height: 1.2,
                                                  ),
                                                ),

                                                const SizedBox(height: 12),

                                                const Text(
                                                  "Progres sesi ini akan dihentikan dan waktu tidak akan disimpan",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF8A8A99),
                                                    height: 1.4,
                                                  ),
                                                ),

                                                const SizedBox(height: 32),

                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: OutlinedButton(
                                                        style: OutlinedButton.styleFrom(
                                                          minimumSize: const Size.fromHeight(50),
                                                          side: const BorderSide(
                                                            color: Color(0xFF4A90E2),
                                                            width: 2,
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(18),
                                                          ),
                                                        ),

                                                        onPressed: () {
                                                          Navigator.pop(dialogContext);
                                                        },

                                                        child: const Text(
                                                          "Tetap Fokus",
                                                          style: TextStyle(
                                                            color: Color(0xFF4A90E2),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    const SizedBox(width: 16),

                                                    Expanded(
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: const Color(0xFF4A90E2),
                                                          minimumSize: const Size.fromHeight(50),
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(18),
                                                          ),
                                                        ),

                                                        onPressed: () {
                                                          context.read<TimerBloc>().add(
                                                            const TimerEvent.reset(),
                                                          );

                                                          Navigator.pop(dialogContext);
                                                          Navigator.pop(context);
                                                        },

                                                        child: const Text(
                                                          "Keluar",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF4A90E2),
                                        Color(0xFF78E6C8),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Text(
                                    "Keluar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // JUDUL STATUS DAN SUB-TITLE (Teks gelap/hitam)
                        Text(
                          statusTitle,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subTitle,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // LINGKARAN TIMER PROGRESS UTAMA
                        TimerCircleProgress(
                          timeString: state.timeString,
                          progressValue: state.progressValue,
                          sessionText: sessionText,
                          showCloud: state.isBreakTime,
                        ),

                        const SizedBox(height: 12),

                        // INDIKATOR TARGET SESI (Kapsul Biru Tengah Bawah)
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          switchInCurve: Curves.easeOutCubic,
                          switchOutCurve: Curves.easeInCubic,
                          transitionBuilder: (child, animation) {
                            final offsetAnimation = Tween<Offset>(
                              begin: const Offset(0, 0.2),
                              end: Offset.zero,
                            ).animate(animation);

                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              ),
                            );
                          },
                          child: !state.isBreakTime
                              ? Container(
                                  key: const ValueKey("session_indicator"),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4A90E2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.access_time_filled,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Target sesi ${state.currentSession} : ${state.durationPerSession} menit",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(
                                  key: ValueKey("hidden_indicator"),
                                ),
                        ),

                        const SizedBox(height: 12),

                        // ========================================
                        // KOTAK DINAMIS (AnimatedSwitcher)
                        // Fokus → Motivasi Card
                        // Break Intro → BreakStartCard (2-3 detik)
                        // Break Aktif → BreakActiveCard
                        // ========================================
                        _buildDynamicCard(state),

                        const SizedBox(height: 12),

                        // TOMBOL UTAMA "JEDA FOKUS" (Capsule Lebar Gradasi)
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF4A90E2), Color(0xFF78E6C8)],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<TimerBloc>().add(
                                  const TimerEvent.toggle(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    state.isRunning
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    state.isRunning
                                        ? "Jeda Fokus"
                                        : "Mulai Fokus",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ================================================================
// Enum untuk Card Type (UI-only state)
// ================================================================

enum _CardType {
  motivation,
  breakActive,
  breakIntro,
  breakEndIntro,
}
