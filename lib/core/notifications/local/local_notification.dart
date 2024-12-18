import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_tide/core/notifications/local/i_local_notification.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  enableLights: true,
  importance: Importance.max,
);

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  debugPrint('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    debugPrint(
      'notification action tapped with input: ${notificationResponse.input}',
    );
  }
}

class LocalNotification implements ILocalNotification {
  LocalNotification({
    FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin,
  }) : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin ??
            FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  Future<void> init() async {
    const androidInitializationSettings =
        AndroidInitializationSettings('app_icon');
    const iosInitializationSettings = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    await requestPermission();
    await createNotificationChannel();
  }

  @override
  Future<void> requestPermission() async {
    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } else {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  @override
  void showLocalNotification({
    required int id,
    String? title,
    String? body,
    Map<String, dynamic>? data,
    RemoteNotification? notification,
  }) {
    late AndroidNotificationDetails androidDetails;
    late DarwinNotificationDetails darwinNotificationDetails;

    darwinNotificationDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      threadIdentifier: 'thread_id',
    );

    androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      icon: notification?.android?.smallIcon,
      color: Colors.blue,
      importance: Importance.max,
      priority: Priority.max,
      sound: channel.sound,
      ticker: 'ticker',
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(
      Duration.zero,
      () {
        _flutterLocalNotificationsPlugin.show(
          id,
          title ?? '',
          body ?? '',
          notificationDetails,
          payload: jsonEncode(data),
        );
      },
    );
  }

  @override
  Future<void> createNotificationChannel() async {
    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    } else {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            sound: true,
          );
    }
  }

  @override
  Future<NotificationAppLaunchDetails?>
      getNotificationAppLaunchDetails() async {
    return _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  }

  @override
  void dispose() {}
}
