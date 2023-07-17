import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(top: 48.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/tag-logo.png', fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
