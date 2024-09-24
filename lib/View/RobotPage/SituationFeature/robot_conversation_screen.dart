import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/Utils/font_styles.dart';

import '../../../Config/app_config.dart';
import '../../../Controller/RobotController/robot_controller.dart';
import '../../../Theme/colors.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/image_urls.dart';

class RobotConversationScreen extends StatefulWidget {
  const RobotConversationScreen({super.key});

  @override
  State<RobotConversationScreen> createState() =>
      _RobotConversationScreenState();
}

class _RobotConversationScreenState extends State<RobotConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        appBar: AppStyles().customAppBar(),
        resizeToAvoidBottomInset: false,
        body: GetBuilder<RobotController>(builder: (RobotController robotCtrl) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(
                    // vertical: SizesDimensions.height(3),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.radiusSingleExtraLarge),
                        child: Container(
                          height: SizesDimensions.height(72),
                          decoration: BoxDecoration(
                            color: primaryBlueColor,
                            borderRadius: BorderRadius.circular(
                                Dimensions.radiusSingleExtraLarge),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: SizesDimensions.height(30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radiusSingleExtraLarge),
                                ),
                                child: Image.asset(
                                  '$imgUrl$orderCoffeeImg',
                                  width: Get.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // if (robotCtrl.showAnswers == true)
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  botQuestion(),
                                  size15h,
                                  userAnswer(),
                                  // size20h,
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Padding botQuestion() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            text: 'Bot',
            textStyle: bold14NavyBlue.copyWith(
              fontSize: 14,
            ),
          ),
          size5h,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: Get.width,
            margin: const EdgeInsets.only(right: 30),
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radiusExtraLarge),
                    bottomRight: Radius.circular(Dimensions.radiusExtraLarge),
                    topRight: Radius.circular(Dimensions.radiusExtraLarge))),
            child: SizedBox(
              width: SizesDimensions.width(50),
              child: customText(
                  text: 'Hi, what can I get started for you today?',
                  maxLines: 5,
                  textStyle: regular14NavyBlue.copyWith(fontSize: 14)),
            ),
          )
        ],
      ),
    );
  }

  Padding userAnswer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: Get.width,
        margin: const EdgeInsets.only(right: 30),
        decoration: BoxDecoration(
            color: kDarkYellow,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radiusExtraLarge),
                bottomLeft: Radius.circular(Dimensions.radiusExtraLarge),
                topRight: Radius.circular(Dimensions.radiusExtraLarge))),
        child: SizedBox(
          width: SizesDimensions.width(50),
          child: customText(
              text: 'Hi, what can I get started for you today?',
              maxLines: 5,
              textStyle: regular14NavyBlue.copyWith(
                fontSize: 14,
                color: kWhite,
              )),
        ),
      ),
    );
  }
}
