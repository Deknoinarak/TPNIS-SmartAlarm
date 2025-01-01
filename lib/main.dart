import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpnisalarm/home.dart';
import 'package:tpnisalarm/includes/choice_math/choice_math.dart';
import 'package:tpnisalarm/includes/shake/shake.dart';
import 'package:tpnisalarm/includes/typed_math/typed_math.dart';
import 'package:tpnisalarm/screens/ring.dart';
import 'package:tpnisalarm/screens/welcome.dart';
import 'package:tpnisalarm/services/alarm_polling_worker.dart';
import 'package:tpnisalarm/services/json_file_service.dart';
import 'package:tpnisalarm/services/life_cycle_listener.dart';
import 'package:tpnisalarm/services/media_handler.dart';
import 'package:tpnisalarm/stores/alarm_list/alarm_list.dart';
import 'package:tpnisalarm/stores/alarm_status/alarm_status.dart';
import 'package:tpnisalarm/stores/observable_alarm/observable_alarm.dart';
import 'package:tpnisalarm/utils/schedule_notifications.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

MediaHandler mediaHandler = MediaHandler();
AlarmList list = AlarmList();
NotificationAppLaunchDetails? notificationAppLaunchDetails;
ScheduleNotifications notifications = ScheduleNotifications(
    'wakena_notification',
    'WakeNa Alarm Notication',
    'Alerts on scheduled alarm events',
    appIcon: 'app_icon');

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
  debugPrint('notification payload $notificationResponse');
  throw Exception('New Notification');
}

Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  final alarms = await JsonFileService().readList();
  list.setAlarms(alarms);
  WidgetsBinding.instance.addObserver(LifeCycleListener(list));

  await AndroidAlarmManager.initialize();

  AlarmPollingWorker().createPollingWorker();

  FlutterForegroundTask.initCommunicationPort();

  runApp(const MyApp());
}

void restartApp() {
  runApp(MyApp());
}

Future<bool> getIntroStatus() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool introValue = prefs.getBool("intro") ?? false;
  return introValue;
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
      routes: {
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/shake': (context) => const ShakeCaptcha(),
        '/choice_math': (context) => const ChoiceMathCaptcha(),
        '/typed_math': (context) => const TypedMathCaptcha(),
      },
      debugShowCheckedModeBanner: false,
      home: Splash(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [const Locale('th')],
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({
    super.key,
  });

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Entry()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WelcomeScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}

class Entry extends StatelessWidget {
  const Entry({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // return WelcomeScreen();
    return Observer(builder: (context) {
      AlarmStatus status = AlarmStatus();
      debugPrint('status.isAlarm ${status.isAlarm}');
      debugPrint('list.alarms.length ${list.alarms.length}');
      if (status.isAlarm) {
        final id = status.alarmId;
        final alarm = list.alarms.firstWhere((alarm) => alarm.id == id,
            orElse: () => ObservableAlarm());

        mediaHandler.playMusic(alarm);
        WakelockPlus.enable();

        return Material(child: RingScreen(alarm: alarm));
      }
      return HomePage(alarms: list);
    });
  }
}

Future<void> dismissCurrentAlarm() async {
  mediaHandler.stopMusic();
  WakelockPlus.disable();

  AlarmStatus().isAlarm = false;
  AlarmStatus().alarmId = -1;
  SystemNavigator.pop();

  debugPrint("Dismissed!");
}
