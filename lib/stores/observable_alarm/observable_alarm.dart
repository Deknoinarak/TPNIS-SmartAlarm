import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'observable_alarm.g.dart';

@JsonSerializable()
class ObservableAlarm extends ObservableAlarmBase with _$ObservableAlarm {
  ObservableAlarm(
      {id,
      name,
      hour,
      minute,
      monday,
      tuesday,
      wednesday,
      thursday,
      friday,
      saturday,
      sunday,
      volume,
      progressiveVolume,
      active})
      : super(
            id: id,
            name: name,
            hour: hour,
            minute: minute,
            monday: monday,
            tuesday: tuesday,
            wednesday: wednesday,
            thursday: thursday,
            friday: friday,
            saturday: saturday,
            sunday: sunday,
            volume: volume,
            progressiveVolume: progressiveVolume,
            active: active);

  ObservableAlarm.dayList(
      id, name, hour, minute, volume, progressiveVolume, active, weekdays)
      : super(
          id: id,
          name: name,
          hour: hour,
          minute: minute,
          volume: volume,
          progressiveVolume: progressiveVolume,
          active: active,
          monday: weekdays[0],
          tuesday: weekdays[1],
          wednesday: weekdays[2],
          thursday: weekdays[3],
          friday: weekdays[4],
          saturday: weekdays[5],
          sunday: weekdays[6],
        );

  factory ObservableAlarm.fromJson(Map<String, dynamic> json) =>
      _$ObservableAlarmFromJson(json);

  Map<String, dynamic> toJson() => _$ObservableAlarmToJson(this);
}

abstract class ObservableAlarmBase with Store {
  int? id = -1;

  @observable
  String? name;

  @observable
  int? hour = 0;

  @observable
  int? minute = 0;

  @observable
  bool? monday = false;

  @observable
  bool? tuesday = false;

  @observable
  bool? wednesday = false;

  @observable
  bool? thursday = false;

  @observable
  bool? friday = false;

  @observable
  bool? saturday = false;

  @observable
  bool? sunday = false;

  @observable
  double? volume = 0;

  @observable
  bool? progressiveVolume = false;

  @observable
  bool? active = false;

  @observable
  ObservableAlarmBase({
    this.id,
    this.name,
    this.hour,
    this.minute,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
    this.volume,
    this.progressiveVolume,
    this.active,
  });

  List<bool> get days {
    return [
      monday!,
      tuesday!,
      wednesday!,
      thursday!,
      friday!,
      saturday!,
      sunday!
    ];
  }

  // Good enough for debugging for now
  toString() {
    return "active: $active";
  }
}
