import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tide/controllers/auth_bloc/app_bloc.dart';
import 'package:task_tide/core/routes/my_routes.dart';

class AuthenticatedUserListener extends StatelessWidget {
  const AuthenticatedUserListener({
    required this.child,
    required this.router,
    super.key,
  });

  final GoRouter router;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isLoggedIn) {
          router.goNamed(AppRoutes.home.toName);
        } else {
          router.goNamed(AppRoutes.login.toName);
        }
      },
      child: child,
    );
  }
}
