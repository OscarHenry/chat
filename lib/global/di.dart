import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<SocketService>(SocketService());
  getIt.registerSingleton<AuthService>(AuthService());
  await getIt<AuthService>().checkSession();
}
