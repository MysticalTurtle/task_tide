import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/l10n/l10n.dart';
import 'package:task_tide/modules/task/edit/domain/bloc/edit_task_bloc.dart';
import 'package:task_tide/modules/task/list/domain/entities/task_entity.dart';
import 'package:task_tide/system_design/atoms/atoms.dart';
import 'package:task_tide/system_design/tokens/colors.dart';
import 'package:task_tide/system_design/tokens/spacing.dart';

class EditTaskView extends StatefulWidget {
  const EditTaskView({required this.task, super.key});

  final TaskEntity task;

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  late TextEditingController _titleController;
  late TextEditingController _detailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.task.title);
    _detailController = TextEditingController(text: widget.task.content);
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
          appBar: UIAppBar(
            statusBarColor: CColors.primaryColor,
            title: l10n.editTask,
          ),
          backgroundColor: CColors.white,
          body: BlocBuilder<EditTaskBloc, EditTaskState>(
            builder: (context, state) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(UISpacing.lg),
                    child: Column(
                      children: [
                        UICachedNetworkImage(
                          imageUrl: widget.task.thumbnail,
                          height: 120,
                          errorWidget: Image.asset('assets/img/task.png'),
                        ),
                        UIVerticalSpace.xl,
                        TextFormField(
                          maxLines: null,
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: l10n.title,
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return l10n.pleaseEnterText;
                            }
                            return null;
                          },
                        ),
                        UIVerticalSpace.sm,
                        TextFormField(
                          maxLines: null,
                          controller: _detailController,
                          decoration: InputDecoration(
                            labelText: l10n.content,
                          ),
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return l10n.pleaseEnterText;
                            }
                            return null;
                          },
                        ),
                        UIVerticalSpace.xl,
                        ElevatedButton(
                          onPressed: state.status.isLoading
                              ? null
                              : () => _submit(context),
                          child: state.status.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Text(l10n.save),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<EditTaskBloc>().add(
            SubmitTaskEvent(
              widget.task.copyWith(
                title: _titleController.text,
                content: _detailController.text,
              ),
            ),
          );
    }
  }
}
