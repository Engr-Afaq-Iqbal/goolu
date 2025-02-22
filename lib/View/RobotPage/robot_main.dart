import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/RobotController/robot_controller.dart';
import 'package:goolu/View/RobotPage/GeneralFeature/robot_general.dart';
import 'package:goolu/View/RobotPage/SituationFeature/robot_situation.dart';
import 'package:goolu/View/RobotPage/TopicFeature/robot_topic.dart';

import '../../Config/app_config.dart';
import '../../Services/storage_sevices.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';
import '../../Utils/image_urls.dart';

class RobotMain extends StatefulWidget {
  const RobotMain({
    super.key,
  });

  @override
  State<RobotMain> createState() => _RobotMainState();
}

class _RobotMainState extends State<RobotMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppStyles().customAppBar(),
      body: GetBuilder<RobotController>(builder: (RobotController robotCtrl) {
        return Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(
                  vertical: SizesDimensions.height(3),
                  horizontal: SizesDimensions.width(5),
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft:
                          Radius.circular(Dimensions.radiusDoubleExtraLarge),
                      topRight:
                          Radius.circular(Dimensions.radiusDoubleExtraLarge)),
                  color: kLightYellow.withOpacity(0.3),
                ),
                child: Column(
                  children: [
                    Center(
                      child: customText(
                        text: 'Practice speaking',
                        textStyle: regular18NavyBlue.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    size20h,
                    AppStyles.dividerLine(
                      color: kDarkYellow,
                      width: SizesDimensions.width(50),
                      height: 2,
                    ),
                    size120h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: AppStorage.getUserData()?.isPackage == '1'
                              ? () {
                                  Get.to(() => const RobotGeneral());
                                }
                              : null,
                          child: box(
                            txt: 'General',
                            boxColor: kLightGreen79ccdc,
                            isLock: AppStorage.getUserData()?.isPackage == '0'
                                ? true
                                : false,
                          ),
                        ),
                        GestureDetector(
                          onTap: AppStorage.getUserData()?.isPackage == '1'
                              ? () {
                                  Get.to(() => const RobotTopic());
                                }
                              : null,
                          child: box(
                            txt: 'Topic',
                            boxColor: kLightGreen79ccdc,
                            isLock: AppStorage.getUserData()?.isPackage == '0'
                                ? true
                                : false,
                          ),
                        ),
                      ],
                    ),
                    size30h,
                    GestureDetector(
                      onTap: AppStorage.getUserData()?.isPackage == '1'
                          ? () {
                              Get.to(() => const RobotSituation());
                            }
                          : null,
                      child: box(
                        txt: 'Situation',
                        boxColor: kLightGreen79ccdc,
                        isLock: AppStorage.getUserData()?.isPackage == '0'
                            ? true
                            : false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(child: RobotTabPage()),
          ],
        );
      }),
    );
  }

  Container box({Color? boxColor, String? txt, bool isLock = true}) {
    return Container(
      width: SizesDimensions.width(42),
      height: SizesDimensions.height(21),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(
          Dimensions.radiusLarge,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLock == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 0.0),
                  child: SvgPicture.asset(
                    '$imgUrl$lockImg',
                    height: 35,
                  ),
                ),
              ],
            ),
          Center(
            child: customText(
              text: '$txt',
              textStyle: bold20White.copyWith(
                fontSize: 18,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          if (isLock == true) size30h,
        ],
      ),
    );
  }
}
