import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tide/modules/task/edit/domain/bloc/edit_task_bloc.dart';
import 'package:task_tide/modules/task/list/domain/bloc/task_bloc.dart';
import 'package:task_tide/system_design/atoms/toast/msg_notification.dart';

class EditTaskListener extends StatelessWidget {
  const EditTaskListener({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTaskBloc, EditTaskState>(
      listener: (context, state) {
        return switch (state.status) {
          (EditTaskStatus.success) => _onSuccess(context, state),
          (_) => () {},
        };
      },
      listenWhen: (previous, current) => previous.status != current.status,
      child: child,
    );
  }

  void _onSuccess(BuildContext context, EditTaskState state) {
    context.read<TaskBloc>().add(UpdateTask(task: state.task));
    context.pop();
    UIToastNotication.show(
      description: 'Se guardó la tarea',
      icon: Icons.save,
    );
  }
}
