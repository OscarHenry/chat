import 'package:chat/models/user.dart';
import 'package:flutter/animation.dart';

class Message {
  final User userSender;
  final String content;
  final DateTime time;
  final AnimationController animCtr;

  const Message({
    required this.userSender,
    required this.content,
    required this.time,
    required this.animCtr,
  });
}
