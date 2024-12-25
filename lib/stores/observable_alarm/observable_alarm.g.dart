// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observable_alarm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObservableAlarm _$ObservableAlarmFromJson(Map<String, dynamic> json) =>
    ObservableAlarm(
      id: json['id'],
      name: json['name'],
      hour: json['hour'],
      minute: json['minute'],
      monday: json['monday'],
      tuesday: json['tuesday'],
      wednesday: json['wednesday'],
      thursday: json['thursday'],
      friday: json['friday'],
      saturday: json['saturday'],
      sunday: json['sunday'],
      volume: json['volume'],
      progressiveVolume: json['progressiveVolume'],
      active: json['active'],
    );

Map<String, dynamic> _$ObservableAlarmToJson(ObservableAlarm instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hour': instance.hour,
      'minute': instance.minute,
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
      'sunday': instance.sunday,
      'volume': instance.volume,
      'progressiveVolume': instance.progressiveVolume,
      'active': instance.active,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ObservableAlarm on ObservableAlarmBase, Store {
  late final _$nameAtom =
      Atom(name: 'ObservableAlarmBase.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$hourAtom =
      Atom(name: 'ObservableAlarmBase.hour', context: context);

  @override
  int? get hour {
    _$hourAtom.reportRead();
    return super.hour;
  }

  @override
  set hour(int? value) {
    _$hourAtom.reportWrite(value, super.hour, () {
      super.hour = value;
    });
  }

  late final _$minuteAtom =
      Atom(name: 'ObservableAlarmBase.minute', context: context);

  @override
  int? get minute {
    _$minuteAtom.reportRead();
    return super.minute;
  }

  @override
  set minute(int? value) {
    _$minuteAtom.reportWrite(value, super.minute, () {
      super.minute = value;
    });
  }

  late final _$mondayAtom =
      Atom(name: 'ObservableAlarmBase.monday', context: context);

  @override
  bool? get monday {
    _$mondayAtom.reportRead();
    return super.monday;
  }

  @override
  set monday(bool? value) {
    _$mondayAtom.reportWrite(value, super.monday, () {
      super.monday = value;
    });
  }

  late final _$tuesdayAtom =
      Atom(name: 'ObservableAlarmBase.tuesday', context: context);

  @override
  bool? get tuesday {
    _$tuesdayAtom.reportRead();
    return super.tuesday;
  }

  @override
  set tuesday(bool? value) {
    _$tuesdayAtom.reportWrite(value, super.tuesday, () {
      super.tuesday = value;
    });
  }

  late final _$wednesdayAtom =
      Atom(name: 'ObservableAlarmBase.wednesday', context: context);

  @override
  bool? get wednesday {
    _$wednesdayAtom.reportRead();
    return super.wednesday;
  }

  @override
  set wednesday(bool? value) {
    _$wednesdayAtom.reportWrite(value, super.wednesday, () {
      super.wednesday = value;
    });
  }

  late final _$thursdayAtom =
      Atom(name: 'ObservableAlarmBase.thursday', context: context);

  @override
  bool? get thursday {
    _$thursdayAtom.reportRead();
    return super.thursday;
  }

  @override
  set thursday(bool? value) {
    _$thursdayAtom.reportWrite(value, super.thursday, () {
      super.thursday = value;
    });
  }

  late final _$fridayAtom =
      Atom(name: 'ObservableAlarmBase.friday', context: context);

  @override
  bool? get friday {
    _$fridayAtom.reportRead();
    return super.friday;
  }

  @override
  set friday(bool? value) {
    _$fridayAtom.reportWrite(value, super.friday, () {
      super.friday = value;
    });
  }

  late final _$saturdayAtom =
      Atom(name: 'ObservableAlarmBase.saturday', context: context);

  @override
  bool? get saturday {
    _$saturdayAtom.reportRead();
    return super.saturday;
  }

  @override
  set saturday(bool? value) {
    _$saturdayAtom.reportWrite(value, super.saturday, () {
      super.saturday = value;
    });
  }

  late final _$sundayAtom =
      Atom(name: 'ObservableAlarmBase.sunday', context: context);

  @override
  bool? get sunday {
    _$sundayAtom.reportRead();
    return super.sunday;
  }

  @override
  set sunday(bool? value) {
    _$sundayAtom.reportWrite(value, super.sunday, () {
      super.sunday = value;
    });
  }

  late final _$volumeAtom =
      Atom(name: 'ObservableAlarmBase.volume', context: context);

  @override
  double? get volume {
    _$volumeAtom.reportRead();
    return super.volume;
  }

  @override
  set volume(double? value) {
    _$volumeAtom.reportWrite(value, super.volume, () {
      super.volume = value;
    });
  }

  late final _$progressiveVolumeAtom =
      Atom(name: 'ObservableAlarmBase.progressiveVolume', context: context);

  @override
  bool? get progressiveVolume {
    _$progressiveVolumeAtom.reportRead();
    return super.progressiveVolume;
  }

  @override
  set progressiveVolume(bool? value) {
    _$progressiveVolumeAtom.reportWrite(value, super.progressiveVolume, () {
      super.progressiveVolume = value;
    });
  }

  late final _$activeAtom =
      Atom(name: 'ObservableAlarmBase.active', context: context);

  @override
  bool? get active {
    _$activeAtom.reportRead();
    return super.active;
  }

  @override
  set active(bool? value) {
    _$activeAtom.reportWrite(value, super.active, () {
      super.active = value;
    });
  }

  @override
  String toString() {
    return '''
name: ${name},
hour: ${hour},
minute: ${minute},
monday: ${monday},
tuesday: ${tuesday},
wednesday: ${wednesday},
thursday: ${thursday},
friday: ${friday},
saturday: ${saturday},
sunday: ${sunday},
volume: ${volume},
progressiveVolume: ${progressiveVolume},
active: ${active}
    ''';
  }
}
