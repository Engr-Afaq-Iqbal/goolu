import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Config/app_config.dart';
import 'package:goolu/Controller/MicrophoneController/microphone_controller.dart';
import 'package:goolu/Controller/RobotController/robot_controller.dart';
import 'package:goolu/Theme/colors.dart';
import 'package:goolu/Utils/dimensions.dart';
import 'package:goolu/View/RobotPage/AdvancedFeature/well_done.dart';

import '../../../Utils/font_styles.dart';
import '../../../Utils/image_urls.dart';
import '../../../Utils/utils.dart';
import 'dont_lose_hope.dart';

class AdvancedRobotTopic extends StatefulWidget {
  final String answer;
  final String question;
  final String route;
  const AdvancedRobotTopic(
      {super.key,
      required this.answer,
      required this.question,
      required this.route});

  @override
  State<AdvancedRobotTopic> createState() => _AdvancedRobotTopicState();
}

class _AdvancedRobotTopicState extends State<AdvancedRobotTopic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RobotController>(builder: (RobotController robotCtrl) {
        return Container(
          width: SizesDimensions.width(100),
          height: Get.height,
          color: kLightYellow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              size20h,
              GestureDetector(
                onTap: () {
                  robotCtrl.micButton = true;
                  robotCtrl.micSubButton = true;
                  robotCtrl.showResult = false;
                  robotCtrl.playSubButton = false;
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: SizesDimensions.width(2),
                      right: SizesDimensions.width(2),
                      top: SizesDimensions.height(3)),
                  child: Icon(
                    Icons.arrow_back_outlined,
                    color: kD2B352,
                    size: 30,
                  ),
                ),
              ),
              size100h,
              if ((robotCtrl.isPassed == false &&
                      robotCtrl.showResult == false) ||
                  (robotCtrl.isPassed == true && robotCtrl.showResult == false))
                Center(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: SizesDimensions.width(2),
                      right: SizesDimensions.width(2),
                    ),
                    width: SizesDimensions.width(70),
                    child: customText(
                      text: widget.answer,
                      maxLines: 10,
                      textStyle: regular14NavyBlue.copyWith(
                        color: secDarkBlueNavyColor,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              if (robotCtrl.isPassed == true && robotCtrl.showResult == true)
                const WellDone(),
              if (robotCtrl.isPassed == false && robotCtrl.showResult == true)
                const DontLoseHope(),
              if (robotCtrl.micButton == true &&
                  robotCtrl.micSubButton == false)
                size30h,
              if (robotCtrl.micButton == true &&
                  robotCtrl.micSubButton == false)
                Center(child: SvgPicture.asset('$imgUrl$redWaveImg')),
              if (robotCtrl.micButton == false &&
                  robotCtrl.playSubButton == true &&
                  robotCtrl.showResult == false)
                Center(child: SvgPicture.asset('$imgUrl$playWaveformImg')),
              if (robotCtrl.micButton == false &&
                  robotCtrl.playSubButton == false &&
                  robotCtrl.showResult == false)
                Center(child: SvgPicture.asset('$imgUrl$pauseWaveformImg')),
              const Spacer(),
              SizedBox(
                height: 250,
                width: Get.width,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: -32,
                      child: SvgPicture.asset(
                        '$imgUrl$bottomRoundImg',
                        width: Get.width,
                      ),
                    ),
                    Positioned(
                      left: 25,
                      right: 25,
                      bottom: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: robotCtrl.micButton == false
                                ? () {
                                    robotCtrl.micButton = true;
                                    robotCtrl.micSubButton = true;
                                    robotCtrl.showResult = false;
                                    robotCtrl.playSubButton = false;
                                    Get.back();
                                  }
                                : null,
                            child: Container(
                              width: 55,
                              height: 55,
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                color: robotCtrl.micButton == false
                                    ? kRedFE5657
                                    : k7F7F7F
                                        .withOpacity(0.3), // Background color
                                shape: BoxShape
                                    .circle, // Makes the container circular
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  color: kWhite,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          if (robotCtrl.showResult == false)
                            customText(
                                text: robotCtrl.micButton == true
                                    ? robotCtrl.micSubButton == true
                                        ? 'Ready'
                                        : 'Recording'
                                    : robotCtrl.playSubButton == true
                                        ? 'Play'
                                        : 'Pause',
                                textStyle:
                                    bold18NavyBlue.copyWith(fontSize: 18)),
                          GestureDetector(
                            onTap: robotCtrl.micButton == false
                                ? (robotCtrl.isPassed == false &&
                                            robotCtrl.showResult == true ||
                                        robotCtrl.isPassed == true &&
                                            robotCtrl.showResult == true)
                                    ? () async {
                                        robotCtrl.micButton = true;
                                        robotCtrl.micSubButton = true;
                                        robotCtrl.showResult = false;
                                        robotCtrl.playSubButton = false;
                                        Get.close(2);
                                      }
                                    : () async {
                                        showProgress();
                                        await Future.delayed(
                                            const Duration(seconds: 1));
                                        robotCtrl.matchSpokenAndAnswerText(
                                            widget.answer,
                                            widget.question,
                                            widget.route);
                                      }
                                : null,
                            child: Container(
                              width: 55,
                              height: 55,
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                color: robotCtrl.micButton == false
                                    ? kLightBlue35B0C8
                                    : k7F7F7F
                                        .withOpacity(0.3), // Background color
                                shape: BoxShape
                                    .circle, // Makes the container circular
                              ),
                              child: Center(
                                child: Icon(
                                  (robotCtrl.isPassed == false &&
                                              robotCtrl.showResult == true ||
                                          robotCtrl.isPassed == true &&
                                              robotCtrl.showResult == true)
                                      ? Icons.loop
                                      : Icons.check,
                                  color: kWhite,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (robotCtrl.showResult == false)
                      Positioned(
                        left: 50,
                        right: 50,
                        bottom: 90,
                        child: GestureDetector(
                          onTap: robotCtrl.micButton == true
                              ? () async {
                                  if (robotCtrl.micSubButton == true) {
                                    logger.i('In Start');

                                    robotCtrl.startListening();

                                    ///here mic ready functionality will work
                                    robotCtrl.micSubButton = false;
                                    robotCtrl.update();
                                  } else {
                                    ///recording functionality will work
                                    robotCtrl.playSubButton = true;
                                    robotCtrl.micButton = false;
                                    robotCtrl.stopListening();
                                    robotCtrl.update();
                                  }
                                  robotCtrl.update();
                                }
                              : () {
                                  if (robotCtrl.playSubButton == true) {
                                    robotCtrl.playRecordedText();
                                    robotCtrl.playSubButton = false;
                                    robotCtrl.update();
                                  } else {
                                    Get.find<MicrophoneController>()
                                        .stopSpeaking();
                                    robotCtrl.playSubButton = true;
                                    robotCtrl.update();
                                  }
                                  robotCtrl.update();
                                },
                          child: Container(
                            width: 75,
                            height: 75,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: robotCtrl.micSubButton == false &&
                                      robotCtrl.micButton == true
                                  ? kRedFFB7B8
                                  : k003366,
                              boxShadow: robotCtrl.micSubButton == false &&
                                      robotCtrl.micButton == true
                                  ? [
                                      BoxShadow(
                                        color: kRedFE5657.withOpacity(0.8),
                                        spreadRadius: 3,
                                        blurRadius: 4,
                                        offset: const Offset(0, 0),
                                      ),
                                    ]
                                  : [],
                              border: Border.all(
                                color: robotCtrl.micSubButton == false &&
                                        robotCtrl.micButton == true
                                    ? kRedFF9090
                                    : Colors.transparent,
                                width: 7,
                              ),
                              shape: BoxShape
                                  .circle, // Makes the container circular
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                robotCtrl.micButton == true
                                    ? '$imgUrl$whiteMicImg'
                                    : robotCtrl.playSubButton == true
                                        ? '$imgUrl$playButtonImg'
                                        : '$imgUrl$pauseButtonImg',
                                color: robotCtrl.micSubButton == false &&
                                        robotCtrl.micButton == true
                                    ? kRedFE5657
                                    : kWhite,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      Positioned(
                        left: 100,
                        right: 100,
                        bottom: 80,
                        child: Center(
                          child: customText(
                            text: robotCtrl.isPassed == true
                                ? 'Try another sentence?'
                                : 'Try again?',
                            textStyle: regular16NavyBlue,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
