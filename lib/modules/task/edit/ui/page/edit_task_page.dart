import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/core/injections/injection_container.dart';
import 'package:task_tide/modules/task/edit/domain/bloc/edit_task_bloc.dart';
import 'package:task_tide/modules/task/edit/ui/page/edit_task_screen.dart';
import 'package:task_tide/modules/task/list/domain/entities/task_entity.dart';

class EditTaskPage extends StatelessWidget {
  const EditTaskPage({required this.task,super.key});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EditTaskBloc(
            localDS: sl(instanceName: 'local'),
          )..add(InitEvent()),
        ),
      ],
      child: EditTaskScreen(task: task),
    );
  }
}
