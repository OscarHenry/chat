import 'package:chat/models/message.dart';
import 'package:chat/models/user.dart';
import 'package:chat/widgets/chat_button_navigation_bar.dart';
import 'package:chat/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 1,
        title: const Row(
          children: [
            CircleAvatar(
              child: Text('DD'),
            ),
            SizedBox(width: 8),
            Expanded(child: Text('Nombre y Apellidos')),
          ],
        ),
      ),
      body: Stack(
        children: [
          RefreshIndicator.adaptive(
            onRefresh: onRefresh,
            child: ListView.builder(
              reverse: true,
              padding: listViewPadding,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: messages.length,
              itemBuilder: buildMessageItem,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ChatButtonNavigationBar(onSend: onSend),
          ),
        ],
      ),
    );
  }

  Widget? buildMessageItem(context, index) =>
      MessageItem(message: messages[index]);

  // send a message
  void onSend(value) {
    final newMessage = Message(
      userSender: oscarUser,
      content: value,
      time: DateTime.now(),
      animCtr: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );
    messages.insert(0, newMessage);
    newMessage.animCtr.forward();

    setState(() {});
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  EdgeInsets get listViewPadding => EdgeInsets.fromLTRB(12, 12, 12,
      kMinInteractiveDimension + MediaQuery.of(context).viewPadding.bottom);

  @override
  void dispose() {
    // TODO: close Socket service
    // release the resources
    for (var element in messages) {
      element.animCtr.dispose();
    }
    super.dispose();
  }
}
