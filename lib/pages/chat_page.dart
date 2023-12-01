import 'package:chat/global/di.dart';
import 'package:chat/models/user.dart';
import 'package:chat/services/chat_services.dart';
import 'package:chat/widgets/chat_button_navigation_bar.dart';
import 'package:chat/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.user});
  final User user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  User get user => widget.user;

  @override
  void initState() {
    context.read<ChatService>()
      ..user = user
      ..vsync = this;
    super.initState();
    context.read<ChatService>().fetchMessages();
    context.read<ChatService>().onReceivedMessage();
  }

  @override
  dispose() {
    context.read<ChatService>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _appBar,
      body: Stack(
        children: [
          RefreshIndicator.adaptive(
            onRefresh: onRefresh,
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.fromLTRB(
                  12, 12, 12, kBottomNavigationBarHeight + 14),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: context.watch<ChatService>().messages.length,
              itemBuilder: buildMessageItem,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ChatButtonNavigationBar(
              onSend: context.read<ChatService>().onSend,
            ),
          ),
        ],
      ),
    );
  }

  AppBar get _appBar => AppBar(
        elevation: 1,
        title: Row(
          children: [
            CircleAvatar(child: Text(user.initials)),
            const SizedBox(width: 8),
            Expanded(child: Text(user.name)),
          ],
        ),
      );

  Widget? buildMessageItem(BuildContext context, int index) =>
      MessageItem(message: context.read<ChatService>().messages[index]);

  // load messages from server
  Future<void> onRefresh() async {
    await context.read<ChatService>().fetchMessages(hasRefresh: true);
  }
}
