part of 'splash_bloc.dart';

enum SplashStatus {
  initial,
  success,
  failure,
  loading,
}

extension SplashStateX on SplashStatus {
  bool get isInitial => this == SplashStatus.initial;
  bool get isSuccess => this == SplashStatus.success;
  bool get isFailure => this == SplashStatus.failure;
  bool get isLoading => this == SplashStatus.loading;
}

class SplashState extends Equatable {
  const SplashState({
    required this.appError,
    this.status = SplashStatus.initial,
    this.isLoggedIn = false,
    this.user = UserModel.anonymous,
  });

  const SplashState.initial()
      : this(
          status: SplashStatus.initial,
          isLoggedIn: false,
          appError: const AppError.empty(),
          user: UserModel.anonymous,
        );

  final SplashStatus status;
  final bool isLoggedIn;
  final AppError appError;
  final UserModel user;

  @override
  List<Object> get props => [
        status,
        isLoggedIn,
        appError,
        user,
      ];

  SplashState copyWith({
    SplashStatus? status,
    bool? isLoggedIn,
    AppError? appError,
    UserModel? user,
  }) =>
      SplashState(
        status: status ?? this.status,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        appError: appError ?? this.appError,
        user: user ?? this.user,
      );
}
