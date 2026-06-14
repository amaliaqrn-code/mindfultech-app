import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import '../theme/blue_theme.dart';

/// Blue Recommendation Card Widget (Green Structure Style)
class BlueRecommendationCard extends StatelessWidget {
  final TaskModel? task;
  final EnergyLevel? energyLevel;
  final TaskCategory? category;

  const BlueRecommendationCard({
    super.key,
    this.task,
    this.energyLevel,
    this.category,
  });

  TaskModel get _effectiveTask {
    if (task != null) return task!;
    final effectiveEnergy = energyLevel ?? EnergyLevel.sedang;
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
          color: BlueTheme.borderLight,
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
                color: BlueTheme.primaryBluePale,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Hari ini coba kamu fokus ke:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: BlueTheme.textDark,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ICON (GREEN STYLE STRUCTURE)
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: BlueTheme.primaryBluePale,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  effectiveTask.kategori.iconPath,
                  width: 44,
                  height: 44,
                  colorFilter: const ColorFilter.mode(
                    BlueTheme.primaryBlueDark,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // TITLE (GREEN STYLE STRUCTURE)
            Text(
              effectiveTask.namaTugas,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: BlueTheme.primaryBlueDark,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 12),

            // CATEGORY + DURATION (GREEN STYLE STRUCTURE)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Text(
                    effectiveTask.kategori.displayName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: BlueTheme.textGrey,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '~${effectiveTask.estimasiWaktu} menit',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: BlueTheme.textGrey,
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
/// Blue Outline Button (Helper Widget)
class BlueOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const BlueOutlineButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: BlueTheme.primaryBlueDark,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: BlueTheme.primaryBlueDark,
            ),
          ),
        ),
      ),
    );
  }
}

/// Blue Solid Button (Helper Widget)
class BlueSolidButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const BlueSolidButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          gradient: BlueTheme.solidBlueGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: BlueTheme.primaryBlue.withValues(alpha: 0.4),
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
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
