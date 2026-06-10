import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/data/repositories/task_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

/// BLoC untuk mengelola state tugas
/// Menggunakan pola Repository seperti AuthRepository
/// Mendukung Multi-User Isolation dan Default System Tasks
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;

  TaskBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(TaskState.initial()) {
    on<FetchTasksEvent>(_onFetchTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<RefreshTasksEvent>(_onRefreshTasks);

    // Seed default tasks saat bloc pertama kali dibuat
    _seedDefaultTasks();
  }

  /// Seed default tasks untuk user yang sedang login
  Future<void> _seedDefaultTasks() async {
    try {
      await _taskRepository.seedDefaultTasksIfNeeded();
    } catch (_) {
      // Gagal seeding tidak masalah - app tetap bisa jalan
    }
  }

  /// Handler untuk FetchTasksEvent
  Future<void> _onFetchTasks(
    FetchTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    try {
      // Ambil tasks milik user yang sedang login (user isolation)
      final tasks = await _taskRepository.getAllTasks();
      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: tasks,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TaskStatus.failure,
        errorMessage: 'Gagal memuat tugas: ${e.toString()}',
      ));
    }
  }

  /// Handler untuk AddTaskEvent - Tambahkan task baru
  Future<void> _onAddTask(
    AddTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    try {
      // Repository menangani:
      // 1. Simpan ke SQLite lokal
      // 2. Sinkronisasi ke Laravel API di background
      final savedTask = await _taskRepository.createTask(event.task);

      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: [...state.tasks, savedTask],
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TaskStatus.failure,
        errorMessage: 'Gagal menambahkan tugas: ${e.toString()}',
      ));
    }
  }

  /// Handler untuk UpdateTaskEvent - Update task yang sudah ada
  Future<void> _onUpdateTask(
    UpdateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    try {
      // Repository menangani update ke lokal dan sinkronisasi ke server
      final updatedTask = await _taskRepository.updateTask(event.task);

      // Update list dengan task yang sudah diupdate
      final updatedTasks = state.tasks.map((task) {
        return task.id == updatedTask.id ? updatedTask : task;
      }).toList();

      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: updatedTasks,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TaskStatus.failure,
        errorMessage: 'Gagal mengupdate tugas: ${e.toString()}',
      ));
    }
  }

  /// Handler untuk DeleteTaskEvent - Hapus task berdasarkan ID
  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    try {
      // Repository menangani delete dari lokal dan sinkronisasi ke server
      await _taskRepository.deleteTask(event.taskId);

      // Hapus dari list lokal
      final updatedTasks = state.tasks
          .where((task) => task.id != event.taskId)
          .toList();

      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: updatedTasks,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TaskStatus.failure,
        errorMessage: 'Gagal menghapus tugas: ${e.toString()}',
      ));
    }
  }

  /// Handler untuk RefreshTasksEvent - Refresh semua task dari database
  Future<void> _onRefreshTasks(
    RefreshTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    try {
      final tasks = await _taskRepository.getAllTasks();
      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: tasks,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TaskStatus.failure,
        errorMessage: 'Gagal memuat tugas: ${e.toString()}',
      ));
    }
  }
}
