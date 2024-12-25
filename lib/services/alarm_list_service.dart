import 'package:tpnisalarm/services/json_file_service.dart';
import 'package:tpnisalarm/stores/alarm_list/alarm_list.dart';
import 'package:tpnisalarm/stores/observable_alarm/observable_alarm.dart';

class AlarmListManager {
  final AlarmList _alarms;
  final JsonFileService _storage = JsonFileService();

  AlarmListManager(this._alarms);

  saveAlarm(ObservableAlarm alarm) async {
    final index =
        _alarms.alarms.indexWhere((findAlarm) => alarm.id == findAlarm.id);
    _alarms.alarms[index] = alarm;
    await _storage.writeList(_alarms.alarms);
  }
}
