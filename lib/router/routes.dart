import 'package:chat/pages/pages.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> appRoutes = {
  "login": (_) => const LoginPage(),
  "chat": (_) => const ChatPage(),
  "loading": (_) => const LoadingPage(),
  "register": (_) => const RegisterPage(),
  "user": (_) => const UserPage(),
};
