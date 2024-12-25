import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:tpnisalarm/services/alarm_list_service.dart';
import 'package:tpnisalarm/services/alarm_scheduler_service.dart';
import 'package:tpnisalarm/stores/alarm_list/alarm_list.dart';
import 'package:tpnisalarm/stores/observable_alarm/observable_alarm.dart';

class EditAlarmPage extends StatefulWidget {
  const EditAlarmPage(
      {super.key,
      required this.alarm,
      required this.alarmService,
      required this.alarms});

  final ObservableAlarm alarm;
  final AlarmListManager alarmService;
  final AlarmList alarms;

  @override
  State<EditAlarmPage> createState() => _EditAlarmPageState();
}

class _EditAlarmPageState extends State<EditAlarmPage> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();

  Future<void> _showTimePicker() async {
    final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!);
        });
    if (time != null) {
      widget.alarm.hour = time.hour;
      widget.alarm.minute = time.minute;
    }
  }

  Future<void> _showDatePicker() async {
    final DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        locale: const Locale("th", "TH"),
        lastDate: DateTime(2100));
    if (dateTime != null) {
      setState(() {
        selectedDate = dateTime;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              await saveAlarm();
            },
          ),
          tooltip: 'บันทึก',
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('กำลังบันทึก...')));
          },
        ),
        title: const Text('ตั้งค่าการปลุก'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextFormField(
            controller: nameController..text = "นาฬิกาปลุก",
            decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                suffixIcon: Icon(Icons.edit_outlined)),
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("เวลา"),
                  // Text(
                  //   "${selectedTime.hour}:${selectedTime.minute}",
                  //   style: TextStyle(fontSize: 42),
                  // ),
                  Observer(builder: (context) {
                    final hours = widget.alarm.hour.toString().padLeft(2, '0');
                    final minutes =
                        widget.alarm.minute.toString().padLeft(2, '0');
                    return Text('$hours:$minutes',
                        style: TextStyle(
                          fontSize: 42,
                        ));
                  })
                ],
              ),
              Spacer(),
              TextButton(
                onPressed: _showTimePicker,
                child: Container(
                  color: Colors.lightBlue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: const Text(
                    'เลือกเวลาปลุก',
                    style: TextStyle(color: Colors.white, fontSize: 13.0),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("วันที่"),
                  Text(
                    DateFormat('EEE dd MMM yyyy', "th").format(selectedDate),
                    style: TextStyle(fontSize: 32),
                  ),
                ],
              ),
              Spacer(),
              TextButton(
                onPressed: _showDatePicker,
                child: Container(
                  color: Colors.lightBlue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: const Text(
                    'เลือกวันปลุก',
                    style: TextStyle(color: Colors.white, fontSize: 13.0),
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                label: Text(
                  "ลบ",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  deleteAlarm();
                },
              ),
              TextButton.icon(
                icon: Icon(Icons.check),
                label: Text(
                  "บันทึก",
                ),
                onPressed: () async {
                  await saveAlarm();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveAlarm() async {
    await widget.alarmService.saveAlarm(widget.alarm);
    await AlarmScheduler().scheduleAlarm(widget.alarm);
    Navigator.of(context).pop();
  }

  void deleteAlarm() {
    AlarmScheduler().clearAlarm(widget.alarm);
    widget.alarms.alarms.removeAt(widget.alarms.alarms.length - 1);
    Navigator.of(context).pop();
  }
}