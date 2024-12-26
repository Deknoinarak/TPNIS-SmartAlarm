import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tpnisalarm/stores/observable_alarm/observable_alarm.dart';
import 'package:tpnisalarm/stores/alarm_status/alarm_status.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class RingScreen extends StatelessWidget {
  const RingScreen({super.key, required this.alarm});

  final ObservableAlarm? alarm;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final format = DateFormat('Hm');
    final snoozeTimes = [5, 10, 15, 20];

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                await dismissCurrentAlarm();
              },
              child: SizedBox(
                height: 115,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      'หยุด',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              alarm!.name ?? "",
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              format.format(now),
              style: TextStyle(fontSize: 64.0, height: 1.1),
            ),
            SizedBox(height: 24),
            TextButton(
              onPressed: () async {
                // await dismissCurrentAlarm();
              },
              child: Container(
                height: 115,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.teal.shade400,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'เลื่อนปลุก',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          height: 1.2),
                    ),
                    Text(
                      '${snoozeTimes.first} นาที',
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> dismissCurrentAlarm() async {
    // mediaHandler.stopMusic();
    WakelockPlus.disable();

    AlarmStatus().isAlarm = false;
    // AlarmStatus().alarmId = -1;
    SystemNavigator.pop();

    debugPrint("Dismissed!");
  }
}
