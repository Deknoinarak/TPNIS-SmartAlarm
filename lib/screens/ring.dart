import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tpnisalarm/services/alarm_scheduler_service.dart';
import 'package:tpnisalarm/stores/observable_alarm/observable_alarm.dart';

import '../main.dart';

class RingScreen extends StatelessWidget {
  const RingScreen({super.key, required this.alarm});

  final ObservableAlarm? alarm;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final format = DateFormat('Hm');
    final snoozeTimes = [5, 10, 15, 20];

    debugPrint('alarm $alarm');

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
              style: TextButton.styleFrom(
                minimumSize: Size.zero, // Set this
                padding: EdgeInsets.zero, // and this
              ),
              onPressed: () async {
                if (alarm!.captcha! != "none") {
                  Navigator.pushNamed(context, '/${alarm!.captcha}');
                  debugPrint("${alarm!.captcha}");
                } else {
                  await dismissCurrentAlarm();
                }
              },
              child: SizedBox(
                height: 115,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
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
            SizedBox(height: 32),
            Text(
              alarm!.name ?? "",
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              format.format(now),
              style: TextStyle(fontSize: 64.0, height: 1.1),
            ),
            SizedBox(height: 32),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero, // Set this
                padding: EdgeInsets.zero, // and this
              ),
              onPressed: () async {
                await rescheduleAlarm(snoozeTimes.first);
              },
              child: Container(
                height: 115,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
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
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: snoozeTimes.map((minutes) {
                  return TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero, // Set this
                      padding: EdgeInsets.zero, // and this
                    ),
                    child: SizedBox(
                      child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.teal.shade400,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "+$minutesนาที",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          )),
                    ),
                    onPressed: () async {
                      await rescheduleAlarm(minutes);
                    },
                  );
                }).toList(),
              ),
            )
            // TextButton(
            //   onPressed: () async {
            //     await dismissCurrentAlarm();
            //   },
            //   child: Container(
            //     height: 115,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       color: Colors.red.shade800,
            //     ),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Text(
            //           'Emergency Stop',
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 28.0,
            //               fontWeight: FontWeight.bold,
            //               height: 1.2),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> rescheduleAlarm(int minutes) async {
    // Re-schedule alarm
    var checkedDay = DateTime.now();
    var targetDateTime = DateTime(checkedDay.year, checkedDay.month,
        checkedDay.day, alarm!.hour!, alarm!.minute!);

    await AlarmScheduler()
        .newShot(targetDateTime.add(Duration(minutes: minutes)), alarm!.id!);
    dismissCurrentAlarm();
  }
}
