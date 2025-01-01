import 'package:flutter/material.dart';
import 'package:tpnisalarm/screens/edit_alarm.dart';
import 'package:tpnisalarm/services/alarm_list_service.dart';
import 'package:tpnisalarm/stores/alarm_list/alarm_list.dart';
import 'package:tpnisalarm/stores/observable_alarm/observable_alarm.dart';

class AlarmItemWidget extends StatefulWidget {
  const AlarmItemWidget(
      {super.key,
      required this.alarm,
      required this.alarmService,
      required this.alarms});

  final ObservableAlarm alarm;
  final AlarmListManager alarmService;
  final AlarmList alarms;

  @override
  State<AlarmItemWidget> createState() => _AlarmItemWidgetState();
}

class _AlarmItemWidgetState extends State<AlarmItemWidget> {
  bool enable = true;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditAlarmPage(
                        alarm: widget.alarm,
                        alarmService: widget.alarmService,
                        alarms: widget.alarms,
                      ))).then((_) {
            setState(() {});
          });
        },
        child: SizedBox(
          height: 100,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${widget.alarm.hour.toString().padLeft(2, '0')}:${widget.alarm.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(fontSize: 32),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          if (widget.alarm.name != "นาฬิกาปลุก")
                            Text(
                              widget.alarm.name!,
                              style: TextStyle(fontSize: 12),
                            ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Switch(
                          value: widget.alarm.active!,
                          onChanged: (bool value) => setState(() {
                                widget.alarm.active = !widget.alarm.active!;
                              }))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
