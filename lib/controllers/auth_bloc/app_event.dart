part of 'app_bloc.dart';

sealed class AppEv extends Equatable {
  const AppEv();
}

class AppLogoutRequested extends AppEv {
  const AppLogoutRequested();
  @override
  List<Object> get props => [];
}

class AppAuthorized extends AppEv {
  const AppAuthorized({required this.user});

  final UserModel user;
  
  @override
  List<Object> get props => [user];
}

class AppUserChanged extends AppEv {
  const AppUserChanged(this.user);

  final UserModel user;

  @override
  List<Object> get props => [user];
}

class AppSplashCompleted extends AppEv {
  const AppSplashCompleted();
  @override
  List<Object> get props => [];
}

class AppOpened extends AppEv {
  const AppOpened();
  @override
  List<Object> get props => [];
}
