part of 'network_bloc.dart';

sealed class NetworkEv extends Equatable {
  const NetworkEv();
}

class CheckNetworkEv extends NetworkEv {
  @override
  List<Object> get props => [];
}

class ListenToNetworkEv extends NetworkEv {
  @override
  List<Object> get props => [];
}

class NetworkStateChangedEv extends NetworkEv {
  const NetworkStateChangedEv(this.result);
  final List<ConnectivityResult> result;

  @override
  List<Object> get props => [result];
}

class StopListeningEv extends NetworkEv {
  @override
  List<Object> get props => [];
}

class StartListeningEv extends NetworkEv {
  @override
  List<Object> get props => [];
}
