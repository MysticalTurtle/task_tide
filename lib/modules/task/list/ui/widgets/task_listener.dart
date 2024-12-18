import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/modules/task/list/domain/bloc/task_bloc.dart';

class TaskListener extends StatelessWidget {
  const TaskListener({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        return switch (state.status) {
          // (TaskStatus.loading) => UILoadingDialog.show(context),
          (TaskStatus.failure) => _showError(
              context,
              state,
            ),
          (_) => {},
        };
      },
      listenWhen: (previous, current) => previous.status != current.status,
      child: child,
    );
  }

  void _showError(BuildContext context, TaskState state) {
    // UIToastNotication.show(
    //   description: state.appError.message,
    //   toastType: ToastType.error,
    // );
  }
}
