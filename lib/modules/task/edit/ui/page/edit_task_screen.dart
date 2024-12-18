import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/modules/task/edit/domain/bloc/edit_task_bloc.dart';
import 'package:task_tide/modules/task/edit/ui/widgets/edit_task_failure_view.dart';
import 'package:task_tide/modules/task/edit/ui/widgets/edit_task_listener.dart';
import 'package:task_tide/modules/task/edit/ui/widgets/edit_task_view.dart';
import 'package:task_tide/modules/task/list/domain/entities/task_entity.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({required this.task, super.key});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return EditTaskListener(
      child: BlocBuilder<EditTaskBloc, EditTaskState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return switch (state.status) {
            (EditTaskStatus.failure) => const EditTaskFailureView(),
            (_) => EditTaskView(task: task),
          };
        },
      ),
    );
  }
}
