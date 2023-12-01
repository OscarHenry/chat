import 'package:flutter/material.dart';

class ChatButtonNavigationBar extends StatefulWidget {
  const ChatButtonNavigationBar({
    super.key,
    this.onSend,
    this.sendButtonIconData,
  });
  final ValueChanged<String>? onSend;
  final IconData? sendButtonIconData;

  @override
  State<ChatButtonNavigationBar> createState() =>
      _ChatButtonNavigationBarState();
}

class _ChatButtonNavigationBarState extends State<ChatButtonNavigationBar> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    var containerPadding = const EdgeInsets.all(14);
    const containerDecoration = BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.white10],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: [0.8, 1],
      ),
    );
    var inputDecoration = InputDecoration(
      fillColor: Colors.blue[50],
      filled: true,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        borderSide: BorderSide.none,
      ),
      hintText: 'Type your message here...',
      hintStyle: theme.labelMedium?.apply(color: Colors.blueGrey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
    );
    return Container(
      padding: containerPadding,
      decoration: containerDecoration,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: inputDecoration,
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: _controller.text.trim().isNotEmpty ? onButtonSend : null,
            icon: const Icon(Icons.send),
            style: IconButton.styleFrom(
              backgroundColor: Colors.blue[50],
              foregroundColor: Colors.blue,
              disabledBackgroundColor: Colors.grey[100],
              disabledForegroundColor: Colors.grey,
              fixedSize: const Size.fromRadius(24),
            ),
          )
        ],
      ),
    );
  }

  void onButtonSend() {
    widget.onSend?.call(_controller.text);
    _controller.clear();
  }
}
