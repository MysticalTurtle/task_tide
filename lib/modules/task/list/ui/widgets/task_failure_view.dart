import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/l10n/l10n.dart';
import 'package:task_tide/modules/task/list/domain/bloc/task_bloc.dart';
import 'package:task_tide/modules/task/list/ui/widgets/task_item.dart';
import 'package:task_tide/system_design/ui.dart';

class TaskFailureView extends StatelessWidget {
  const TaskFailureView({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: UIAppBar(
            statusBarColor: Colors.transparent,
            title: l10n.myAccount,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(
                UISpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: state.tasks.map((e) => TaskItem(task: e)).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
