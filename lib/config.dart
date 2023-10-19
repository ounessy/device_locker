import 'package:flutter/material.dart';

class Config {
  static const startTimeStorageLabel = "start_time";
  static const until = "until";
  static const txtStyle = TextStyle(fontSize: 70);
  static const maxTime = 3600;

  String formatDate(DateTime date) {
    return date.toString();
  }
}
