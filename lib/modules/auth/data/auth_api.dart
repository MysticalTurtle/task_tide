import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:task_tide/core/models/app_error.dart';
import 'package:task_tide/modules/auth/data/request/request.dart';
import 'package:task_tide/modules/auth/data/response/response.dart';

part 'iauth.dart';

class AuthApi implements IAuth {
  const AuthApi();

  @override
  Future<(AppError?, LoginResponse?)> login(LoginResquest request) async {
    try {
      final url = Uri.parse('https://reqres.in/api/login');
      final response = await http.post(
        url,
        body: request.toJson(),
      );

      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return (null, LoginResponse.fromJson(responseJson));
      } else {
        return (
          AppError(message: responseJson['error'] as String? ?? 'Error'),
          null,
        );
      }
    } catch (e) {
      if (e is SocketException) {
        return (
          const AppError(
            message: 'No internet connection',
          ),
          null,
        );
      }
      return (
        AppError(
          message: e.toString(),
        ),
        null,
      );
    }
  }

  @override
  Future<(AppError?, RegisterResponse?)> register(
    RegisterResquest request,
  ) async {
    try {
      final url = Uri.parse('https://reqres.in/api/register');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: request.toJson(),
      );

      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return (
          null,
          RegisterResponse.fromJson(responseJson),
        );
      } else {
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
  Future<(AppError?, String?)> logout() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return (null, 'Success');
  }

  @override
  Future<(AppError?, UserResponse?)> getUser(String token) async {
    final url = Uri.parse('https://reqres.in/api/users/2');

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        return (
          const AppError(
            message: 'Error',
          ),
          null,
        );
      }

      final user = UserResponse.fromMap(
        jsonDecode(response.body) as Map<String, dynamic>,
      );

      return (null, user);
    } catch (e) {
      return (
        AppError(
          message: e.toString(),
        ),
        null,
      );
    }
  }
}
