import 'package:flutter/material.dart';
import 'package:screentimelimiter/pick_duration.dart';

class MainActivity extends StatelessWidget {
  const MainActivity({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: const Center(child: PickDuration()),
        ),
      );
}
