import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/controllers/auth_bloc/app_bloc.dart';
import 'package:task_tide/modules/auth/domain/bloc/login_bloc.dart';
import 'package:task_tide/system_design/ui.dart';

class LoginListener extends StatelessWidget {
  const LoginListener({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        return switch (state.status) {
          // (LoginStatus.loading) => UILoadingDialog.show(context),
          (LoginStatus.error) => _showError(
              context,
              state,
            ),
          (LoginStatus.success) => _authenticated(context, state),
          (_) => {},
        };
      },
      listenWhen: (previous, current) => previous.status != current.status,
      child: child,
    );
  }

  void _showError(BuildContext context, LoginState state) {
    UIToast.show(description: state.appError.message);
  }

  void _authenticated(BuildContext context, LoginState state) {
    context.read<AppBloc>().add(AppAuthorized(user: state.user));
  }
}
