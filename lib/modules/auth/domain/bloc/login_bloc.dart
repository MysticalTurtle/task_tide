import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_tide/core/models/app_error.dart';
import 'package:task_tide/core/models/user_model.dart';
import 'package:task_tide/core/storage/i_storage.dart';
import 'package:task_tide/modules/auth/data/auth_api.dart';
import 'package:task_tide/modules/auth/data/request/login_request.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEv, LoginState> {
  LoginBloc({
    required IAuth remoteDS,
    required ISecureStorage secureStorage,
  })  : _remoteDS = remoteDS,
        _secureStorage = secureStorage,
        super(const LoginState.unauthenticated()) {
    on<SubmitLogin>(_onSubmitLogin);
  }

  final IAuth _remoteDS;
  final ISecureStorage _secureStorage;

  Future<void> _onSubmitLogin(SubmitLogin ev, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));

    final (error, response) = await _remoteDS.login(
      LoginResquest(
        email: ev.email,
        password: ev.password,
      ),
    );

    if (error != null) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          appError: error,
        ),
      );
      return;
    }

    final token = response!.token;

    final (errorUser, responseUser) = await _remoteDS.getUser(token);

    if (errorUser != null) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          appError: errorUser,
        ),
      );
      return;
    }

    final userModel = UserModel.fromMap(responseUser!.toMap());
    await _secureStorage.write(key: 'token', value: token);
    final userEncoded = jsonEncode(userModel.toMap());
    await _secureStorage.write(key: 'user', value: userEncoded);

    emit(LoginState.authenticated(userModel));
  }
}
