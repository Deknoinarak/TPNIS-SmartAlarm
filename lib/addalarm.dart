import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({super.key});

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
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
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!);
        });
    if (timeOfDay != null) {
      setState(() {
        selectedTime = timeOfDay;
      });
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
        title: const Text('เพิ่มการปลุก'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: 'บันทึก',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('กำลังบันทึก...')));
            },
          ),
        ],
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
                  Text(
                    "${selectedTime.hour}:${selectedTime.minute}",
                    style: TextStyle(fontSize: 42),
                  ),
                ],
              ),
              Spacer(),
              TextButton(
                onPressed: _showTimePicker,
                child: Container(
                  color: Colors.blueGrey,
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
                    DateFormat('dd MMM yyyy', "th").format(selectedDate),
                    style: TextStyle(fontSize: 38),
                  ),
                ],
              ),
              Spacer(),
              TextButton(
                onPressed: _showDatePicker,
                child: Container(
                  color: Colors.blueGrey,
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
    );
  }
}
