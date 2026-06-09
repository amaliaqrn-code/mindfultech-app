import 'package:equatable/equatable.dart';
import 'package:mindfultech_app/presentation/task/models/task_model.dart';

/// Base class untuk semua event Task
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

/// Event untuk mengambil semua task dari database
class FetchTasksEvent extends TaskEvent {
  const FetchTasksEvent();
}

/// Event untuk menambahkan task baru
class AddTaskEvent extends TaskEvent {
  final TaskModel task;

  const AddTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

/// Event untuk mengupdate task yang sudah ada
class UpdateTaskEvent extends TaskEvent {
  final TaskModel task;

  const UpdateTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

/// Event untuk menghapus task
class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  const DeleteTaskEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

/// Event untuk refresh daftar task
class RefreshTasksEvent extends TaskEvent {
  const RefreshTasksEvent();
}