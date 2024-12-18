part of 'app_bloc.dart';

enum AppStatus {
  splashRequired(),
  authenticated(),
  unauthenticated();

  bool get isOnSplashRequired => this == AppStatus.splashRequired;
  bool get isLoggedIn => this == AppStatus.authenticated;
}

class AppState extends Equatable {
  const AppState({
    required this.status,
    this.user = UserModel.anonymous,
  });

  const AppState.authenticated(
    UserModel user,
  ) : this(
          status: AppStatus.authenticated,
          user: user,
        );

  const AppState.onSplashRequired() : this(status: AppStatus.splashRequired);

  const AppState.unauthenticated()
      : this(
          status: AppStatus.unauthenticated,
          user: UserModel.anonymous,
        );

  final AppStatus status;
  final UserModel user;

  @override
  List<Object?> get props => [
        status,
        user,
      ];

  AppState copyWith({
    AppStatus? status,
    UserModel? user,
  }) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
