import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tpnisalarm/home.dart';
import 'package:tpnisalarm/services/json_file_service.dart';
import 'package:tpnisalarm/stores/alarm_list/alarm_list.dart';
import 'package:tpnisalarm/utils/schedule_notifications.dart';

AlarmList list = AlarmList();
NotificationAppLaunchDetails? notificationAppLaunchDetails;
ScheduleNotifications notifications = ScheduleNotifications(
    'clockee_notification',
    'Clockee Alarm Notication',
    'Alerts on scheduled alarm events',
    appIcon: 'notification_logo');

Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  final alarms = await JsonFileService().readList();
  list.setAlarms(alarms);

  await AndroidAlarmManager.initialize();

  FlutterForegroundTask.initCommunicationPort();

  runApp(const MyApp());
}

void restartApp() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WakeNa',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          fontFamily: 'Line Seed Sans TH'),
      home: HomePage(alarms: list),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [const Locale('th')],
    );
  }
}
