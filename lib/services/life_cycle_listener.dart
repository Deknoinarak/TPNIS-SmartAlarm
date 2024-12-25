import 'package:flutter/material.dart';
import 'package:tpnisalarm/services/alarm_polling_worker.dart';
import 'package:tpnisalarm/services/json_file_service.dart';
import 'package:tpnisalarm/stores/alarm_list/alarm_list.dart';

class LifeCycleListener extends WidgetsBindingObserver {
  final AlarmList alarms;

  LifeCycleListener(this.alarms);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        saveAlarms();
        break;
      case AppLifecycleState.resumed:
        createAlarmPollingIsolate();
        break;
      default:
        debugPrint("Updated lifecycle state: $state");
    }
  }

  void saveAlarms() {
    JsonFileService().writeList(alarms.alarms);
  }

  void createAlarmPollingIsolate() {
    debugPrint('Creating a new worker to check for alarm files!');
    AlarmPollingWorker().createPollingWorker();
  }
}
