import 'package:flutter/material.dart';
import 'package:tpnisalarm/utils/shake.dart';

import '../../main.dart';

class ShakeCaptcha extends StatefulWidget {
  const ShakeCaptcha({super.key});

  @override
  State<ShakeCaptcha> createState() => _ShakeCaptchaState();
}

class _ShakeCaptchaState extends State<ShakeCaptcha> {
  int shakeCount = 0;
  int stopWhen = 20;

  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () async {
      setState(() {
        shakeCount += 1;
      });

      if (shakeCount >= stopWhen) {
        await dismissCurrentAlarm();
      }
    });
    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เขย่า"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: (10 - shakeCount * 10 / stopWhen).toInt(),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                flex: (shakeCount * 10 / stopWhen).toInt(),
                child: Container(
                  color: Colors.blue.shade100,
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              '${(shakeCount * 100 / stopWhen).toInt().toString()}%',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }
}
