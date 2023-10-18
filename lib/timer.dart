import 'dart:developer';

import 'package:device_policy_manager/device_policy_manager.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:screentimelimiter/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  final timer_controller = TextEditingController();
  final config = Config();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FocusDetector(
        onFocusLost: () {
          takeAction();
        },
        onFocusGained: () {
          takeAction();
        },
        onVisibilityLost: () {
          takeAction();
        },
        onVisibilityGained: () {
          takeAction();
        },
        onForegroundLost: () {
          takeAction();
        },
        onForegroundGained: () {
          takeAction();
        },
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    child: TextField(
                      controller: timer_controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "Minutes"),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await DevicePolicyManager.requestPermession(
                          "Your app is requesting the Adminstration permission");
                    },
                    child: const Text("Enable administrative"),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () async {
                      await DevicePolicyManager.removeActiveAdmin();
                    },
                    child: const Text("Disable administrative"),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () async {
                      final res =
                          await DevicePolicyManager.isPermissionGranted();
                    },
                    child: const Text("Check permission"),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton.icon(
                    onPressed: () async {
                      _setStartTime(DateTime.now(), 1);
                      takeAction();
                      //await DevicePolicyManager.lockNow();
                    },
                    icon: const Icon(Icons.lock),
                    label: const Text("Lock Screen"),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () async {
                      final res = await DevicePolicyManager.isCameraDisabled();
                      log("Is camera disabled: $res");
                    },
                    child: const Text("Check Camera is disabled ?"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _setStartTime(DateTime startTime, int until) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        Config.startTimeStorageLabel, config.formatDate(startTime));
    await prefs.setInt(Config.until, until);
  }

  void takeAction() async {
    final prefs = await SharedPreferences.getInstance();
    String? startTime = prefs.getString(Config.startTimeStorageLabel);
    int? until = prefs.getInt(Config.until);
    if (startTime != null && until != null) {
      var date = DateTime.tryParse(startTime)!;
      if (DateTime.now().compareTo(date.add(Duration(minutes: until))) <= 0) {
        DevicePolicyManager.lockNow();
      }
    }
  }
}
