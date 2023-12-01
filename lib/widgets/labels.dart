import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Labels extends StatelessWidget {
  const Labels({super.key, required this.path});
  final String path;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const Text(
            'No tienes cuenta?',
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
          Visibility(
            visible: path == '/',
            replacement: buildBtn(
                context: context, path: path, title: 'Crea una ahora!'),
            child: buildBtn(
                context: context, path: path, title: 'Ya tengo una cuenta'),
          ),
          const Spacer(),
          const Text(
            'Terminos y condiciones',
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
        ],
      ),
    );
  }

  TextButton buildBtn({
    required BuildContext context,
    required String path,
    required String title,
  }) {
    return TextButton(
      onPressed: () => context.go(path),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
