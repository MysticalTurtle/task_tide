part of 'network_bloc.dart';

enum NetworkStatus {
  initial(),
  loading(),
  networkChanged(),
  startListening(),
  stopListening();

  bool get isInitial => this == NetworkStatus.initial;
  bool get isLoading => this == NetworkStatus.loading;
  bool get isNetworkChanged => this == NetworkStatus.networkChanged;
  bool get isStartListening => this == NetworkStatus.startListening;
  bool get isStopListening => this == NetworkStatus.stopListening;
}

final class NetworkState extends Equatable {
  const NetworkState({
    required this.status,
    this.resultConnectivity = const [],
  });

  const NetworkState.initial() : this(status: NetworkStatus.initial);
  const NetworkState.loading() : this(status: NetworkStatus.loading);
  const NetworkState.networkChanged()
      : this(
          status: NetworkStatus.networkChanged,
        );
  const NetworkState.startListening()
      : this(
          status: NetworkStatus.startListening,
        );
  const NetworkState.stopListening()
      : this(
          status: NetworkStatus.stopListening,
        );

  final NetworkStatus status;
  final List<ConnectivityResult> resultConnectivity;

  NetworkState copyWith({
    NetworkStatus? status,
    List<ConnectivityResult>? resultConnectivity,
  }) =>
      NetworkState(
        status: status ?? this.status,
        resultConnectivity: resultConnectivity ?? this.resultConnectivity,
      );
  @override
  List<Object> get props => [
        status,
        resultConnectivity,
      ];
}
