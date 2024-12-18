import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_tide/core/models/app_error.dart';
import 'package:task_tide/core/models/user_model.dart';
import 'package:task_tide/core/storage/i_storage.dart';

part 'splash_event.dart';
part 'splash_state.dart';

typedef SplashStateEmmitter = Emitter<SplashState>;

class SplashBloc extends Bloc<SplashEv, SplashState> {
  SplashBloc({
    required ISecureStorage secureStorage,
  })  : 
        _secureStorage = secureStorage,
        super(const SplashState.initial()) {
    on<InitEv>(_onInitEv);
  }

  final ISecureStorage _secureStorage;

  FutureOr<void> _onInitEv(InitEv ev, SplashStateEmmitter emit) async {
    emit(
      state.copyWith(status: SplashStatus.loading),
    );

    final token = await _secureStorage.read(key: 'token');
    final user = await _secureStorage.read(key: 'user');

    if (token == null || user == null) {
      emit(
        state.copyWith(
          status: SplashStatus.success,
        ),
      );
      return;
    }

    await Future<dynamic>.delayed(const Duration(seconds: 2));

    emit(
      state.copyWith(
        status: SplashStatus.success,
        user: UserModel.fromMap(json.decode(user) as Map<String, dynamic>),
        isLoggedIn: true,
      ),
    );
  }
}
