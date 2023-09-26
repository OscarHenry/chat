import 'package:flutter/material.dart';

enum AsyncButtonType { elevated, outline, text }

class AsyncButton extends StatefulWidget {
  const AsyncButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.type = AsyncButtonType.elevated,
  });
  final Future<void> Function() onPressed;
  final Widget child;
  final AsyncButtonType type;

  @override
  State<AsyncButton> createState() => _AsyncButtonState();
}

class _AsyncButtonState extends State<AsyncButton> {
  late bool isLoading;

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case AsyncButtonType.elevated:
        return ElevatedButton(
          onPressed: isLoading ? null : _onPressed,
          child: widget.child,
        );
      case AsyncButtonType.outline:
        return OutlinedButton(
          onPressed: isLoading ? null : _onPressed,
          child: widget.child,
        );
      case AsyncButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : _onPressed,
          child: widget.child,
        );
    }
  }

  Future<void> _onPressed() async {
    setState(() {
      isLoading = true;
    });
    await widget.onPressed().whenComplete(() => setState(() {
          isLoading = false;
        }));
  }
}
