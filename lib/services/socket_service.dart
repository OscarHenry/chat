import 'package:chat/global/environments.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

enum ServerStatus {
  online(Icon(Icons.wifi_outlined, color: Colors.blue)),
  offline(Icon(Icons.wifi_off_outlined, color: Colors.grey)),
  connecting(Icon(Icons.wifi_find_outlined, color: Colors.yellow));

  const ServerStatus(this.icon);
  final Widget icon;

  bool get isOnline => this == ServerStatus.online;
  bool get isOffline => this == ServerStatus.offline;
  bool get isConnecting => this == ServerStatus.connecting;
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  io.Socket? _socket;

  ServerStatus get serverStatus => _serverStatus;
  io.Socket? get socket => _socket;

  set serverStatus(ServerStatus status) {
    _serverStatus = status;
    notifyListeners();
  }

  Function get emit => _socket!.emit;

  /// Connects the socket
  void connect() {
    // Dart client
    _socket = io.io(Environments.socketUrl, {
      'transports': ['websocket'],
      'auto-connect': true,
      'forceNew': true,
    });

    _socket!.onConnect((_) {
      debugPrint('connect');
      serverStatus = ServerStatus.online;
    });

    _socket!.onDisconnect((_) {
      debugPrint('disconnect');
      serverStatus = ServerStatus.offline;
    });
  }

  /// Disconnects the socket
  void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
    }
  }
}
