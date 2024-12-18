import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tide/modules/task/create/domain/bloc/create_task_bloc.dart';
import 'package:task_tide/modules/task/list/domain/bloc/task_bloc.dart';
import 'package:task_tide/system_design/atoms/atoms.dart';

class CreateTaskListener extends StatelessWidget {
  const CreateTaskListener({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTaskBloc, CreateTaskState>(
      listener: (context, state) {
        return switch (state.status) {
          (CreateTaskStatus.success) => _onSuccess(context, state),
          (_) => () {},
        };
      },
      listenWhen: (previous, current) => previous.status != current.status,
      child: child,
    );
  }

  void _onSuccess(BuildContext context, CreateTaskState state) {
    context.read<TaskBloc>().add(AddTask(task: state.task));
    context.pop();
    UIToastNotication.show(
      description: 'Se guardó la tarea',
      icon: Icons.save,
    );
  }
}
