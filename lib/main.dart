import 'package:chat/global/di.dart';
import 'package:chat/pages/pages.dart';
import 'package:chat/router/routes.dart';
import 'package:chat/services/auth_service.dart';
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
      ],
      builder: (context, _) => MaterialApp(
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
        routes: appRoutes,
        initialRoute:
            context.read<AuthService>().session.isActive ? 'user' : 'login',
        builder: (context, child) => GestureDetector(
          onTap: () => Focus.of(context).unfocus(),
          child: child,
        ),
      ),
    );
  }
}
