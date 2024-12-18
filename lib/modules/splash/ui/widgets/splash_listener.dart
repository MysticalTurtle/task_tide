import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/controllers/auth_bloc/app_bloc.dart';
import 'package:task_tide/modules/splash/ui/bloc/splash_bloc.dart';

class SplashListener extends StatelessWidget {
  const SplashListener({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        return switch (state.status) {
          (SplashStatus.success) => _finishSplash(context, state),
          (_) => () {},
        };
      },
      listenWhen: (previous, current) => previous.status != current.status,
      child: child,
    );
  }

  void _finishSplash(BuildContext context, SplashState state) {
    final appbloc = context.read<AppBloc>()
    ..add(AppUserChanged(state.user));
    
    return appbloc.add(
      state.isLoggedIn
          ? AppAuthorized(user: state.user)
          : const AppSplashCompleted(),
    );
  }
}
