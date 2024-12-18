import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/l10n/l10n.dart';
import 'package:task_tide/modules/task/create/domain/bloc/create_task_bloc.dart';
import 'package:task_tide/system_design/atoms/atoms.dart';

class CreateTaskFailureView extends StatelessWidget {
  const CreateTaskFailureView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<CreateTaskBloc>().state;
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UITextBody(
              l10n.failedTask,
            ),
            const SizedBox(height: 16),
            UITextBody(
              state.appError.message,
            ),
          ],
        ),
      ),
    );
  }
}
