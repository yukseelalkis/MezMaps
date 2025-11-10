import 'package:flutter/material.dart';

///TextField
class CustomTextField extends StatelessWidget {
  const CustomTextField({required this.hintText, required this.controller});
  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: false,
      decoration: InputDecoration(
        labelText: hintText,

        border: OutlineInputBorder(),
      ),
    );
  }
}
