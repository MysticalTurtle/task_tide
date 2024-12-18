import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/controllers/network_bloc/network_bloc.dart';
import 'package:task_tide/modules/task/list/domain/bloc/task_bloc.dart';

class NetworkTaskListener extends StatelessWidget {
  const NetworkTaskListener({
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
            if (result == ConnectivityResult.mobile ||
                result == ConnectivityResult.wifi) {
              context.read<TaskBloc>().add(const FetchTasks());
              return;
            }
          }
        }
      },
      child: child,
    );
  }
}
