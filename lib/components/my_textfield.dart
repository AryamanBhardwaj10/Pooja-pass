import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool isObscureText;
  final TextEditingController textController;
  const MyTextField(
      {super.key,
      required this.hintText,
      required this.isObscureText,
      required this.textController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Theme.of(context).colorScheme.tertiary,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        )),
        fillColor: Theme.of(context).colorScheme.tertiary,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      obscureText: isObscureText,
    );
  }
}
