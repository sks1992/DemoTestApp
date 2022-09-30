import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

const collectionName = "employeeData";

DateFormat _dateFormatMN = DateFormat('dd/MM/yyyy');

String getFormattedDate(String date) {
  if (date.isEmpty) {
    return "-";
  }
  return _dateFormatMN.format(DateTime.parse(date));
}