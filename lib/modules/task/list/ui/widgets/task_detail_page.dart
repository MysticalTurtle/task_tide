import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/l10n/l10n.dart';
import 'package:task_tide/modules/task/edit/ui/page/edit_task_page.dart';
import 'package:task_tide/modules/task/list/domain/bloc/task_bloc.dart';
import 'package:task_tide/modules/task/list/domain/entities/task_entity.dart';
import 'package:task_tide/system_design/ui.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({required this.task, super.key});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.details),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => BlocProvider.value(
                    value: context.read<TaskBloc>(),
                    child: EditTaskPage(task: task),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(UISpacing.sl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UITextTitle(task.title),
              UIVerticalSpace.md,
              UICachedNetworkImage(
                imageUrl: task.thumbnail,
                height: 120,
                fit: BoxFit.contain,
                errorWidget: Image.asset('assets/img/task.png'),
              ),
              UIVerticalSpace.md,
              Text(task.content),
            ],
          ),
        ),
      ),
    );
  }
}
