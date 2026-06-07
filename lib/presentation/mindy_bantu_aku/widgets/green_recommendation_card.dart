import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/green_theme.dart';

class GreenRecommendationCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onConfirm;
  final VoidCallback onTryAnother;

  const GreenRecommendationCard({
    super.key,
    required this.task,
    required this.onConfirm,
    required this.onTryAnother,
  });

  IconData get _taskIcon {
    switch (task.iconName) {
      case 'edit':
        return Icons.edit;
      case 'menu_book':
        return Icons.menu_book;
      case 'spa':
        return Icons.spa;
      case 'self_improvement':
        return Icons.self_improvement;
      case 'email':
        return Icons.email;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'work':
        return Icons.work;
      case 'home':
        return Icons.home;
      case 'favorite':
        return Icons.favorite;
      case 'chat':
        return Icons.chat;
      default:
        return Icons.edit;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                _taskIcon,
                color: GreenTheme.sageGreen,
                size: 44,
              ),
            ),
            const SizedBox(height: 20),

            // Task Title
            Text(
              task.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: GreenTheme.textDark,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),

            // Task Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                task.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: GreenTheme.textGrey,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol di dalam kartu
            _GreenOutlineButton(
              text: 'Coba tugas lain',
              onTap: onTryAnother,
            ),
            const SizedBox(height: 12),
            _GreenSolidButton(
              text: 'Aku siap fokus!',
              onTap: onConfirm,
            ),
          ],
        ),
      ),
    );
  }
}

class _GreenOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _GreenOutlineButton({required this.text, required this.onTap});

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

class _GreenSolidButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _GreenSolidButton({required this.text, required this.onTap});

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