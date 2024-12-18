import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/modules/task/list/domain/bloc/task_bloc.dart';
import 'package:task_tide/modules/task/list/ui/widgets/network_task_listener.dart';
import 'package:task_tide/modules/task/list/ui/widgets/task_failure_view.dart';
import 'package:task_tide/modules/task/list/ui/widgets/task_listener.dart';
import 'package:task_tide/modules/task/list/ui/widgets/task_success_view.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return NetworkTaskListener(
      child: TaskListener(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            return switch (state.status) {
              (TaskStatus.failure) => const TaskFailureView(),
              (_) => const TaskSuccessView(),
            };
          },
        ),
      ),
    );
  }
}
