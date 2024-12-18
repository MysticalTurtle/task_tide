part of 'edit_task_bloc.dart';

enum EditTaskStatus {
  initial(),
  success(),
  failure(),
  loading();

  bool get isInitial => this == EditTaskStatus.initial;
  bool get isSuccess => this == EditTaskStatus.success;
  bool get isFailure => this == EditTaskStatus.failure;
  bool get isLoading => this == EditTaskStatus.loading;
}

class EditTaskState extends Equatable {
  const EditTaskState({
    required this.appError,
    this.status = EditTaskStatus.initial,
    this.task = const TaskEntity.empty(),
  });

  const EditTaskState.initial()
      : this(
          status: EditTaskStatus.initial,
          appError: const AppError.empty(),
        );

  final EditTaskStatus status;
  final AppError appError;
  final TaskEntity task;

  @override
  List<Object> get props => [
        status,
        appError,
      ];

  EditTaskState copyWith({
    TaskEntity? task,
    EditTaskStatus? status,
    AppError? appError,
  }) =>
      EditTaskState(
        status: status ?? this.status,
        appError: appError ?? this.appError,
      );
}
