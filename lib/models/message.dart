import 'package:flutter/animation.dart';

class Message {
  final String from;
  final String to;
  final String message;
  final DateTime? createdAt;
  late final AnimationController animController;

  Message({
    required this.from,
    required this.to,
    required this.message,
    this.createdAt,
    AnimationController? controller,
  }) {
    if (controller != null) {
      animController = controller;
    }
  }

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json['from'],
        to: json['to'],
        message: json['message'],
        createdAt: DateTime.tryParse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'from': from,
        'to': to,
        'message': message,
        'createdAt': createdAt?.toIso8601String(),
      };

  @override
  String toString() => 'Message(from: $from, to: $to, message: $message, '
      'createdAt: $createdAt)';
}
