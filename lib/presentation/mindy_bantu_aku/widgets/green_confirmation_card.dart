import 'package:flutter/material.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';
import '../theme/green_theme.dart';

/// Green Confirmation Card Widget
class GreenConfirmationCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onConfirm;

  const GreenConfirmationCard({
    super.key,
    required this.task,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            GreenTheme.backgroundWhite,
            GreenTheme.sageGreenLight,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: GreenTheme.sageGreen,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: GreenTheme.sageGreen.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success Icon
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: GreenTheme.primaryButtonGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: GreenTheme.sageGreen.withValues(alpha: 0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 20),

          // Title
          const Text(
            'Tugas yang kamu pilih:',
            style: TextStyle(
              fontSize: 14,
              color: GreenTheme.textGrey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            task.namaTugas,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: GreenTheme.textDark,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            task.kategori.displayName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: GreenTheme.textGrey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          // Meta Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMetaChip(
                icon: task.kategori.icon,
                label: task.kategori.displayName,
                color: GreenTheme.sageGreen,
              ),
              const SizedBox(width: 12),
              _buildMetaChip(
                icon: Icons.timer_outlined,
                label: '~${task.estimasiWaktu} menit',
                color: GreenTheme.sageGreen,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Encouragement
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: GreenTheme.sageGreenLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: GreenTheme.sageGreen,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Pilihan yang bagus! Ayo fokus!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: GreenTheme.sageGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}