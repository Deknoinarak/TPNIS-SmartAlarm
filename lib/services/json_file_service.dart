import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:tpnisalarm/stores/observable_alarm/observable_alarm.dart';

class JsonFileService {
  File? _file;

  JsonFileService();

  JsonFileService.toFile(this._file);

  Future<void> writeList(List<ObservableAlarm> alarms) async {
    await _ensureFileSet();
    _file?.writeAsString(jsonEncode(alarms));
  }

  Future<List<ObservableAlarm>> readList() async {
    await _ensureFileSet();
    if (_file!.existsSync()) {
      String content = await _file!.readAsString();
      List<dynamic> parsedList = jsonDecode(content) as List;
      return parsedList.map((map) => ObservableAlarm.fromJson(map)).toList();
    }
    return [];
  }

  Future<void> _ensureFileSet() async {
    _file ??= _file = await _getLocalFile();
  }

  Future<File> _getLocalFile() async {
    return _getLocalPath().then((path) => File('$path/alarms.json'));
  }

  Future<String> _getLocalPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
}
