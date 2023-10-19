import 'package:flutter/material.dart';

extension XBuildContext on BuildContext {
  /// show a snack-bar
  void showSnackBar({Widget? child, String? text}) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: child ?? Text('$text'),
          duration: const Duration(seconds: 2),
        ),
      );

  /// unfocus the current focus
  void unFocus() => Focus.of(this).unfocus();
}
