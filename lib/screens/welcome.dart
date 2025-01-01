import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tpnisalarm/main.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Future<void> _onIntroEnd(context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const Entry()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        bodyTextStyle: bodyStyle,
        bodyPadding: EdgeInsets.fromLTRB(16.0, 24, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero,
        bodyAlignment: Alignment.center);

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //       child: Text("WakeNa"),
      //     ),
      //   ),
      // ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 20,
        // child: ElevatedButton(
        //   child: const Text(
        //     'Let\'s go right away!',
        //     style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        //   ),
        //   onPressed: () => _onIntroEnd(context),
        // ),
      ),
      pages: [
        PageViewModel(
          title: "ยินดีต้อนรับสู่ WakeNa",
          body: "WakeNa เป็นแอพพลิเคชันนาฬิกาปลุกที่จะทำให้คุณตื่นง่ายขึ้น",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "โปรดอนุญาติให้เราเข้าถึง",
          body:
              "ก่อนที่เราจะสามารถปลุกคุณได้ เราต้องการสิทธิ์ในการเข้าถึงการตั้งนาฬิกาปลุก การแจ้งเตือน และการปรากฎบนแอพอื่นเพื่อที่จะทำให้แอพของเราใช้งานได้",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "อนุญาติให้เราแจ้งเตือนคุณ",
          body: 'เมื่อมีหน้าต่างขึ้นมาให้กด "อนุญาติ"',
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "อนุญาติให้เราสามารถแสดงบนแอพอื่น",
          body:
              'หลังจากนี้แอพจะพาคุณไปยังการตั้งค่า ให้หาแอพพลิเคชัน WakeNa และอนุญาติ',
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "อนุญาติให้เราสามารถตั้งเวลาปลุก",
          body:
              'หลังจากนี้แอพจะพาคุณไปยังการตั้งค่า ให้กดสวิทซ์ให้เปิดเพื่ออนุญาติ',
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "เริ่มต้นใช้งาน",
          body:
              "ขอบคุณที่ติดตั้งแอพพลิเคชัน WakeNa ขอให้มีความสุขกับการใช้แอพของเรา :)",
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: ShapeDecoration(
        color: Colors.lightBlue.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      onChange: (page) => {
        debugPrint('$page'),
        if (page == 3) {requestNotificationPermission()},
        if (page == 4) {requestAlertPermission()},
        if (page == 5) {requestSchedulePermission()},
      },
    );
  }

  Future<void> requestNotificationPermission() async {
    await Permission.notification.request();
    debugPrint("Request Noti");
    var status = await Permission.notification.status;
    if (status.isDenied) {
      introKey.currentState?.previous();
    }
  }

  Future<void> requestAlertPermission() async {
    await Permission.systemAlertWindow.request();
    debugPrint("Request Alert");
    var status = await Permission.systemAlertWindow.status;
    if (status.isDenied) {
      introKey.currentState?.previous();
    }
  }

  Future<void> requestSchedulePermission() async {
    await Permission.scheduleExactAlarm.request();
    debugPrint("Request Alert");
    var status = await Permission.scheduleExactAlarm.status;
    if (status.isDenied) {
      introKey.currentState?.previous();
    }
  }
}
