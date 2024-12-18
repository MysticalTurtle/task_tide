import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tide/app/view/app.dart';
import 'package:task_tide/bootstrap.dart';
import 'package:task_tide/core/firebase/firebase_init.dart';
import 'package:task_tide/core/injections/injection_container.dart' as di;
import 'package:task_tide/core/notifications/local/local_notification.dart';
import 'package:task_tide/core/notifications/remote/push_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInit.init();
  final prefs = await SharedPreferences.getInstance();
  final localNotification = LocalNotification();
  await localNotification.init();
  final remoteNotification = PushNotification(
    localNotification: localNotification,
    prefs: prefs,
  );
  await remoteNotification.init();

  await di.init();
  await bootstrap(
    () => App(
      prefs: prefs,
      localNotification: localNotification,
      remoteNotification: remoteNotification,
    ),
  );
}
