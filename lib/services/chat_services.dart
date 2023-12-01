import 'package:chat/global/di.dart';
import 'package:chat/models/message.dart';
import 'package:chat/models/user.dart';
import 'package:chat/repositories/message_repository.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';

class ChatService with ChangeNotifier {
  late User user;
  late TickerProvider vsync;

  final SocketService socketService = getIt<SocketService>();
  final User appUser = getIt<AuthService>().currentUser!;

  final MessageRepository _messageRepository = MessageRepository();

  // int _skip = -1;
  // int _pageSize = 15;

  List<Message> messages = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchMessages({bool hasRefresh = false}) async {
    isLoading = true;
    // if (!hasRefresh) {
    //   _skip += 1;
    // }
    final (newMessages, error) = await _messageRepository.fetchMessages(
      userId: user.uid,
      // skip: _skip,
      // pageSize: _pageSize,
    );

    if (error != null) {
      debugPrint('fetchMessages failed');
    }

    if (newMessages != null) {
      for (var element in newMessages) {
        element.animController = AnimationController(
          vsync: vsync,
          duration: const Duration(milliseconds: 400),
        );
        element.animController.forward();
      }

      messages = newMessages;
    }

    isLoading = false;
  }

  // listen event received from server
  void onReceivedMessage() {
    socketService.socket!.on(
      'private-message',
      (data) {
        debugPrint('onReceiveMessage private-message: $data');
        try {
          // parse data and convert to message
          data as Map<String, dynamic>;
          final newMessage = Message.fromJson(data);

          newMessage.animController = AnimationController(
            vsync: vsync,
            duration: const Duration(milliseconds: 400),
          );

          // add message to start of messages list
          messages.insert(0, newMessage);

          // play animation
          newMessage.animController.forward();

          // refresh page
          notifyListeners();
        } catch (e) {
          debugPrint('onReceiveMessage private-message: $e');
        }
      },
    );
  }

  // send a message
  void onSend(String sms) {
    final newMessage = Message(
      from: appUser.uid,
      to: user.uid,
      message: sms,
      createdAt: DateTime.now(),
    );

    newMessage.animController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 400),
    );

    // emit a private-message event to server
    socketService.emit('private-message', newMessage.toJson());

    // insert into local messages list
    messages.insert(0, newMessage);

    // play animation
    newMessage.animController.forward();

    // refresh page
    notifyListeners();
  }

  @override
  void dispose() {
    for (var element in messages) {
      element.animController.reverse();
      element.animController.dispose();
    }
    getIt.resetLazySingleton<ChatService>();
    socketService.socket?.off('private-message');
    super.dispose();
  }
}
