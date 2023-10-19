import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectivityStatusIcon extends StatelessWidget {
  const ConnectivityStatusIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<SocketService, ServerStatus>(
      selector: (context, socketService) => socketService.serverStatus,
      builder: (context, status, child) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: buildIcon(status),
      ),
    );
  }

  /// Builds the icon based on the [ServerStatus]
  IconButton buildIcon(ServerStatus status) => switch (status) {
        ServerStatus.offline => IconButton(
            onPressed: () {},
            icon: const Icon(Icons.wifi_off_outlined),
            color: Colors.grey,
          ),
        ServerStatus.online => IconButton(
            onPressed: () {},
            icon: const Icon(Icons.wifi_outlined),
            color: Colors.blue,
          ),
        ServerStatus.connecting => IconButton(
            onPressed: () {},
            icon: const Icon(Icons.wifi_outlined),
            color: Colors.yellow,
          ),
      };
}
