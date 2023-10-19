import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:screentimelimiter/config.dart';
import 'package:screentimelimiter/lockmode.dart';
import 'package:screentimelimiter/timer_screen.dart';

class PickDuration extends StatefulWidget {
  const PickDuration();

  @override
  State<PickDuration> createState() => _PickDurationState();
}

class _PickDurationState extends State<PickDuration> {
  late final Stream<KioskMode> _currentMode = watchKioskMode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _currentMode,
        builder: (context, snapshot) {
          stopKioskMode();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialButton(
                onPressed: () {
                  try {
                    startLockMode();
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: Text("Check channel", style: Config.txtStyle),
              ),
              Container(
                width: 200,
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  style: Config.txtStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {},
                onLongPress: () {
                  try {
                    var t = int.tryParse(_controller.text);
                    if (t != null) {
                      t = min<int>(t, Config.maxTime);
                      startKioskMode().whenComplete(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TimerUI(
                                    initialTime: t!,
                                  )),
                        );
                      });
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: Text("Start", style: Config.txtStyle),
              ),
            ],
          );
        },
      );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
