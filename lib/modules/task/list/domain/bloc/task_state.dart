part of 'task_bloc.dart';

enum TaskStatus {
  initial(),
  success(),
  failure(),
  loading();

  bool get isInitial => this == TaskStatus.initial;
  bool get isSuccess => this == TaskStatus.success;
  bool get isFailure => this == TaskStatus.failure;
  bool get isLoading => this == TaskStatus.loading;
}

class TaskState extends Equatable {
  const TaskState({
    required this.appError,
    required this.status,
    required this.tasks,
  });

  const TaskState.initial()
      : this(
          appError: const AppError.empty(),
          status: TaskStatus.initial,
          tasks: const [],
        );

  final TaskStatus status;
  final List<TaskEntity> tasks;
  final AppError appError;

  @override
  List<Object?> get props => [
        status,
        tasks,
        appError,
      ];

  TaskState copyWith({
    TaskStatus? status,
    List<TaskEntity>? tasks,
    AppError? appError,
  }) =>
      TaskState(
        status: status ?? this.status,
        tasks: tasks ?? this.tasks,
        appError: appError ?? this.appError,
      );
}
