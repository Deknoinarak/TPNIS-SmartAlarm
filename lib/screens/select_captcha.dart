import 'package:flutter/material.dart';
import 'package:tpnisalarm/stores/observable_alarm/observable_alarm.dart';
import 'package:tpnisalarm/utils/captchas.dart';

class SelectCaptchaPage extends StatelessWidget {
  const SelectCaptchaPage({super.key, required this.alarm});

  final ObservableAlarm? alarm;

  @override
  Widget build(BuildContext context) {
    List captchas = CaptchasList().captchas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('เลือกกิจกรรม'),
      ),
      body: Container(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(captchas.length, (index) {
              return Card.outlined(
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: () {
                    debugPrint(captchas[index].id);
                    alarm!.captcha = captchas[index].id;
                    Navigator.pop(context);
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          captchas[index].name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Stack(
                            clipBehavior: Clip.hardEdge,
                            children: [
                              Positioned(
                                right: -25,
                                bottom: -25,
                                child: captchas[index].icon,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          )),
    );
  }
}
