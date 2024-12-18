import 'package:task_tide/core/models/user_model.dart';

abstract class ISplash {
  Future<String?> getToken();
  Future<UserModel?> getUser();
}
