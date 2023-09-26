import 'dart:convert';

import 'package:chat/global/storage_mixin.dart';
import 'package:chat/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Session with StorageMixin {
  static const _key = 'session';
  String? token;
  User? user;

  Session({
    this.token,
    this.user,
  });

  bool get isActive => token != null && user != null;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        token: json['token'] as String?,
        user: json['user'] == null ? null : User.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {'token': token, 'user': user?.toJson()};

  /// create session from key (Asynchronous)
  ///
  /// Asynchronous factory method
  static Future<Session> fromStorage() async {
    FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
    final session = await storage.read(key: _key);

    if (session != null) {
      return Session.fromJson(jsonDecode(session));
    }

    return Session(token: null, user: null);
  }

  /// save session on secure storage
  ///
  /// return tru if session was saved
  Future<bool> save() async => write(key: _key, value: jsonEncode(toJson()));

  /// remove session from secure storage
  ///
  /// return true if session was removed
  Future<bool> remove({bool all = true}) async {
    if (all) {
      return delete(key: _key);
    } else {
      token = null;
      return write(key: _key, value: jsonEncode(toJson()));
    }
  }

  @override
  String toString() => 'Session(token: $token, user: $user)';
}
