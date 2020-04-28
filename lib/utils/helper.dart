import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static String milliSecondsToDate(int timeStamp) {
    var date = DateTime.fromMicrosecondsSinceEpoch(timeStamp);
    var now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    return formattedDate;
  }
}
