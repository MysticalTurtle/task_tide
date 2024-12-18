import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/controllers/auth_bloc/app_bloc.dart';
import 'package:task_tide/l10n/l10n.dart';
import 'package:task_tide/modules/task/create/ui/page/create_task_page.dart';
import 'package:task_tide/modules/task/list/domain/bloc/task_bloc.dart';
import 'package:task_tide/modules/task/list/ui/widgets/task_item.dart';
import 'package:task_tide/system_design/ui.dart';

class TaskSuccessView extends StatelessWidget {
  const TaskSuccessView({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: UIAppBar(
            statusBarColor: Colors.transparent,
            title: l10n.myAccount,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  showDialog(context: context, builder: 
                  
                  (context) => AlertDialog(
                    title: Text(l10n.logout),
                    content: Text(l10n.logoutMessage),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(l10n.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.read<AppBloc>().add(const AppLogoutRequested());
                        },
                        child: Text(l10n.logout),
                      ),
                    ],
                  ),
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(
                UISpacing.md,
              ),
              child: ListView.builder(
                key: UniqueKey(),
                itemCount: state.tasks.length,
                itemBuilder: (context, index) => TaskItem(
                  task: state.tasks[index],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              final bloc = context.read<TaskBloc>();
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => BlocProvider.value(
                    value: bloc,
                    child: const CreateTaskPage(),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
