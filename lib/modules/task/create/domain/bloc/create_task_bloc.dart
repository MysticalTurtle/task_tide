import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/core/models/app_error.dart';
import 'package:task_tide/modules/task/list/datasource/itask.dart';
import 'package:task_tide/modules/task/list/domain/entities/task_entity.dart';

part 'create_task_event.dart';
part 'create_task_state.dart';

typedef CreateTaskStateEmitter = Emitter<CreateTaskState>;

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  CreateTaskBloc({
    required ITask localDS,
  })  : _localDS = localDS,
        super(const CreateTaskState.initial()) {
    on<InitEvent>(_onInitEv);
    on<SubmitTaskEvent>(_onSubmitTaskEv);
    on<UpdateTaskEvent>(_onUpdateTaskEv);
  }

  final ITask _localDS;

  FutureOr<void> _onInitEv(
    InitEvent ev,
    CreateTaskStateEmitter emit,
  ) async {}

  FutureOr<void> _onSubmitTaskEv(
    SubmitTaskEvent ev,
    CreateTaskStateEmitter emit,
  ) async {
    emit(
      state.copyWith(
        status: CreateTaskStatus.loading,
      ),
    );

    try {
      final (error, response) = await _localDS.createTask(
        const TaskEntity.empty().copyWith(
          title: ev.task.title,
          content: ev.task.content,
        ),
      );

      if (error != null) {
        emit(
          state.copyWith(
            status: CreateTaskStatus.failure,
            appError: error,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          status: CreateTaskStatus.success,
          task: state.task.copyWith(
            title: ev.task.title,
            content: ev.task.content,
          ),
        ),
      );
    } on AppError catch (e) {
      emit(
        state.copyWith(
          status: CreateTaskStatus.failure,
          appError: AppError(
            message: e.message,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onUpdateTaskEv(
    UpdateTaskEvent ev,
    CreateTaskStateEmitter emit,
  ) {
    emit(
      state.copyWith(task: ev.task),
    );
  }
}
