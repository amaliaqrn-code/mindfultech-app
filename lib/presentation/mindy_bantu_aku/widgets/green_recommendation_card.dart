import 'package:flutter/material.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import '../theme/green_theme.dart';

class GreenRecommendationCard extends StatelessWidget {
  final TaskModel? task;
  final EnergyLevel? energyLevel;
  final TaskCategory? category;

  const GreenRecommendationCard({
    super.key,
    this.task,
    this.energyLevel,
    this.category,
  });

  // Get task data with fallback to default values
  TaskModel get _effectiveTask {
    if (task != null) return task!;
    // Create default task from energy level and category
    final effectiveEnergy = energyLevel ?? EnergyLevel.rendah;
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
          color: GreenTheme.sageGreen.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Badge di dalam kartu
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: GreenTheme.sageGreenLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Hari ini coba kamu fokus ke:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: GreenTheme.sageGreen,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Icon
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: GreenTheme.sageGreenLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                effectiveTask.kategori.icon,
                color: GreenTheme.sageGreen,
                size: 44,
              ),
            ),
            const SizedBox(height: 20),

            // Task Title - gunakan namaTugas
            Text(
              effectiveTask.namaTugas,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: GreenTheme.textDark,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),

            // Task Info - kategori dan estimasi waktu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Text(
                    effectiveTask.kategori.displayName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: GreenTheme.textGrey,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    effectiveTask.formattedDuration,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: GreenTheme.sageGreen,
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

/// Green Outline Button (Helper Widget)
class GreenOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GreenOutlineButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: GreenTheme.sageGreen,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: GreenTheme.sageGreen,
            ),
          ),
        ),
      ),
    );
  }
}

/// Green Solid Button (Helper Widget)
class GreenSolidButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GreenSolidButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: GreenTheme.sageGreen,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}