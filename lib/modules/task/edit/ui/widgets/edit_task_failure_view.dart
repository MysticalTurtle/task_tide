import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/l10n/l10n.dart';
import 'package:task_tide/modules/task/edit/domain/bloc/edit_task_bloc.dart';
import 'package:task_tide/system_design/atoms/atoms.dart';

class EditTaskFailureView extends StatelessWidget {
  const EditTaskFailureView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<EditTaskBloc>().state;
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.editTask),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const UITextBody(
              'Failed to create task',
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
