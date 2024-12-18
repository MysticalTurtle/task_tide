import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseOptionsData {
  const FirebaseOptionsData({
    required this.appId,
    required this.apiKey,
    required this.projectId,
    required this.messagingSenderId,
    required this.storageBucket,
    this.iosBundleId,
  });

  final String appId;
  final String apiKey;
  final String projectId;
  final String messagingSenderId;
  final String storageBucket;
  final String? iosBundleId;
}

enum EnviromentEnum { development, staging, production }

class OurFirebaseOptions {
  OurFirebaseOptions();
  static FirebaseOptionsData _getFirebaseOptionsData() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return const FirebaseOptionsData(
        apiKey: 'AIzaSyDaRe7DoyFQLhW-1BEYz2HCdpKyBomM0Jo',
        appId: '1:185067285211:ios:cb7dd808e373e70cc83afe',
        messagingSenderId: '185067285211',
        projectId: 'task-tide-65b8b',
        storageBucket: 'task-tide-65b8b.firebasestorage.app',
        iosBundleId: 'com.edsonsalvador.tasktide.task-tide',
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return const FirebaseOptionsData(
        apiKey: 'AIzaSyAhfvHXQmdu_9vMvfEfaAO-IcdcMPWIoQM',
        appId: '1:185067285211:android:cf17858271d8821cc83afe',
        messagingSenderId: '185067285211',
        projectId: 'task-tide-65b8b',
        storageBucket: 'task-tide-65b8b.firebasestorage.app',
      );
    } else {
      throw UnsupportedError(
        'DefaultFirebaseOptions are not supported for this platform.',
      );
    }
  }

  static FirebaseOptions currentPlatform() {
    return FirebaseOptions(
      appId: _getFirebaseOptionsData().appId,
      apiKey: _getFirebaseOptionsData().apiKey,
      projectId: _getFirebaseOptionsData().projectId,
      messagingSenderId: _getFirebaseOptionsData().messagingSenderId,
      storageBucket: _getFirebaseOptionsData().storageBucket,
      iosBundleId: _getFirebaseOptionsData().iosBundleId,
    );
  }
}
