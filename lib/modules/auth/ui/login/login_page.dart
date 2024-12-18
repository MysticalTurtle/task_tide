import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/core/injections/injection_container.dart';
import 'package:task_tide/core/storage/i_storage.dart';
import 'package:task_tide/l10n/l10n.dart';
import 'package:task_tide/modules/auth/domain/bloc/login_bloc.dart';
import 'package:task_tide/modules/auth/ui/login/login_listener.dart';
import 'package:task_tide/system_design/ui.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Form(
      key: _formKey,
      child: BlocProvider(
        create: (context) => LoginBloc(
          secureStorage: context.read<ISecureStorage>(),
          remoteDS: sl(),
        ),
        child: LoginListener(
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(l10n.login),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(UISpacing.lg),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/img/login.png',
                            height: 120,
                          ),
                          UIVerticalSpace.xl,
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if ((value ?? '').isEmpty) {
                                return l10n.pleaseEnterText;
                              }
                              final emailRegex = RegExp(
                                r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                              );
                              if (!emailRegex.hasMatch(value!)) {
                                return l10n.pleaseValidEmail;
                              }
                              return null;
                            },
                          ),
                          UIVerticalSpace.sm,
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: l10n.password,
                            ),
                            validator: (value) {
                              if ((value ?? '').isEmpty) {
                                return l10n.pleaseEnterText;
                              }
                              return null;
                            },
                          ),
                          UIVerticalSpace.xl,
                          ElevatedButton(
                            onPressed: state.status.isLoading
                                ? null
                                : () => _submit(context),
                            child: state.status.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(l10n.login),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    final valid = _formKey.currentState?.validate() ?? false;

    if (!valid) return;

    context.read<LoginBloc>().add(
          SubmitLogin(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }
}
