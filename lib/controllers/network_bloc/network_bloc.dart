import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'network_event.dart';
part 'network_state.dart';

typedef NetworkStateEmitter = Emitter<NetworkState>;

class NetworkBloc extends Bloc<NetworkEv, NetworkState> {
  NetworkBloc({
    required Connectivity connectivity,
  })  : _connectivity = connectivity,
        super(const NetworkState.initial()) {
    _connectivitysSubscription =
        connectivity.onConnectivityChanged.listen((results) {
      add(NetworkStateChangedEv(results));
    });

    on<CheckNetworkEv>(_onCheckNetworkEv);
    on<StartListeningEv>(_onStartListeningEv);
    on<NetworkStateChangedEv>(_onNetworkStateChangedEv);
    on<StopListeningEv>(_onStopListeningEv);
  }

  final Connectivity _connectivity;

  FutureOr<void> _onCheckNetworkEv(
    CheckNetworkEv ev,
    NetworkStateEmitter emit,
  ) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final results = await _connectivity.checkConnectivity();
    emit(
      state.copyWith(
        status: NetworkStatus.networkChanged,
        resultConnectivity: results,
      ),
    );
  }

  FutureOr<void> _onNetworkStateChangedEv(
    NetworkStateChangedEv ev,
    NetworkStateEmitter emit,
  ) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final results = await _connectivity.checkConnectivity();
    emit(
      state.copyWith(
        status: NetworkStatus.networkChanged,
        resultConnectivity: results,
      ),
    );
  }

  FutureOr<void> _onStopListeningEv(
    StopListeningEv ev,
    NetworkStateEmitter emit,
  ) async {
    emit(const NetworkState.loading());
    await _connectivitysSubscription!.cancel();
    _connectivitysSubscription = null;
    emit(const NetworkState.stopListening());
  }

  FutureOr<void> _onStartListeningEv(
    StartListeningEv ev,
    NetworkStateEmitter emit,
  ) async {
    emit(const NetworkState.loading());
    _connectivitysSubscription = null;
    _connectivitysSubscription =
        _connectivity.onConnectivityChanged.listen((results) {
      add(NetworkStateChangedEv(results));
    });
    emit(const NetworkState.startListening());
  }

  StreamSubscription<List<ConnectivityResult>>? _connectivitysSubscription;

  @override
  Future<void> close() {
    _connectivitysSubscription?.cancel();
    return super.close();
  }
}
