import 'package:flutter/material.dart';

class ConnectivityStatusIcon extends StatelessWidget {
  const ConnectivityStatusIcon({super.key, required this.isActive});
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: isActive
          ? IconButton(
              onPressed: () {},
              icon: const Icon(Icons.wifi),
              color: Colors.blue,
            )
          : IconButton(
              onPressed: () {},
              icon: const Icon(Icons.wifi_off),
              color: Colors.red,
            ),
    );
  }
}
