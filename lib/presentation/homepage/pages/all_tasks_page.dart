import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/core/constants/colors.dart';
import 'package:mindfultech_app/blocs/task/task_bloc.dart';
import 'package:mindfultech_app/blocs/task/task_state.dart';
import 'package:mindfultech_app/models/task_model.dart';

class AllTasksPage extends StatelessWidget {
  const AllTasksPage({super.key});

  // Menentukan warna tag kategori berdasarkan nama kategorinya
  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'belajar':
        return const Color(0xFF4597E6);
      case 'pekerjaan':
        return const Color(0xFF7B68EE);
      case 'kesehatan':
        return const Color(0xFFFF6B6B);
      case 'pribadi':
        return const Color(0xFFFF9F43);
      case 'rumah':
        return const Color(0xFF26DE81);
      default:
        return const Color(0xFFA55EEA); // Warna default untuk kategori kustom tambahan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.primary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Semua Tugas Kategori',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1A202C)),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            // Mengambil list tasks asli yang dimuat dari database lokal HP melalui BLoC
            final List<TaskModel> allTasks = state.tasks;

            if (state.status == TaskStatus.loading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }

            if (allTasks.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment_late_outlined, size: 48, color: Colors.grey),
                    SizedBox(height: 12),
                    Text(
                      'Belum ada tugas yang disimpan',
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            }

            // MENGELOMPOKKAN TUGAS BERDASARKAN KATEGORI ASLI USER
            final Map<String, List<TaskModel>> groupedTasks = {};
            for (var task in allTasks) {
              final String categoryName = task.kategori.displayName;
              if (!groupedTasks.containsKey(categoryName)) {
                groupedTasks[categoryName] = [];
              }
              groupedTasks[categoryName]!.add(task);
            }

            final List<String> categoryKeys = groupedTasks.keys.toList();

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: categoryKeys.length,
              itemBuilder: (context, index) {
                final String currentCategoryName = categoryKeys[index];
                final List<TaskModel> tasksInCategory = groupedTasks[currentCategoryName]!;
                final Color categoryColor = _getCategoryColor(currentCategoryName);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index > 0) const SizedBox(height: 28),
                    // Header Nama Kategori
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 18,
                          decoration: BoxDecoration(
                            color: categoryColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          currentCategoryName.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: categoryColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '(${tasksInCategory.length})',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Daftar item tugas di dalam kelompok kategori ini
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tasksInCategory.length,
                      itemBuilder: (context, taskIndex) {
                        final TaskModel singleTask = tasksInCategory[taskIndex];
                        return _TaskItemCard(
                          title: singleTask.namaTugas,
                          duration: '${singleTask.estimasiWaktu} Menit',
                          category: currentCategoryName,
                          categoryColor: categoryColor,
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _TaskItemCard extends StatelessWidget {
  final String title;
  final String duration;
  final String category;
  final Color categoryColor;

  const _TaskItemCard({
    required this.title,
    required this.duration,
    required this.category,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.bolt_rounded, color: AppColors.primary, size: 20),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF2D3748), letterSpacing: -0.3),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded, size: 12, color: Color(0xFF718096)),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style: const TextStyle(fontSize: 11, color: Color(0xFF718096), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: categoryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              category,
              style: TextStyle(color: categoryColor, fontWeight: FontWeight.w700, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}