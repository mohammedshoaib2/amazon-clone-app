import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool? obscureText;
  final int maxLines;
  // final Function? validator;

  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.controller,
    this.obscureText,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return "Enter your $hint";
        }

        return null;
      },
    );
  }
}
