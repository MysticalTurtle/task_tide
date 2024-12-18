import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/core/injections/injection_container.dart';
import 'package:task_tide/modules/task/create/domain/bloc/create_task_bloc.dart';
import 'package:task_tide/modules/task/create/ui/page/create_task_screen.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateTaskBloc(
            localDS: sl(instanceName: 'local'),
          )..add(InitEvent()),
        ),
      ],
      child: const CreateTaskScreen(),
    );
  }
}
