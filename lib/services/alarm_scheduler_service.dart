import 'dart:async';
import 'dart:io';

// import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tpnisalarm/services/json_file_service.dart';
import 'package:tpnisalarm/stores/observable_alarm/observable_alarm.dart';

import 'package:flutter/material.dart';

import '../main.dart';

class AlarmScheduler {
  clearAlarm(ObservableAlarm alarm) {
    debugPrint("clearAlarm: ${alarm.id}");
    for (var i = 0; i < 7; i++) {
      AndroidAlarmManager.cancel(alarm.id! * 7 + i);
    }
  }

  /*
    To wake up the device and run something on top of the lockscreen,
    this currently requires the hack from here to be implemented:
    https://github.com/flutter/flutter/issues/30555#issuecomment-501597824
  */
  Future<void> scheduleAlarm(ObservableAlarm alarm) async {
    final days = alarm.days;

    final scheduleId = alarm.id! * 7;
    debugPrint("scheduleId: $scheduleId");
    debugPrint("days.length: ${days.length}");
    bool repeatAlarm = false;
    for (var i = 0; i < days.length; i++) {
      await AndroidAlarmManager.cancel(scheduleId + i);
      debugPrint("alarm.active: ${alarm.active}");
      debugPrint("days[$i]: ${days[i]}");
      if (alarm.active! && days[i]) {
        // Repeat alarm
        debugPrint("Alarm active for day $i");
        repeatAlarm = true;
        final targetDateTime = nextWeekday(i + 1, alarm.hour!, alarm.minute!);
        await newShot(targetDateTime, scheduleId + i);
      } else if (alarm.active! && !repeatAlarm && i == days.length - 1) {
        // One time alarm
        var checkedDay = DateTime.now();
        var targetDateTime = DateTime(checkedDay.year, checkedDay.month,
            checkedDay.day, alarm.hour!, alarm.minute!);

        if (targetDateTime.millisecondsSinceEpoch <
            checkedDay.millisecondsSinceEpoch) {
          // Time past?
          targetDateTime =
              targetDateTime.add(Duration(days: 1)); // Prepare for next day
        }

        debugPrint("targetDateTime ${targetDateTime.toString()}");
        await newShot(targetDateTime, scheduleId + i);
      }
    }
  }

  DateTime nextWeekday(int weekday, alarmHour, alarmMinute) {
    var checkedDay = DateTime.now();

    if (checkedDay.weekday == weekday) {
      final todayAlarm = DateTime(checkedDay.year, checkedDay.month,
          checkedDay.day, alarmHour, alarmMinute);

      if (checkedDay.isBefore(todayAlarm)) {
        return todayAlarm;
      }
      return todayAlarm.add(Duration(days: 7));
    }

    while (checkedDay.weekday != weekday) {
      checkedDay = checkedDay.add(Duration(days: 1));
    }

    return DateTime(checkedDay.year, checkedDay.month, checkedDay.day,
        alarmHour, alarmMinute);
  }

  static void callback(int id) async {
    final alarmId = callbackToAlarmId(id);

    createAlarmFlag(alarmId);
  }

  /// Because each alarm might need to be able to schedule up to 7 android alarms (for each weekday)
  /// a means is required to convert from the actual callback ID to the ID of the alarm saved
  /// in internal storage. To do so, we can assign a range of 7 per alarm and use ceil to get to
  /// get the alarm ID to access the list of songs that could be played
  static int callbackToAlarmId(int callbackId) {
    return (callbackId / 7).floor();
  }

  /// Creates a flag file that the main isolate can find on life cycle change
  /// For now just abusing the FileProxy class for testing
  static void createAlarmFlag(int id) async {
    debugPrint('Creating a new alarm flag for ID $id');
    final dir = await getApplicationDocumentsDirectory();
    JsonFileService.toFile(File("${dir.path}/$id.alarm")).writeList([]);

    final alarms = await JsonFileService().readList();
    var alarm = alarms.firstWhere((element) => element.id == id);

    if (alarm.active! && Platform.isAndroid) {
      restartApp();
      FlutterForegroundTask.launchApp();
      debugPrint('Launched App');

      // await notifications.init(
      //     onSelectNotification:
      //         (NotificationResponse? notificationResponse) async {
      //       // if (payload == null || payload.trim().isEmpty) return null;
      //       final String? payload = notificationResponse!.payload;
      //       debugPrint('  payload $payload');

      //       // if (notificationResponse.payload != null) {
      //       //   debugPrint('notification payload: $payload');
      //       // }
      //       // await Navigator.push(
      //       //   context,
      //       //   MaterialPageRoute<void>(
      //       //       builder: (context) => SecondScreen(payload)),
      //       // );
      //       throw Exception('New Notification');

      //       // return;
      //     },
      //     onDidReceiveBackgroundNotificationResponse:
      //         notificationTapBackground);

      // await notifications.getNotificationAppLaunchDetails().then((details) {
      //   notificationAppLaunchDetails = details;
      // });

      // await notifications.show(
      //   id: id,
      //   icon: 'app_icon',
      //   importance: Importance.max,
      //   priority: Priority.high,
      //   ticker: 'ticker',
      //   title: alarm.name,
      //   // '$hours:$minutes'
      //   body: "กดเพื่อหยุด",
      //   sound: RawResourceAndroidNotificationSound(''),
      //   payload: id.toString(),
      // );

      return;
    }
  }

  Future<void> newShot(DateTime targetDateTime, int id) async {
    await AndroidAlarmManager.oneShotAt(targetDateTime, id, callback,
        alarmClock: true, rescheduleOnReboot: true);
  }
}
