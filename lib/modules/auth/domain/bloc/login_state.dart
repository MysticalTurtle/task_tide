part of 'login_bloc.dart';

enum LoginStatus {
  initial(),
  loading(),
  success(),
  error();

  bool get isInitial => this == LoginStatus.initial;
  bool get isLoading => this == LoginStatus.loading;
  bool get isSuccess => this == LoginStatus.success;
  bool get isError => this == LoginStatus.error;
}

class LoginState extends Equatable {
  const LoginState({
    required this.status,
    required this.appError,
    this.user = UserModel.anonymous,
  });

  const LoginState.authenticated(
    UserModel user,
  ) : this(
          status: LoginStatus.success,
          user: user,
          appError: const AppError.empty(),
        );

  const LoginState.unauthenticated()
      : this(
          status: LoginStatus.initial,
          appError: const AppError.empty(),
          user: UserModel.anonymous,
        );

  final LoginStatus status;
  final UserModel user;
  final AppError appError;

  @override
  List<Object?> get props => [
        status,
        user,
        appError,
      ];

  LoginState copyWith({
    LoginStatus? status,
    UserModel? user,
    AppError? appError,
  }) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
      appError: appError ?? this.appError,
    );
  }
}
