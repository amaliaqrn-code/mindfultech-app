import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/green_theme.dart';

/// Kartu konfirmasi tugas yang dipilih
class ConfirmationCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onConfirm;

  const ConfirmationCard({
    super.key,
    required this.task,
    required this.onConfirm,
  });

  IconData get _taskIcon {
    switch (task.iconName) {
      case 'desk':
        return Icons.desk;
      case 'edit_note':
        return Icons.edit_note;
      case 'local_laundry_service':
        return Icons.local_laundry_service;
      case 'local_florist':
        return Icons.local_florist;
      case 'cleaning_services':
        return Icons.cleaning_services;
      case 'king_bed':
        return Icons.king_bed;
      case 'restaurant':
        return Icons.restaurant;
      case 'bathroom':
        return Icons.bathroom;
      case 'warehouse':
        return Icons.warehouse;
      case 'self_improvement':
        return Icons.self_improvement;
      case 'local_cafe':
        return Icons.local_cafe;
      case 'accessibility_new':
        return Icons.accessibility_new;
      case 'face':
        return Icons.face;
      case 'bathtub':
        return Icons.bathtub;
      case 'spa':
        return Icons.spa;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'menu_book':
        return Icons.menu_book;
      case 'translate':
        return Icons.translate;
      case 'play_circle':
        return Icons.play_circle;
      case 'assignment':
        return Icons.assignment;
      case 'school':
        return Icons.school;
      case 'computer':
        return Icons.computer;
      case 'construction':
        return Icons.construction;
      case 'chat':
        return Icons.chat;
      case 'text_fields':
        return Icons.text_fields;
      case 'call':
        return Icons.call;
      case 'pets':
        return Icons.pets;
      case 'family_restroom':
        return Icons.family_restroom;
      case 'groups':
        return Icons.groups;
      case 'brush':
        return Icons.brush;
      case 'music_note':
        return Icons.music_note;
      case 'restaurant_menu':
        return Icons.restaurant_menu;
      case 'create':
        return Icons.create;
      case 'palette':
        return Icons.palette;
      case 'videocam':
        return Icons.videocam;
      case 'medication':
        return Icons.medication;
      case 'favorite':
        return Icons.favorite;
      case 'book':
        return Icons.book;
      case 'directions_walk':
        return Icons.directions_walk;
      case 'sports':
        return Icons.sports;
      case 'pool':
        return Icons.pool;
      case 'hiking':
        return Icons.hiking;
      default:
        return Icons.task_alt;
    }
  }

  Color get _categoryIconColor {
    switch (task.category) {
      case TaskCategory.rumah:
        return GreenTheme.categoryIconColors['rumah']!;
      case TaskCategory.pekerjaan:
        return GreenTheme.sageGreen;
      case TaskCategory.selfCare:
        return GreenTheme.categoryIconColors['selfCare']!;
      case TaskCategory.belajar:
        return GreenTheme.categoryIconColors['belajar']!;
      case TaskCategory.hubungan:
        return GreenTheme.categoryIconColors['hubungan']!;
      case TaskCategory.kreativitas:
        return GreenTheme.categoryIconColors['kreativitas']!;
      case TaskCategory.kesehatan:
        return GreenTheme.categoryIconColors['kesehatan']!;
    }
  }

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
            GreenTheme.mintGreenLight,
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
              color: GreenTheme.sageGreen,
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
            task.title,
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
            task.description,
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
                icon: _taskIcon,
                label: task.category.displayName,
                color: _categoryIconColor,
              ),
              const SizedBox(width: 12),
              _buildMetaChip(
                icon: Icons.timer_outlined,
                label: '~${task.estimatedMinutes} menit',
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
                  Icons.favorite,
                  color: GreenTheme.sageGreen,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Semangat! Kamu pasti bisa!',
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
