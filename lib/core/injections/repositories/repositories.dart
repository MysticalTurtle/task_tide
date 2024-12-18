import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tide/core/notifications/local/i_local_notification.dart';
import 'package:task_tide/core/notifications/local/local_notification.dart';
import 'package:task_tide/core/notifications/remote/i_push_notification.dart';
import 'package:task_tide/core/notifications/remote/push_notification.dart';
import 'package:task_tide/core/storage/i_storage.dart';
import 'package:task_tide/core/storage/secure_storage.dart';

class Repositories {
  static List<RepositoryProvider<dynamic>> all({
    required SharedPreferences prefs,
    required LocalNotification localNotification,
    required PushNotification remoteNotification,
  }) =>
      [
        RepositoryProvider<ILocalNotification>(
          create: (_) => LocalNotification(),
        ),
        RepositoryProvider<IPushNotification>(
          create: (_) => PushNotification(
            localNotification: localNotification,
            prefs: prefs,
          ),
        ),
        RepositoryProvider<ISecureStorage>(
          create: (_) => AppSecureStorage()..init(),
        ),
      ];
}
