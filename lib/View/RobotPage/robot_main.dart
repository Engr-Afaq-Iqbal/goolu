import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/RobotController/robot_controller.dart';
import 'package:goolu/View/RobotPage/GeneralFeature/robot_general.dart';
import 'package:goolu/View/RobotPage/SituationFeature/robot_situation.dart';
import 'package:goolu/View/RobotPage/TopicFeature/robot_topic.dart';

import '../../Config/app_config.dart';
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
  void initState() {
    // Get.find<AccountInfoController>().fetchAddressDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Get.find<HomeController>().clearAllModelData();
    super.dispose();
  }

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
                        text: 'Practice',
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
                    size30h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const RobotGeneral());
                          },
                          child: box(
                            txt: 'General',
                            boxColor: kLightGreen79ccdc,
                            isLock: false,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const RobotTopic());
                          },
                          child: box(
                            txt: 'Topic',
                            boxColor: kLightGreen79ccdc,
                            isLock: false,
                          ),
                        ),
                      ],
                    ),
                    size30h,
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const RobotSituation());
                      },
                      child: box(
                        txt: 'Situation',
                        boxColor: kLightGreen79ccdc,
                        isLock: false,
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
