import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/blocs/task/task_event.dart';
import 'package:mindfultech_app/blocs/task/task_state.dart';
import 'package:mindfultech_app/core/database/database_helper.dart';
// IMPORT FILE API SERVICE YANG BARU DIBUAT
import 'package:mindfultech_app/data/repositories/task_api_service.dart'; 

/// BLoC untuk mengelola state tugas
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DatabaseHelper _databaseHelper;
  final TaskApiService _apiService; // 👈 1. Tambahkan variabel untuk API Service

  TaskBloc({DatabaseHelper? databaseHelper, TaskApiService? apiService})
      : _databaseHelper = databaseHelper ?? DatabaseHelper(),
        _apiService = apiService ?? TaskApiService(), // 👈 2. Inisialisasi API Service
        super(TaskState.initial()) {
    on<FetchTasksEvent>(_onFetchTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<RefreshTasksEvent>(_onRefreshTasks);
  }

  /// Handler untuk FetchTasksEvent
  Future<void> _onFetchTasks(FetchTasksEvent event, Emitter<TaskState> emit) async {
    // ... [KODE FETCH TETAP SAMA] ...
  }

  /// Handler untuk AddTaskEvent - Tambahkan task baru (Lokal dulu, lalu sinkron ke API)
  Future<void> _onAddTask(
    AddTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    try {
      // PERBAIKAN LOGIKA DI SINI: Simpan ke database lokal terlebih dahulu agar tugas kustom
      // tetap tersimpan saat jaringan atau server bermasalah (optimistic insert).
      await _databaseHelper.insertTask(event.task); // PERBAIKAN LOGIKA DI SINI

      // Ambil ulang semua task untuk memperbarui UI segera (optimistic update)
      final tasks = await _databaseHelper.getAllTasks(); // PERBAIKAN LOGIKA DI SINI
      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: tasks,
      ));

      // Coba sinkronkan ke server di background. Jika gagal, biarkan data lokal tetap ada
      // dan beri informasi error tanpa menghapus item lokal.
      try {
        await _apiService.createTask(event.task); // PERBAIKAN LOGIKA DI SINI: sinkronisasi setelah insert lokal
        // Jika API mengembalikan ID/server data di masa depan, update lokal di sini.
      } catch (e) {
        // Jangan rollback insert lokal jika sinkron gagal. Tetap anggap operasi sukses lokal.
        emit(state.copyWith(
          status: TaskStatus.success,
          errorMessage: 'Tugas disimpan lokal, tetapi sinkronisasi ke server gagal: ${e.toString()}', // PERBAIKAN LOGIKA DI SINI
        ));
      }
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
      // Update ke database lokal terlebih dahulu
      await _databaseHelper.updateTask(event.task);

      // Ambil ulang semua task untuk memperbarui UI
      final tasks = await _databaseHelper.getAllTasks();
      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: tasks,
      ));

      // Sinkronkan ke server di background
      try {
        await _apiService.updateTask(event.task);
      } catch (e) {
        // Biarkan data lokal tetap ada jika sinkron gagal
        emit(state.copyWith(
          status: TaskStatus.success,
          errorMessage: 'Tugas diupdate lokal, tetapi sinkronisasi ke server gagal: ${e.toString()}',
        ));
      }
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
      // Hapus dari database lokal terlebih dahulu
      await _databaseHelper.deleteTask(event.taskId);

      // Ambil ulang semua task untuk memperbarui UI
      final tasks = await _databaseHelper.getAllTasks();
      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: tasks,
      ));

      // Sinkronkan ke server di background
      try {
        await _apiService.deleteTask(event.taskId);
      } catch (e) {
        // Biarkan data lokal tetap ada jika sinkron gagal
        emit(state.copyWith(
          status: TaskStatus.success,
          errorMessage: 'Tugas dihapus lokal, tetapi sinkronisasi ke server gagal: ${e.toString()}',
        ));
      }
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
      // Ambil semua task dari database lokal
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
}