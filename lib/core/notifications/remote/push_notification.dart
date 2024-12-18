import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tide/core/notifications/local/i_local_notification.dart';
import 'package:task_tide/core/notifications/remote/i_push_notification.dart';
import 'package:task_tide/core/storage/keys.dart';

typedef HandleDeepLink = void Function(RemoteMessage rm);

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp();
}

class PushNotification implements IPushNotification {
  PushNotification({
    required ILocalNotification localNotification,
    required SharedPreferences prefs,
    FirebaseMessaging? messaging,
  })  : _messaging = messaging ?? FirebaseMessaging.instance,
        _localNotification = localNotification,
        _prefs = prefs;

  final SharedPreferences _prefs;
  final FirebaseMessaging _messaging;
  final ILocalNotification _localNotification;

  @override
  Future<void> init() async {
    await requestPermision();
    await _messaging.setAutoInitEnabled(true);
    await _foregroundNotification();
    _onRefreshToken();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessage);
    await getFCMToken();
    await setupInteractMessage();
  }

  @override
  Future<void> getFCMToken() async {
    String? fcmToken;
    final settings = await _messaging.getNotificationSettings();

    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      var apnsToken = await _messaging.getAPNSToken();
      await Future<dynamic>.delayed(const Duration(milliseconds: 20));
      apnsToken ??= await _messaging.getAPNSToken();

      if (apnsToken != null) {
        if (kDebugMode) {
          fcmToken = await _messaging.getAPNSToken() ?? '';

        } else {
          fcmToken = await _messaging.getToken() ?? '';
        }
        await _setFCMToken(fcmToken);
      }
      return;
    }

    fcmToken = await _messaging.getToken();
    debugPrint('FCM Token: $fcmToken');
    if (fcmToken != null) {
      await _setFCMToken(fcmToken);
    }
  }

  void _onRefreshToken() {
    _messaging.onTokenRefresh.listen((token) async {
      final currentToken = _getFCMToken();
      if (currentToken != token) {
        await _setFCMToken(token);
      }
    });
  }

  @override
  Future<bool> requestPermision() async {
    final settings = await _messaging.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return true;
    }

    return _requestNotificationPermissions();
  }

  Future<bool> _requestNotificationPermissions() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<void> _foregroundNotification() async {
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _onMessage(RemoteMessage message) async {
    final android = message.notification?.android;
    final apple = message.notification?.apple;

    if (apple != null) {
      await _foregroundNotification();
    }
    if (android != null) {
      final data = message.data;
      final title = message.notification?.title ?? '';
      final body = message.notification?.body ?? '';
      final channelId = Random().nextInt(100) + 50;

      _localNotification.showLocalNotification(
        id: channelId,
        title: title,
        body: body,
        data: data,
        notification: message.notification,
      );
    }
  }

  @override
  Future<void> setupInteractMessage() async {}

  Future<void> _setFCMToken(String fcmToken) async {
    await _prefs.setString(KeyStorage.fcmToken, fcmToken);
  }

  String _getFCMToken() {
    return _prefs.getString(KeyStorage.fcmToken) ?? '';
  }
}
