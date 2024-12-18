import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_tide/core/models/app_error.dart';
import 'package:task_tide/modules/task/list/datasource/itask.dart';
import 'package:task_tide/modules/task/list/domain/entities/task_entity.dart';

part 'task_event.dart';
part 'task_state.dart';

typedef TaskStateEmitter = Emitter<TaskState>;

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc({
    required ITask remoteDS,
    required ITask localDS,
  })  : _remoteDS = remoteDS,
        _localDS = localDS,
        super(const TaskState.initial()) {
    on<InitEvent>(_onInitEvent);
    on<FetchTasks>(_onFetchTasks);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
    on<AddTask>(_onAddTask);
  }

  final ITask _remoteDS;
  final ITask _localDS;

  FutureOr<void> _onInitEvent(
    InitEvent event,
    TaskStateEmitter emit,
  ) async {
    add(const FetchTasks());
  }

  FutureOr<void> _onFetchTasks(
    FetchTasks event,
    TaskStateEmitter emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));
    if (event.fromInternet) {
      final (error, response) = await _remoteDS.getTasks();
      final tasks =
          response!.map((e) => TaskEntity.fromMap(e.toJson())).toList();
      if (error != null) {
        await _getLocalTasks(event, emit);
        return;
      } else {
        emit(state.copyWith(status: TaskStatus.success, tasks: tasks));
      }
      return;
    } else {
      await _getLocalTasks(event, emit);
    }
  }

  FutureOr<void> _onDeleteTask(
    DeleteTask event,
    TaskStateEmitter emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));
    await Future<void>.delayed(Duration.zero);
    try {
      await _localDS.deleteTask(event.task);
    } catch (e) {
      emit(
        state.copyWith(
          status: TaskStatus.failure,
          appError: const AppError(message: 'Error deleting task'),
        ),
      );
      return;
    }
    final tasks = state.tasks.where((e) => e.id != event.task.id).toList();
    emit(state.copyWith(status: TaskStatus.success, tasks: tasks));
  }

  FutureOr<void> _onUpdateTask(
    UpdateTask event,
    TaskStateEmitter emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));
    await Future<void>.delayed(const Duration(seconds: 1));
    final tasks = state.tasks.map((e) {
      if (e.id == event.task.id) {
        return event.task;
      }
      return e;
    }).toList();
    emit(state.copyWith(status: TaskStatus.success, tasks: tasks));
  }

  FutureOr<void> _onAddTask(
    AddTask event,
    TaskStateEmitter emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(
      state.copyWith(
        status: TaskStatus.success,
        tasks: [
          ...state.tasks,
          event.task,
        ],
      ),
    );
  }

  Future<void> _getLocalTasks(
    FetchTasks event,
    TaskStateEmitter emit,
  ) async {
    final (error, response) = await _localDS.getTasks();
    if (error != null) {
      emit(state.copyWith(status: TaskStatus.failure, appError: error));
    } else {
      final tasks =
          response!.map((e) => TaskEntity.fromMap(e.toJson())).toList();
      emit(
        state.copyWith(
          status: TaskStatus.success,
          tasks: tasks.map((e) => TaskEntity.fromMap(e.toJson())).toList(),
        ),
      );
    }
  }
}
