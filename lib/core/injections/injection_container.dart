// ignore_for_file: cascade_invocations

import 'package:get_it/get_it.dart';
import 'package:task_tide/modules/auth/data/auth_api.dart';
import 'package:task_tide/modules/splash/data/local/i_splash.dart';
import 'package:task_tide/modules/splash/data/local/splash.dart';
import 'package:task_tide/modules/task/list/datasource/itask.dart';
import 'package:task_tide/modules/task/list/datasource/task_local.dart';
import 'package:task_tide/modules/task/list/datasource/task_remote.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<ISplash>(Splash.new);
  
  sl.registerLazySingleton<IAuth>(AuthApi.new);

  sl.registerLazySingleton<ITask>(TaskRemote.new, instanceName: 'remote');

  sl.registerLazySingleton<ITask>(TaskLocal.new, instanceName: 'local');
}
