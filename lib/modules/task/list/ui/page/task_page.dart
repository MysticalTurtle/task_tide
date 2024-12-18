import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/core/injections/injection_container.dart';
import 'package:task_tide/modules/task/list/domain/bloc/task_bloc.dart';
import 'package:task_tide/modules/task/list/ui/page/task_screen.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(
        localDS: sl(instanceName: 'local'),
        remoteDS: sl(instanceName: 'remote'),
      )..add(const InitEvent()),
      child: const TaskScreen(),
    );
  }
}
