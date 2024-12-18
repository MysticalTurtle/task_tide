import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/controllers/network_bloc/network_bloc.dart';
import 'package:task_tide/system_design/atoms/toast/msg_notification.dart';

class NetworkListener extends StatelessWidget {
  const NetworkListener({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkBloc, NetworkState>(
      listener: (context, state) {
        if (state.status.isNetworkChanged) {
          for (final result in state.resultConnectivity) {
            if (result == ConnectivityResult.none) {
              UIToastNotication.show(
                description: 'Se ha perdido la conexión',
                icon: Icons.wifi_off,
              );
              return;
            }
            if (result == ConnectivityResult.mobile ||
                result == ConnectivityResult.wifi) {
              UIToastNotication.show(
                description: 'Se restableción la conexión',
                icon: Icons.wifi,
              );
              return;
            }
          }
        }
      },
      child: child,
    );
  }
}
