import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/controllers/auth_bloc/app_bloc.dart';
import 'package:task_tide/controllers/network_bloc/network_bloc.dart';
import 'package:task_tide/core/storage/i_storage.dart';

class Providers {
  static List<BlocProvider<dynamic>> all() => [
        BlocProvider<AppBloc>(
          create: (context) {
            return AppBloc(
              storage: context.read<ISecureStorage>(),
            );
          },
          lazy: false,
        ),
        BlocProvider<NetworkBloc>(
          create: (context) {
            return NetworkBloc(connectivity: Connectivity());
          },
          lazy: false,
        ),
      ];
}
