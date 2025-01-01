import 'dart:math';

import 'package:flutter/material.dart';

import '../../main.dart';

class TypedMathCaptcha extends StatefulWidget {
  const TypedMathCaptcha({super.key});

  @override
  State<TypedMathCaptcha> createState() => _TypedMathCaptchaState();
}

class _TypedMathCaptchaState extends State<TypedMathCaptcha> {
  int firstNum = Random().nextInt(99);
  int secondNum = Random().nextInt(99);
  int operation = Random().nextInt(3);
  String operationParsed = "";
  int answer = 0;

  final answerController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    answerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    switch (operation) {
      case 0:
        setState(() {
          operationParsed = "+";
          answer = firstNum + secondNum;
        });
        break;
      case 1:
        setState(() {
          operationParsed = "-";
          answer = firstNum - secondNum;
        });
        break;
      case 2:
        if (firstNum <= 1 && secondNum <= 12) {
          setState(() {
            operationParsed = "×";
            answer = firstNum * secondNum;
          });
        } else {
          setState(() {
            operationParsed = "+";
            answer = firstNum + secondNum;
          });
        }

        break;
      case 3:
        if (firstNum % secondNum == 0) {
          setState(() {
            operationParsed = "÷";
            answer = (firstNum / secondNum).toInt();
          });
        } else {
          setState(() {
            operationParsed = "-";
            answer = firstNum - secondNum;
          });
        }
        break;
      default:
    }
  }

  int next(int min, int max) => (min + Random().nextInt(max - min)).toInt();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("คิดเลข"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: Center(
                  child: Text(
                    "$firstNum $operationParsed $secondNum",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
              TextField(
                controller: answerController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'ใส่คำตอบที่นี่',
                ),
              ),
              SizedBox(
                height: 12,
              ),
              OutlinedButton(
                onPressed: () {
                  checkAnswer();
                },
                child: const Text('ยืนยันคำตอบ'),
              )
            ],
          ),
        ));
  }

  void checkAnswer() {
    if (isNumeric(answerController.text) &&
        int.parse(answerController.text) == answer) {
      dismissCurrentAlarm();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('แจ้งเตือน'),
            content: const Text('คำตอบของคุณนั้นผิด โปรดลองใหม่อีกครั้ง'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('ปิด'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }
}
