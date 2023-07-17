import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
  });

  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextInputAction textInputAction;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autocorrect: false,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
      ),
      textInputAction: textInputAction,
    );
  }
}