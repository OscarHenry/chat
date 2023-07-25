import 'package:chat/models/message.dart';
import 'package:chat/models/user.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.message});
  final Message message;

  bool get isMyMessage => message.userSender == oscarUser;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return FadeTransition(
      opacity: message.animCtr,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: message.animCtr, curve: Curves.decelerate),
        child: Container(
          margin: EdgeInsets.fromLTRB(
            isMyMessage ? 8 : 150,
            8,
            isMyMessage ? 150 : 8,
            8,
          ),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isMyMessage ? Colors.blueGrey[50] : Colors.blue[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message.content,
                style: textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 4),
              Text(
                format(message.time),
                style: textTheme.bodySmall?.apply(color: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
