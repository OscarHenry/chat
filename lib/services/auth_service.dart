import 'dart:developer';

import 'package:chat/global/di.dart';
import 'package:chat/models/session.dart';
import 'package:chat/models/user.dart';
import 'package:chat/repositories/authentication_repository.dart';
import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final AuthenticationRepository _authRepo = AuthenticationRepository();
  final SocketService socketService = getIt<SocketService>();
  late Session session = Session();
  User? get currentUser => session.user;

  // Log-in
  Future<Session?> logIn({
    required String email,
    required String password,
  }) async {
    final (user, token, exception) =
        await _authRepo.login(email: email, password: password);

    if (exception != null) {
      return null;
    }

    session = Session(token: token, user: user);
    await session.save();
    notifyListeners();
    return session;
  }

  // Sign-in
  Future<Session?> signIn({
    required String name,
    required String email,
    required String password,
  }) async {
    final (user, token, exception) =
        await _authRepo.signIn(name: name, email: email, password: password);

    if (exception != null) {
      return null;
    }

    session = Session(token: token, user: user);
    await session.save();
    notifyListeners();
    return session;
  }

  // Log-out
  Future<void> logOut() async {
    await session.remove(all: false);
    socketService.disconnect();
    notifyListeners();
  }

// Check session
  Future<void> checkSession() async {
    try {
      session = await Session.fromStorage();
      log('Session is active => ${session.isActive} [$session]');
      if (session.isActive) {
        final (user, token, exception) = await _authRepo.renewToken();
        if (exception != null) throw exception;
        session = Session(token: token, user: user);
        await session.save();
        socketService.connect();
        notifyListeners();
      } else {
        logOut();
      }
    } catch (e, s) {
      log('Error checking session',
          name: 'AuthService', error: e, stackTrace: s);
      logOut();
    }
  }

  @override
  void dispose() {
    getIt.resetLazySingleton<AuthService>(instance: this);
    super.dispose();
  }
}
