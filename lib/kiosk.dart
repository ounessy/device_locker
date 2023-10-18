import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kiosk_mode/kiosk_mode.dart';
import 'package:screentimelimiter/config.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class TimerUI extends StatelessWidget {
  const TimerUI({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Block App'),
          ),
          body: const Center(child: _Home()),
        ),
      );
}

class _Home extends StatefulWidget {
  const _Home();

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  late final Stream<KioskMode> _currentMode = watchKioskMode();

  void _showSnackBar(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  void _handleStart(bool didStart) {
    if (!didStart && Platform.isIOS) {
      _showSnackBar(
        'Single App mode is supported only for devices that are supervised'
        ' using Mobile Device Management (MDM) and the app itself must'
        ' be enabled for this mode by MDM.',
      );
    }
  }

  void _handleStop(bool? didStop) {
    if (didStop == false) {
      _showSnackBar(
        'Kiosk mode could not be stopped or was not active to begin with.',
      );
    }
  }

  int timeLeft = 5;
  void _startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
        stopKioskMode().then(_handleStop);
      }
    });
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _currentMode,
        builder: (context, snapshot) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(timeLeft.toString(), style: Config.txtStyle),
              MaterialButton(
                onPressed: () {
                  startKioskMode().then((value) {
                    if (value) {
                      _startTimer();
                    }
                  });
                },
                child: Text("Start", style: Config.txtStyle),
              ),
            ],
          );
        },
      );
}
