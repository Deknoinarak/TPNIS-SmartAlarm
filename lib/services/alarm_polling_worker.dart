import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tpnisalarm/stores/alarm_status/alarm_status.dart';

class AlarmPollingWorker {
  static final AlarmPollingWorker _instance = AlarmPollingWorker._();

  factory AlarmPollingWorker() {
    return _instance;
  }

  AlarmPollingWorker._();

  bool running = false;

  void createPollingWorker() {
    if (running) {
      debugPrint('Worker is already running, not creating another one!');
      return;
    }

    running = true;
    poller(60).then((alarmId) {
      running = false;
      if (alarmId != null && AlarmStatus().alarmId == null) {
        AlarmStatus().isAlarm = true;
        AlarmStatus().alarmId = int.parse(alarmId);
        cleanUpAlarmFiles();
      }
    });
  }

  /// Polling function checking for .alarm files in getApplicationDocumentsDirectory()
  /// every 10th of a for #iterations iterations.
  Future<String?> poller(int iterations) async {
    for (int i = 0; i < iterations; i++) {
      final foundFiles = await findFiles();
      if (foundFiles.isNotEmpty) return foundFiles[0];

      await Future.delayed(const Duration(milliseconds: 100));
    }

    return null;
  }

  Future<List<String>> findFiles() async {
    final extension = ".alarm";
    final dir = await getApplicationDocumentsDirectory();
    return dir
        .list()
        .map((entry) => entry.path)
        .where((path) => path.endsWith(extension))
        .map((path) => basename(path))
        .map((path) => path.substring(0, path.length - extension.length))
        .toList();
  }

  void cleanUpAlarmFiles() async {
    debugPrint('Cleaning up generated .alarm files!');
    final dir = await getApplicationDocumentsDirectory();
    dir
        .list()
        .where((entry) => entry.path.endsWith(".alarm"))
        .forEach((entry) => entry.delete());
  }
}
