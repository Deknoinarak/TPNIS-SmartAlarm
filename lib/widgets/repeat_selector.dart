import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tpnisalarm/stores/observable_alarm/observable_alarm.dart';

class RepeatSelectorWidget extends StatelessWidget {
  const RepeatSelectorWidget({super.key, this.alarm});

  final ObservableAlarm? alarm;

  // List of items in our dropdown menu
  static final items = [
    'ครั้งเดียว',
    'ทุกอาทิตย์',
  ];

  bool isOnce() {
    if (alarm!.monday == false &&
        alarm!.tuesday == false &&
        alarm!.wednesday == false &&
        alarm!.thursday == false &&
        alarm!.friday == false &&
        alarm!.saturday == false &&
        alarm!.sunday == false) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (context) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.repeat),
                    SizedBox(width: 10),
                    DropdownButton(
                        value: isOnce() ? 'ครั้งเดียว' : 'ทุกอาทิตย์',
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? value) => {
                              if (value == 'ครั้งเดียว')
                                {
                                  alarm!.monday = false,
                                  alarm!.tuesday = false,
                                  alarm!.wednesday = false,
                                  alarm!.thursday = false,
                                  alarm!.friday = false,
                                  alarm!.saturday = false,
                                  alarm!.sunday = false,
                                }
                              else if (value == 'ทุกอาทิตย์')
                                {
                                  alarm!.monday = true,
                                  alarm!.tuesday = true,
                                  alarm!.wednesday = true,
                                  alarm!.thursday = true,
                                  alarm!.friday = true,
                                  alarm!.saturday = false,
                                  alarm!.sunday = false,
                                }
                            }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DayToggle(
                      text: 'จ.',
                      current: alarm!.monday!,
                      onToggle: (monday) => alarm!.monday = monday,
                    ),
                    DayToggle(
                      text: 'อ.',
                      current: alarm!.tuesday!,
                      onToggle: (tuesday) => alarm!.tuesday = tuesday,
                    ),
                    DayToggle(
                      text: 'พ.',
                      current: alarm!.wednesday!,
                      onToggle: (wednesday) => alarm!.wednesday = wednesday,
                    ),
                    DayToggle(
                      text: 'พฤ.',
                      current: alarm!.thursday!,
                      onToggle: (thursday) => alarm!.thursday = thursday,
                    ),
                    DayToggle(
                      text: 'ศ.',
                      current: alarm!.friday!,
                      onToggle: (friday) => alarm!.friday = friday,
                    ),
                    DayToggle(
                      text: 'ส.',
                      current: alarm!.saturday!,
                      onToggle: (saturday) => alarm!.saturday = saturday,
                    ),
                    DayToggle(
                      text: 'อา.',
                      current: alarm!.sunday!,
                      onToggle: (sunday) => alarm!.sunday = sunday,
                    ),
                  ],
                ),
              ],
            ));
  }
}

class DayToggle extends StatelessWidget {
  const DayToggle(
      {super.key, this.onToggle, this.current = false, this.text = ""});

  final Function? onToggle;
  final bool current;
  final String text;

  @override
  Widget build(BuildContext context) {
    const fontSize = 16.0;
    const size = 20.0;

    return SizedBox.fromSize(
      size: Size.fromRadius(size),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
                color:
                    current ? Colors.lightBlue.withAlpha(30) : Colors.black54,
                width: 1.0,
                style: BorderStyle.solid),
            color:
                current ? Colors.lightBlue.withAlpha(30) : Colors.transparent),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.black54.withAlpha(30),
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
          onTap: () => onToggle!(!current),
          child: Center(
            child: Text(text,
                style: TextStyle(
                  fontSize: fontSize,
                )),
          ),
        ),
      ),
    );
  }
}
