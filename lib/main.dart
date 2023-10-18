import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:device_policy_manager/device_policy_manager.dart';
import 'package:screentimelimiter/kiosk.dart';
import 'package:screentimelimiter/timer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: TimerUI(),
    ),
  );
}
