import 'package:equatable/equatable.dart';

class LoginResquest extends Equatable {
  const LoginResquest({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [email, password];
}
