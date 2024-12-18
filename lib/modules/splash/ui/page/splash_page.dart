import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/core/storage/i_storage.dart';
import 'package:task_tide/modules/splash/ui/bloc/splash_bloc.dart';
import 'package:task_tide/modules/splash/ui/page/splash_screen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(
        secureStorage: context.read<ISecureStorage>(),
      )..add(const InitEv()),
      child: const SplashScreen(),
    );
  }
}
