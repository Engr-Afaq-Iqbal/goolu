import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../Config/app_config.dart';
import '../../../../Controller/MicrophoneController/microphone_controller.dart';
import '../../../../Theme/colors.dart';
import '../../../../Utils/dimensions.dart';
import '../../../../Utils/font_styles.dart';
import '../../../../Utils/image_urls.dart';
import '../../AdvancedFeature/advanced_robot_topic.dart';

class RobotTopicWidget extends StatefulWidget {
  final String answer;
  final String questions;
  const RobotTopicWidget({
    super.key,
    required this.answer,
    required this.questions,
  });

  @override
  State<RobotTopicWidget> createState() => _RobotTopicWidgetState();
}

class _RobotTopicWidgetState extends State<RobotTopicWidget> {
  MicrophoneController microphoneCtrl = Get.find<MicrophoneController>();
  bool isShowAnswer = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: 10,
      ),
      decoration: BoxDecoration(
          color: kLightYellow,
          borderRadius: BorderRadius.circular(
            Dimensions.radiusExtraLarge,
          )),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: kWhite,
                boxShadow: [
                  BoxShadow(
                    color: kYellowffde59.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  Dimensions.radiusExtraLarge,
                ),
                border: Border.all(color: kYellowffde59)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: SizesDimensions.width(50),
                  child: customText(
                      text: widget.questions,
                      maxLines: 3,
                      textStyle: regular14NavyBlue.copyWith(
                        color: secDarkBlueNavyColor,
                        fontSize: 14,
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    microphoneCtrl.speak(widget.questions);
                  },
                  child: SvgPicture.asset(
                    '$imgUrl$speakerYellowImg',
                  ),
                ),
              ],
            ),
          ),
          if (isShowAnswer == true) size20h,
          if (isShowAnswer == true)
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizesDimensions.width(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: SizesDimensions.width(60),
                      child: customText(text: widget.answer, maxLines: 10)),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AdvancedRobotTopic(
                            question: widget.questions,
                            answer: widget.answer,
                            route: '/topic',
                          ));
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: k7F7F7F.withOpacity(0.3), // Background color
                        shape: BoxShape.circle, // Makes the container circular
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: kWhite,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (isShowAnswer == true) size10h,
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              setState(() {
                if (isShowAnswer == true) {
                  isShowAnswer = false;
                } else {
                  isShowAnswer = true;
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu,
                  color: kD2B352,
                  size: 25,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
