import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:goolu/Utils/font_styles.dart';

import '../../Config/app_config.dart';
import '../../Controller/AuthController/auth_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/image_urls.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    super.initState();
    flutterTts.setCompletionHandler(() {
      print("Speech completed");
    });
    flutterTts.setErrorHandler((msg) {
      print("Error: $msg");
    });
  }

  Future<void> _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak("note book");
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          '$gooluLogoUrl$gooluImage',
          height: 40,
        ),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(4.0), // Height of the bottom line
          child: Container(
            color: kYellowffde59, // Color of the bottom line
            height: 5.0, // Thickness of the bottom line
          ),
        ),
        leading: Builder(
          builder: (context) => // Ensure Scaffold is in context
              IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Get.find<AuthController>()
                        .scaffoldKey
                        .currentState
                        ?.openDrawer();
                  }),
        ),
      ),
      // drawer: Drawer(
      //   width: SizesDimensions.width(60),
      //   child: const DrawerDesign(),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          size20h,
          Center(
            child: Container(
              height: SizesDimensions.height(20),
              width: SizesDimensions.width(70),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: primaryBlueColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customText(text: 'Word of the day', textStyle: bold16White),
                  size20h,
                  Row(
                    children: [
                      customText(
                          text: 'Note - book (n)', textStyle: bold16White),
                      size20w,
                      GestureDetector(
                        onTap: _speak,
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: kYellowffde59, // Background color
                            shape:
                                BoxShape.circle, // Makes the container circular
                          ),
                          child: SvgPicture.asset(
                            '$imgUrl$playImage',
                            color: primaryBlueColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  size10h,
                  customText(
                      text: '(with form, sound button, definition)',
                      textStyle: regular12White,
                      maxLines: 3,
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
          size20h,
          Container(
            // height: SizesDimensions.height(30),
            width: SizesDimensions.width(70),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kRedFF624D, width: 2)),
            child: Column(
              children: [
                customText(
                    text: 'Mixed up sentence with\nword\nof the day',
                    textStyle: bold16NavyBlue,
                    maxLines: 4,
                    textAlign: TextAlign.center),
                size20h,
                customText(
                    text: 'I / need / a / new/ notebook.',
                    textStyle: bold14NavyBlue,
                    maxLines: 3,
                    textAlign: TextAlign.center),
                size20h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box(txt: 'need'),
                    box(txt: 'I'),
                    box(txt: 'new'),
                    box(txt: 'a'),
                  ],
                ),
                size15h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    box(txt: 'notebook'),
                  ],
                ),
                size20h,
                Row(
                  children: [
                    Container(
                      // height: SizesDimensions.height(20),
                      // width: SizesDimensions.width(50),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kRedFF624D,
                      ),
                      child: Center(
                        child: customText(
                            text: 'Try again',
                            textStyle: regular14White,
                            maxLines: 3,
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container box({String? txt}) {
    return Container(
      // height: SizesDimensions.height(20),
      // width: SizesDimensions.width(50),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: primaryBlueColor,
      ),
      child: Center(
        child: customText(
            text: '$txt',
            textStyle: regular14White,
            maxLines: 3,
            textAlign: TextAlign.center),
      ),
    );
  }
}
