part of 'create_task_bloc.dart';

sealed class CreateTaskEvent extends Equatable {
  const CreateTaskEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends CreateTaskEvent {
  @override
  List<Object> get props => [];
}

class SubmitTaskEvent extends CreateTaskEvent {

  const SubmitTaskEvent(this.task);

  final TaskEntity task;

  @override
  List<Object> get props => [];
}

class UpdateTaskEvent extends CreateTaskEvent {
  const UpdateTaskEvent(this.task);

  final TaskEntity task;

  @override
  List<Object> get props => [task];
}
