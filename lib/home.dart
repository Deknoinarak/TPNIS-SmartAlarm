import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tpnisalarm/screens/edit_alarm.dart';
import 'package:tpnisalarm/services/alarm_list_service.dart';
import 'package:tpnisalarm/stores/alarm_list/alarm_list.dart';
import 'package:tpnisalarm/stores/observable_alarm/observable_alarm.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tpnisalarm/utils/schedule_notifications.dart';
import 'package:tpnisalarm/widgets/alarm_item.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.alarms});

  final AlarmList alarms;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final AlarmListManager alarmService = AlarmListManager(widget.alarms);

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("WakeNa"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                    onPressed: () async {
                      addAlarm(context, alarmService);
                    },
                    icon: Icon(
                      Icons.alarm_add_outlined,
                    ),
                    label: Text(
                      'เพิ่มการปลุก',
                    )),
              ),
              SizedBox(
                height: 16,
              ),
              Observer(
                builder: (context) => ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final alarm = widget.alarms.alarms[index];

                    return Container(
                      key: Key(alarm.id.toString()),
                      child: AlarmItemWidget(
                        alarm: alarm,
                        alarmService: alarmService,
                        alarms: widget.alarms,
                      ),
                    );
                  },
                  itemCount: widget.alarms.alarms.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addAlarm(context, alarmService) {
    TimeOfDay tod = TimeOfDay.now();
    int id =
        widget.alarms.alarms.isNotEmpty ? widget.alarms.alarms.last.id! + 1 : 0;
    debugPrint("Length: ${widget.alarms.alarms.length}");
    debugPrint("New ID: $id");
    final newAlarm = ObservableAlarm.dayList(id, 'นาฬิกาปลุก', tod.hour,
        tod.minute, 0.7, false, "none", true, List.filled(7, false));
    widget.alarms.alarms.add(newAlarm);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAlarmPage(
          alarm: newAlarm,
          alarmService: alarmService,
          alarms: widget.alarms,
        ),
      ),
    ).then((_) {
      setState(() {});
    });
  }
}

class NoneWidget extends StatelessWidget {
  const NoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
