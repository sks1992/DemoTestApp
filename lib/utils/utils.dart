import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

Size getScreenSize() {
  return MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size;
}

// for displaying SnackBars
showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.orange,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      content: SizedBox(
        width: getScreenSize().width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
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

String getUid() {
  return (100000 + Random().nextInt(10000)).toString();
}