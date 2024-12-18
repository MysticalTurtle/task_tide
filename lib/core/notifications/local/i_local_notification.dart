import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class ILocalNotification {
  Future<void> init();
  Future<void> requestPermission();
  Future<void> createNotificationChannel();
  Future<NotificationAppLaunchDetails?> getNotificationAppLaunchDetails();
  void showLocalNotification({
    required int id,
    String? title,
    String? body,
    Map<String, dynamic>? data,
    RemoteNotification? notification,
  });
  void dispose();
}
