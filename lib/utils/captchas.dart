import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Captchas {
  Captchas(this.id, this.name, this.desc);

  String id;
  String name;
  String desc;
  late Widget icon = Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
        color: id == 'none' ? Colors.red.shade50 : Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(999)),
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: SvgPicture.asset(
        'assets/$id.svg',
        semanticsLabel: name,
        colorFilter: ColorFilter.mode(
            id == 'none' ? Colors.red.shade800 : Colors.blue.shade800,
            BlendMode.srcIn),
      ),
    ),
  );
}

class CaptchasList {
  CaptchasList();

  final List<Captchas> captchas = [
    Captchas("none", 'ไม่มี', 'ไม่มี'),
    Captchas("shake", 'เขย่า', 'เขย่า'),
    Captchas("choice_math", 'คิดเลข', 'คิดเลขแบบมีตัวเลือก'),
    Captchas("typed_math", 'คิดเลข (พิมพ์)', 'คิดเลขแบบพิมพ์'),
  ];

  Captchas getCaptchaFromId(id) {
    return captchas.firstWhere((el) => el.id == id,
        orElse: () => Captchas("none", 'ไม่มี', 'ไม่มี'));
  }
}
