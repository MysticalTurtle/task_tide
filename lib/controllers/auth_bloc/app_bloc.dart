import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_tide/core/models/user_model.dart';
import 'package:task_tide/core/storage/i_storage.dart';
import 'package:task_tide/core/storage/keys.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEv, AppState> {
  AppBloc({
    required ISecureStorage storage,
  })  : _storage = storage,
        super(const AppState.onSplashRequired()) {
    on<AppSplashCompleted>(_onSplashCompleted);
    on<AppAuthorized>(_onAppAuthorized);
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
  }

  final ISecureStorage _storage;

  void _onUserChanged(AppUserChanged ev, Emitter<AppState> emit) {
    final user = ev.user;
    emit(
      state.copyWith(
        user: user,
      ),
    );
  }

  void _onSplashCompleted(
    AppSplashCompleted ev,
    Emitter<AppState> emit,
  ) {
    if (state.status == AppStatus.splashRequired) {
      return state.user == UserModel.anonymous
          ? emit(const AppState.unauthenticated())
          : emit(AppState.authenticated(state.user));
    }
  }

  void _onAppAuthorized(AppAuthorized ev, Emitter<AppState> emit) {
    emit(AppState.authenticated(state.user));
  }

  FutureOr<void> _onLogoutRequested(
    AppLogoutRequested ev,
    Emitter<AppState> emit,
  ) async {
    // Simulate a logout delay
    await Future<void>.delayed(const Duration(seconds: 1));
    final fcmToken = await _storage.read(key: KeyStorage.fcmToken) ?? '';

    unawaited(_storage.clear());
    await _storage.write(key: KeyStorage.fcmToken, value: fcmToken);
    emit(const AppState.unauthenticated());
  }
}
