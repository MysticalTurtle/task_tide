import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task_tide/core/storage/i_storage.dart';

class AppSecureStorage implements ISecureStorage {
  AppSecureStorage();

  Future<void> init() async {
    _prefs = const FlutterSecureStorage();
  }

  late FlutterSecureStorage _prefs;

  @override
  Future<String?> read({required String key, String? defaultValue}) async {
    try {
      final value = await _prefs.read(key: key);
      return value;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> write({
    required String key,
    required String value,
  }) async {
    try {
      await _prefs.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await _prefs.delete(key: key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _prefs.deleteAll();
    } catch (e) {
      rethrow;
    }
  }
}
