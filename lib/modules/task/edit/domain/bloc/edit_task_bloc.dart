import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/core/models/app_error.dart';
import 'package:task_tide/modules/task/list/datasource/itask.dart';
import 'package:task_tide/modules/task/list/datasource/request/task_request.dart';
import 'package:task_tide/modules/task/list/domain/entities/task_entity.dart';

part 'edit_task_event.dart';
part 'edit_task_state.dart';

typedef EditTaskStateEmitter = Emitter<EditTaskState>;

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  EditTaskBloc({
    required ITask localDS,
  })  : _localDS = localDS,
        super(const EditTaskState.initial()) {
    on<InitEvent>(_onInitEv);
    on<SubmitTaskEvent>(_onSubmitTaskEv);
    on<UpdateTaskEvent>(_onUpdateTaskEv);
  }

  final ITask _localDS;

  FutureOr<void> _onInitEv(
    InitEvent ev,
    EditTaskStateEmitter emit,
  ) async {}

  FutureOr<void> _onSubmitTaskEv(
    SubmitTaskEvent ev,
    EditTaskStateEmitter emit,
  ) async {
    emit(
      state.copyWith(
        status: EditTaskStatus.loading,
      ),
    );

    try {
      final (error, response) = await _localDS.editTask(
        ev.task,
      );

      if (error != null) {
        emit(
          state.copyWith(
            status: EditTaskStatus.failure,
            appError: error,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          status: EditTaskStatus.success,
        ),
      );
    } on AppError catch (e) {
      emit(
        state.copyWith(
          status: EditTaskStatus.failure,
          appError: AppError(
            message: e.message,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onUpdateTaskEv(
    UpdateTaskEvent ev,
    EditTaskStateEmitter emit,
  ) {
    emit(
      state.copyWith(task: ev.task),
    );
  }
}
