import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screentimelimiter/main_activity.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(
    MaterialApp(
      home: MainActivity(),
    ),
  );
}
