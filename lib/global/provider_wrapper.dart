import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWrapper<T extends ChangeNotifier> extends StatelessWidget {
  const ProviderWrapper({
    super.key,
    required this.child,
    required this.provider,
  });
  final Widget child;
  final T provider;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => provider,
      lazy: false,
      builder: (_, __) => child,
    );
  }
}
