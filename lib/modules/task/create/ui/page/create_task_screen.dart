import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/modules/task/create/domain/bloc/create_task_bloc.dart';
import 'package:task_tide/modules/task/create/ui/widgets/create_task_failure_view.dart';
import 'package:task_tide/modules/task/create/ui/widgets/create_task_listener.dart';
import 'package:task_tide/modules/task/create/ui/widgets/create_task_view.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateTaskListener(
      child: BlocBuilder<CreateTaskBloc, CreateTaskState>(
        builder: (context, state) {
          return switch (state.status) {
            (CreateTaskStatus.failure) => const CreateTaskFailureView(),
            (_) => const CreateTaskView(),
          };
        },
      ),
    );
  }
}
