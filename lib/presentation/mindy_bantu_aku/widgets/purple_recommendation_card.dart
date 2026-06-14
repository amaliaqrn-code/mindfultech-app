import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import '../theme/purple_theme.dart';

class PurpleRecommendationCard extends StatelessWidget {
  final TaskModel? task;
  final EnergyLevel? energyLevel;
  final TaskCategory? category;

  const PurpleRecommendationCard({
    super.key,
    this.task,
    this.energyLevel,
    this.category,
  });

  TaskModel get _effectiveTask {
    if (task != null) return task!;
    final effectiveEnergy = energyLevel ?? EnergyLevel.tinggi;
    final effectiveCategory = category ?? TaskCategory.lainnya;

    return DefaultTaskHelper.createDefaultTask(
      energi: effectiveEnergy,
      kategori: effectiveCategory,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTask = _effectiveTask;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: PurpleTheme.borderLight,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Badge (GREEN STYLE)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: PurpleTheme.primaryPurplePale,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Hari ini coba kamu fokus ke:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: PurpleTheme.textDark,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ICON (GREEN STRUCTURE STYLE)
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: PurpleTheme.primaryPurplePale,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  effectiveTask.kategori.iconPath,
                  width: 44,
                  height: 44,
                  colorFilter: const ColorFilter.mode(
                    PurpleTheme.primaryPurpleDark,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // TITLE
            Text(
              effectiveTask.namaTugas,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: PurpleTheme.primaryPurpleDark,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 12),

            // INFO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Text(
                    effectiveTask.kategori.displayName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: PurpleTheme.textGrey,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '~${effectiveTask.estimasiWaktu} menit',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: PurpleTheme.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Purple Outline Button (Helper Widget)
class PurpleOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const PurpleOutlineButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: PurpleTheme.primaryPurple,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: PurpleTheme.primaryPurple,
            ),
          ),
        ),
      ),
    );
  }
}

/// Purple Solid Button (Helper Widget)
class PurpleSolidButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const PurpleSolidButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          gradient: PurpleTheme.solidPurpleGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: PurpleTheme.primaryPurple.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}