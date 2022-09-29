import 'package:flutter/material.dart';

// for displaying SnackBars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

//to hide Keyboard
void hideKeyboard() {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
}
