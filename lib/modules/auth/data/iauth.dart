part of 'auth_api.dart';

sealed class IAuth {
  Future<(AppError?, LoginResponse?)> login(LoginResquest loginResquest);
  Future<(AppError?, RegisterResponse?)> register(
    RegisterResquest registerResquest,
  );
  Future<(AppError?, UserResponse?)> getUser(String token);
  Future<(AppError?, String?)> logout();
}
