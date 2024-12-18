part of 'login_bloc.dart';

sealed class LoginEv extends Equatable {
  const LoginEv();
}

class SubmitLogin extends LoginEv {
  const SubmitLogin({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
