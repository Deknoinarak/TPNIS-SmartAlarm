import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tpnisalarm/stores/observable_alarm/observable_alarm.dart';

class RingScreen extends StatelessWidget {
  const RingScreen({super.key, required this.alarm});

  final ObservableAlarm? alarm;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final format = DateFormat('Hm');
    final snoozeTimes = [5, 10, 15, 20];

    return Scaffold(
      body: Container(
        child: Column(
          children: [Text(format.toString())],
        ),
      ),
    );
  }
}
