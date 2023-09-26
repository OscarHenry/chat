import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mixin StorageMixin {
  FlutterSecureStorage storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<bool> write({required String key, required String value}) async {
    try {
      await storage.write(key: key, value: value);
      return true;
    } catch (e, s) {
      log('Error writing $key : $value',
          name: 'write', error: e, stackTrace: s);
      return false;
    }
  }

  Future<bool> delete({required String key}) async {
    try {
      await storage.delete(key: key);
      return true;
    } catch (e, s) {
      log('Error deleting $key', name: 'delete', error: e, stackTrace: s);
      return false;
    }
  }
}
