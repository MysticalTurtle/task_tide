part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends TaskEvent {
  const InitEvent();

  @override
  List<Object> get props => [];
}

class FetchTasks extends TaskEvent {
  const FetchTasks({this.fromInternet = true});

  final bool fromInternet;

  @override
  List<Object> get props => [fromInternet];
}

class DeleteTask extends TaskEvent {
  const DeleteTask({required this.task});

  final TaskEntity task;

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TaskEvent {
  const UpdateTask({required this.task});

  final TaskEntity task;

  @override
  List<Object> get props => [task];
}

class AddTask extends TaskEvent {
  const AddTask({required this.task});

  final TaskEntity task;

  @override
  List<Object> get props => [task];
}
