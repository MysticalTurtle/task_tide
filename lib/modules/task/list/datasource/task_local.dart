import 'dart:core';

import 'package:task_tide/core/models/app_error.dart';
import 'package:task_tide/core/storage/database_helper.dart';
import 'package:task_tide/modules/task/list/datasource/itask.dart';
import 'package:task_tide/modules/task/list/datasource/response/success_response.dart';
import 'package:task_tide/modules/task/list/datasource/response/task_response.dart';
import 'package:task_tide/modules/task/list/domain/entities/task_entity.dart';

class TaskLocal implements ITask {
  TaskLocal() : _databaseHelper = DatabaseHelper();

  late final DatabaseHelper _databaseHelper;

  @override
  Future<(AppError?, List<TaskResponse>?)> getTasks() async {
    try {
      final response = await _databaseHelper.getTasks();
      final tasks = response.map(TaskResponse.fromMap).toList();

      return (null, tasks);
    } catch (e) {
      return (const AppError(message: 'Error fetching tasks'), null);
    }
  }

  @override
  Future<(AppError?, SuccessResponse?)> createTask(TaskEntity task) async {
    try {
      await _databaseHelper.insertTask(task.toJson());
      return (null, const SuccessResponse(message: 'Success creating task'));
    } catch (e) {
      return (null, const SuccessResponse(message: 'Success creating task'));
    }
  }

  @override
  Future<(AppError?, String?)> editTask(TaskEntity task) async {
    try {
      await _databaseHelper.updateTask(task.toJson());
      return (null, 'Success editing task');
    } catch (e) {
      return (null, 'Success creating task');
    }
  }

  @override
  Future<(AppError?, String?)> deleteTask(TaskEntity task) async {
    try {
      await _databaseHelper.deleteTask(task.id);
      return (null, 'Success deleting task');
    } catch (e) {
      return (const AppError(message: 'Error deleting task'), null);
    }
  }
}
