import 'package:task_tide/core/models/app_error.dart';
import 'package:task_tide/modules/task/list/datasource/response/success_response.dart';
import 'package:task_tide/modules/task/list/datasource/response/task_response.dart';
import 'package:task_tide/modules/task/list/domain/entities/task_entity.dart';

abstract class ITask {
  Future<(AppError?, List<TaskResponse>?)> getTasks();
  Future<(AppError?, SuccessResponse?)> createTask(TaskEntity task);
  Future<(AppError?, String?)> editTask(TaskEntity task);
  Future<(AppError?, String?)> deleteTask(TaskEntity task);
}
