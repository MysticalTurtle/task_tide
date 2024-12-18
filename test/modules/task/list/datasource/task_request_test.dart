import 'package:flutter_test/flutter_test.dart';
import 'package:task_tide/modules/task/list/datasource/request/task_request.dart';

void main() {
  group('TaskRequest', () {
    test('toJson returns correct map', () {
      final taskRequest = TaskRequest(
        title: 'Test Title',
        description: 'Test Description',
      );

      final json = taskRequest.toJson();

      expect(json, {
        'title': 'Test Title',
        'description': 'Test Description',
      });
    });
  });
}