import 'package:equatable/equatable.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';

/// Status untuk operasi task
enum TaskStatus { initial, loading, success, failure }

/// State untuk TaskBloc
class TaskState extends Equatable {
  final TaskStatus status;
  final List<TaskModel> tasks;
  final String? errorMessage;

  const TaskState({
    this.status = TaskStatus.initial,
    this.tasks = const [],
    this.errorMessage,
  });

  /// State awal/default
  factory TaskState.initial() => const TaskState();

  /// Apakah sedang memuat data
  bool get isLoading => status == TaskStatus.loading;

  /// Apakah ada error
  bool get hasError => status == TaskStatus.failure;

  /// Apakah data berhasil dimuat
  bool get isLoaded => status == TaskStatus.success;

  /// Apakah tidak ada task
  bool get isEmpty => tasks.isEmpty;

  /// Jumlah task
  int get taskCount => tasks.length;

  /// Salinan state dengan data yang diperbarui
  TaskState copyWith({
    TaskStatus? status,
    List<TaskModel>? tasks,
    String? errorMessage,
  }) {
    return TaskState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, tasks, errorMessage];
}