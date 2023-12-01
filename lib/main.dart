import 'package:chat/global/di.dart';
import 'package:chat/global/extensions.dart';
import 'package:chat/router/router.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
            create: (_) => getIt<AuthService>()),
        ChangeNotifierProvider<SocketService>(
            create: (_) => getIt<SocketService>()),
      ],
      builder: (context, _) => MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData.light(
          useMaterial3: true,
        ).copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ).copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        routerConfig: AppRouter.routerConfig,
        builder: (context, child) => GestureDetector(
          onTap: () => context.unFocus(),
          child: child,
        ),
      ),
    );
  }
}
