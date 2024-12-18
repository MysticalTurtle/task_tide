import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:task_tide/core/models/app_error.dart';
import 'package:task_tide/modules/task/list/datasource/itask.dart';
import 'package:task_tide/modules/task/list/datasource/request/task_request.dart';
import 'package:task_tide/modules/task/list/datasource/response/success_response.dart';
import 'package:task_tide/modules/task/list/datasource/response/task_response.dart';
import 'package:task_tide/modules/task/list/domain/entities/task_entity.dart';

class TaskRemote implements ITask {
  const TaskRemote();

  @override
  Future<(AppError?, List<TaskResponse>?)> getTasks() async {
    try {
      final url = Uri.parse('https://jsonplaceholder.org/posts');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body) as List<dynamic>;
        return (
          null,
          responseJson
              .map(
                (e) => TaskResponse.fromMap(e as Map<String, dynamic>),
              )
              .toList()
        );
      } else {
        final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

        return (
          AppError(message: responseJson['error'] as String? ?? 'Error'),
          null,
        );
      }
    } catch (e) {
      return (
        AppError(
          message: e.toString(),
        ),
        null,
      );
    }
  }

  @override
  Future<(AppError?, SuccessResponse?)> createTask(TaskEntity task) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return (
      null,
      const SuccessResponse(message: 'Task created successfully'),
    );
  }

  @override
  Future<(AppError?, String?)> editTask(TaskEntity task) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return (const AppError(message: 'Error editing task'), null);
  }

  @override
  Future<(AppError?, String?)> deleteTask(TaskEntity task) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return (const AppError(message: 'Error deleting task'), null);
  }
}
