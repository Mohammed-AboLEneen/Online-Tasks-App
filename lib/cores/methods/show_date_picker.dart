import 'package:flutter/material.dart';

Future<DateTime?> showDatePickerMethod(
  BuildContext context,
) async {
  final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xff5FCCA5),
                // Change header background color
                onPrimary: Colors.white,
                // Change header text color
                onSurface: Colors.black, // Change body text color
              ),
            ),
            child: child!);
      },
      lastDate: DateTime(2025));

  if (pickedDate != null) {
    return pickedDate;
  }

  return null;
}
