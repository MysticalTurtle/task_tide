import 'package:equatable/equatable.dart';

class RegisterResquest extends Equatable {
  const RegisterResquest({required this.email, required this.password});

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
