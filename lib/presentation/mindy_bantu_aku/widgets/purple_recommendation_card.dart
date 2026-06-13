import 'package:flutter/material.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import '../theme/purple_theme.dart';

/// Purple Recommendation Card Widget
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

  // Get task data with fallback to default values
  TaskModel get _effectiveTask {
    if (task != null) return task!;
    // Create default task from energy level and category
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
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: PurpleTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: PurpleTheme.borderLight,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: PurpleTheme.shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Badge
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              color: PurpleTheme.primaryPurplePale,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.bolt,
                  color: PurpleTheme.primaryPurple,
                  size: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Hari ini coba kamu fokus ke:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: PurpleTheme.primaryPurple,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: PurpleTheme.primaryPurplePale,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    effectiveTask.kategori.icon,
                    color: PurpleTheme.primaryPurple,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),

                // Task Title
                Text(
                  effectiveTask.namaTugas,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: PurpleTheme.textDark,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),

                // Task Description
                Text(
                  effectiveTask.kategori.displayName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: PurpleTheme.textGrey,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Meta info
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildMetaChip(
                      icon: Icons.category_rounded,
                      label: effectiveTask.kategori.displayName,
                    ),
                    const SizedBox(width: 12),
                    _buildMetaChip(
                      icon: Icons.timer_outlined,
                      label: '~${effectiveTask.estimasiWaktu} menit',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: PurpleTheme.backgroundCream,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: PurpleTheme.textLightGrey,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: PurpleTheme.textLightGrey,
            ),
          ),
        ],
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
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: PurpleTheme.primaryPurple,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
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
          borderRadius: BorderRadius.circular(24),
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
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}