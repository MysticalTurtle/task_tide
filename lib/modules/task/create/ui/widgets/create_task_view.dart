import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/l10n/l10n.dart';
import 'package:task_tide/modules/task/create/domain/bloc/create_task_bloc.dart';
import 'package:task_tide/modules/task/list/domain/entities/task_entity.dart';
import 'package:task_tide/system_design/ui.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  late TextEditingController _titleController;
  late TextEditingController _detailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _titleController = TextEditingController();
    _detailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Form(
      key: _formKey,
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: CColors.primaryColor,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(l10n.createTask),
          ),
          backgroundColor: CColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(UISpacing.lg),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/img/task.png',
                      height: 120,
                    ),
                    UIVerticalSpace.xl,
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: l10n.title,
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    UIVerticalSpace.sm,
                    TextFormField(
                      controller: _detailController,
                      decoration: InputDecoration(
                        labelText: l10n.content,
                      ),
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    UIVerticalSpace.xl,
                    UIBtnPrimary(
                      // onTap: state.status.isLoading
                      //     ? null
                      //     : () => _submit(context),
                      onTap: () => _submit(context),
                      label: l10n.createTask,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();

      final task = const TaskEntity.empty().copyWith(
        title: _titleController.text,
        content: _detailController.text,
      );
      context.read<CreateTaskBloc>().add(SubmitTaskEvent(task));
    }
  }
}
