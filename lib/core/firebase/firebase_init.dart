import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:task_tide/core/firebase/firebase.dart';

class FirebaseInit {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: OurFirebaseOptions.currentPlatform(),
    );
    PlatformDispatcher.instance.onError = (e, s) {
      return true;
    };
  }
}
