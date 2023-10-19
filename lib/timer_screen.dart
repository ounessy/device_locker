import 'dart:async';
import 'package:flutter/material.dart';
import 'package:screentimelimiter/config.dart';

class TimerUI extends StatefulWidget {
  final int initialTime;
  const TimerUI({required this.initialTime});

  @override
  State<TimerUI> createState() => _TimerUIState();
}

class _TimerUIState extends State<TimerUI> {
  late ValueNotifier<int> timeLeft;

  @override
  void initState() {
    super.initState();
    timeLeft = ValueNotifier<int>(widget.initialTime);
    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer.cancel();
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Center(
            child: ValueListenableBuilder<int>(
                valueListenable: timeLeft,
                builder: (context, value, _) {
                  return Text(value.toString(), style: Config.txtStyle);
                }),
          ),
        ),
      );
}
