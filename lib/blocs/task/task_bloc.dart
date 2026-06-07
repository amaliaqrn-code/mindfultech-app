import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/blocs/task/task_event.dart';
import 'package:mindfultech_app/blocs/task/task_state.dart';
import 'package:mindfultech_app/core/database/database_helper.dart';

/// BLoC untuk mengelola state tugas
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DatabaseHelper _databaseHelper;

  TaskBloc({DatabaseHelper? databaseHelper})
      : _databaseHelper = databaseHelper ?? DatabaseHelper(),
        super(TaskState.initial()) {
    on<FetchTasksEvent>(_onFetchTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<RefreshTasksEvent>(_onRefreshTasks);
  }

  /// Handler untuk FetchTasksEvent - Ambil semua task dari database
  Future<void> _onFetchTasks(
    FetchTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    try {
      final tasks = await _databaseHelper.getAllTasks();
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
      await _databaseHelper.insertTask(event.task);

      // Ambil ulang semua task setelah penambahan
      final tasks = await _databaseHelper.getAllTasks();
      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: tasks,
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
      await _databaseHelper.updateTask(event.task);

      // Ambil ulang semua task setelah update
      final tasks = await _databaseHelper.getAllTasks();
      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: tasks,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TaskStatus.failure,
        errorMessage: 'Gagal mengupdate tugas: ${e.toString()}',
      ));
    }
  }

  /// Handler untuk DeleteTaskEvent - Hapus task
  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    try {
      await _databaseHelper.deleteTask(event.taskId);

      // Ambil ulang semua task setelah penghapusan
      final tasks = await _databaseHelper.getAllTasks();
      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: tasks,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TaskStatus.failure,
        errorMessage: 'Gagal menghapus tugas: ${e.toString()}',
      ));
    }
  }

  /// Handler untuk RefreshTasksEvent - Refresh daftar task
  Future<void> _onRefreshTasks(
    RefreshTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final tasks = await _databaseHelper.getAllTasks();
      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: tasks,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TaskStatus.failure,
        errorMessage: 'Gagal me-refresh tugas: ${e.toString()}',
      ));
    }
  }
}
