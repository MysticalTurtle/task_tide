part of 'edit_task_bloc.dart';

sealed class EditTaskEvent extends Equatable {
  const EditTaskEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends EditTaskEvent {
  @override
  List<Object> get props => [];
}

class SubmitTaskEvent extends EditTaskEvent {

  const SubmitTaskEvent(this.task);

  final TaskEntity task;

  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends EditTaskEvent {
  const UpdateTaskEvent(this.task);

  final TaskEntity task;

  @override
  List<Object> get props => [task];
}
