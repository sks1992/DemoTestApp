import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.isObscure = false,
    required this.hintText,
    required this.textInputType,
    required this.icon,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isObscure;
  final String hintText;
  final TextInputType textInputType;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
      borderRadius: BorderRadius.circular(50),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelStyle: const TextStyle(fontWeight: FontWeight.w400),
            hintText: hintText,
            prefixIcon:  Padding(
              padding:const EdgeInsets.all(8.0),
              child: Icon(icon),
            ),
            border: inputBorder,
            focusedBorder: inputBorder,
            enabledBorder: inputBorder,
            filled: true,
            contentPadding: const EdgeInsets.all(8.00),
          ),
          keyboardType: textInputType,
          obscureText: isObscure),
    );
  }
}
