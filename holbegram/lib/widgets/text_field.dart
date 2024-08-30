import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    required this.controller,
    this.onSubmitted,
    required this.isPassword,
    required this.hintText,
    required this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    required this.filled,
  });

  final TextEditingController controller;
  final void Function(String)? onSubmitted;
  final bool isPassword;
  final String hintText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    const invisibleBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
        style: BorderStyle.none
      ),
    );

    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      onSubmitted: onSubmitted,
      cursorColor: const Color.fromARGB(218, 226, 37, 24),
      decoration: InputDecoration(
        hintText: hintText,
        border: invisibleBorder,
        enabledBorder: invisibleBorder,
        focusedBorder: invisibleBorder,
        // fillColor: const Color.fromARGB(0xFF, 0x80, 0x80, 0x80),
        filled: filled,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon, // maybe null, but it'll just not show any suffixIcon if it is null.
        contentPadding: const EdgeInsets.all(8),
      ),
      textInputAction: TextInputAction.next,
      obscureText: isPassword,
    );
  }
}
