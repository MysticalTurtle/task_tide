part of 'create_task_bloc.dart';

enum CreateTaskStatus {
  initial(),
  success(),
  failure(),
  loading();

  bool get isInitial => this == CreateTaskStatus.initial;
  bool get isSuccess => this == CreateTaskStatus.success;
  bool get isFailure => this == CreateTaskStatus.failure;
  bool get isLoading => this == CreateTaskStatus.loading;
}

class CreateTaskState extends Equatable {
  const CreateTaskState({
    required this.appError,
    this.status = CreateTaskStatus.initial,
    this.task = const TaskEntity.empty(),
  });

  const CreateTaskState.initial()
      : this(
          status: CreateTaskStatus.initial,
          appError: const AppError.empty(),
        );

  final CreateTaskStatus status;
  final AppError appError;
  final TaskEntity task;

  @override
  List<Object> get props => [
        status,
        appError,
        task,
      ];

  CreateTaskState copyWith({
    TaskEntity? task,
    CreateTaskStatus? status,
    AppError? appError,
  }) =>
      CreateTaskState(
        task: task ?? this.task,
        status: status ?? this.status,
        appError: appError ?? this.appError,
      );
}
