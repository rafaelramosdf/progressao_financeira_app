import 'package:flutter/material.dart';

class DateSelectWidget {
  static Future<DateTime> selectDate(BuildContext context) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2090),
      locale: Locale('pt', 'BR'),
    );
    return date;
  }
}
