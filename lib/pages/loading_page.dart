import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: context.read<AuthService>().checkSession(),
        builder: (context, snapshot) {
          return Center(
            child: Text('LoadingPage'),
          );
        },
      ),
    );
  }
}
