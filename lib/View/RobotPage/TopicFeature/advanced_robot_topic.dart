import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Config/app_config.dart';
import 'package:goolu/Theme/colors.dart';
import 'package:goolu/Utils/dimensions.dart';

import '../../../Utils/font_styles.dart';
import '../../../Utils/image_urls.dart';

class AdvancedRobotTopic extends StatefulWidget {
  final String question;
  final String answer;
  const AdvancedRobotTopic(
      {super.key, required this.answer, required this.question});

  @override
  State<AdvancedRobotTopic> createState() => _AdvancedRobotTopicState();
}

class _AdvancedRobotTopicState extends State<AdvancedRobotTopic> {
  bool tapOnMic = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizesDimensions.width(100),
        height: Get.height,
        color: kLightYellow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            size20h,
            GestureDetector(
              onTap: () {
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
            size10h,
            Padding(
              padding: EdgeInsets.only(
                left: SizesDimensions.width(2),
                right: SizesDimensions.width(2),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Image.asset(
                      '$imgUrl$orderCoffeeImg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 30,
                    child: SvgPicture.asset(
                      '$imgUrl$speakerYellowImg',
                      colorFilter: ColorFilter.mode(
                        kWhite,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            size20h,
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
                          onTap: () {},
                          child: Container(
                            width: 55,
                            height: 55,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color:
                                  k7F7F7F.withOpacity(0.3), // Background color
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
                        customText(
                            text: 'Ready',
                            textStyle: bold18NavyBlue.copyWith(fontSize: 18)),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 55,
                            height: 55,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color:
                                  k7F7F7F.withOpacity(0.3), // Background color
                              shape: BoxShape
                                  .circle, // Makes the container circular
                            ),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: kWhite,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 50,
                    right: 50,
                    bottom: 90,
                    child: GestureDetector(
                      onTap: () {
                        if (tapOnMic == false) {
                          tapOnMic = true;
                        } else {
                          tapOnMic = false;
                        }
                      },
                      child: Container(
                        width: 75,
                        height: 75,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: k003366, // Background color
                          shape:
                              BoxShape.circle, // Makes the container circular
                        ),
                        child: Center(
                          child: SvgPicture.asset('$imgUrl$whiteMicImg'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
