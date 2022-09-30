import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReusableDatePicker extends StatelessWidget {
  const ReusableDatePicker(
      {required this.onPressed,
      required this.title,
      required this.dateFormat,
      Key? key})
      : super(key: key);

  final Function() onPressed;
  final String title;
  final DateTime dateFormat;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: width,
          height: 44,
          child: OutlinedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            onPressed: onPressed,
            child: SizedBox(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat("dd/MM/yyyy").format(dateFormat).toString(),
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const Icon(Icons.calendar_month)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
