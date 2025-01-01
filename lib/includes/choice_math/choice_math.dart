import 'dart:math';

import 'package:flutter/material.dart';

import '../../main.dart';

class ChoiceMathCaptcha extends StatefulWidget {
  const ChoiceMathCaptcha({super.key});

  @override
  State<ChoiceMathCaptcha> createState() => _ChoiceMathCaptchaState();
}

class _ChoiceMathCaptchaState extends State<ChoiceMathCaptcha> {
  int firstNum = Random().nextInt(99);
  int secondNum = Random().nextInt(99);
  int operation = Random().nextInt(3);
  String operationParsed = "";
  int answer = 0;
  List<int> answers = [1, 2, 3, 4];

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

    setState(() {
      answers = [
        next(answer - 3, answer + 7),
        next(answer - 10, answer + 9),
        next(answer - 8, answer + 5),
        answer
      ];
      answers.shuffle();
    });
  }

  int next(int min, int max) => (min + Random().nextInt(max - min)).toInt();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("คิดเลข"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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
              GridView.count(
                primary: false,
                shrinkWrap: true,
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(4, (index) {
                  return Card.outlined(
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () => checkAnswer(index),
                      child: Center(
                        child: Text(
                          answers[index].toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
  }

  void checkAnswer(index) {
    if (answers[index] == answer) {
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
}
