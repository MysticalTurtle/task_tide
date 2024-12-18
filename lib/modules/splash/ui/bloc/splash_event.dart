part of 'splash_bloc.dart';

sealed class SplashEv extends Equatable {
  const SplashEv();
}

class InitEv extends SplashEv {
  const InitEv({this.redirectPath});

  final String? redirectPath;

  @override
  List<Object> get props => [];
}
