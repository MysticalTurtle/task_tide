import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/modules/splash/ui/bloc/splash_bloc.dart';
import 'package:task_tide/modules/splash/ui/widgets/splash_listener.dart';
import 'package:task_tide/system_design/atoms/atoms.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return SplashListener(
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          return const Scaffold(
            body: Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  UIAnimation(
                    'assets/animations/splash_animation.json',
                    height: 400,
                    width: 600,
                  ),
                  UITextBody('Iniciando...'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
