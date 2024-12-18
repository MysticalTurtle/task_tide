import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/modules/task/list/domain/bloc/task_bloc.dart';
import 'package:task_tide/modules/task/list/domain/entities/task_entity.dart';
import 'package:task_tide/modules/task/list/ui/widgets/task_detail_page.dart';
import 'package:task_tide/system_design/atoms/image_network/cache_image.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({required this.task, super.key});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) {
        context.read<TaskBloc>().add(DeleteTask(task: task));
      },
      
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => BlocProvider.value(
                value: context.read<TaskBloc>(),
                child: TaskDetailPage(task: task),
              ),
            ),
          );
        },
        title: Text(
          task.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          task.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        leading: UICachedNetworkImage(
          imageUrl: task.thumbnail,
          errorWidget: Image.asset('assets/img/task.png'),
        ),
      ),
    );
  }
}
