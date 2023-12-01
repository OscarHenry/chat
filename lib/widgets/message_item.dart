import 'package:chat/global/di.dart';
import 'package:chat/models/message.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.message});
  final Message message;

  bool get isMyMessage => message.from == getIt<AuthService>().currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return FadeTransition(
      opacity: message.animController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: message.animController, curve: Curves.decelerate),
        child: Align(
          alignment: isMyMessage ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            margin: isMyMessage
                ? const EdgeInsets.fromLTRB(8, 8, 150, 8)
                : const EdgeInsets.fromLTRB(150, 8, 8, 8),
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
                  message.message,
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                if (message.createdAt != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    format(message.createdAt!),
                    style: textTheme.bodySmall?.apply(color: Colors.blueGrey),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
