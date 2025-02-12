import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        backgroundColor: kLightBlue32A3B8,
        drawerEnableOpenDragGesture: false,
        appBar: AppStyles().customAppBar(),
        resizeToAvoidBottomInset: false,
        body: GetBuilder<RobotController>(builder: (RobotController robotCtrl) {
          return Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(
                    // vertical: SizesDimensions.height(3),
                    horizontal: SizesDimensions.width(5),
                  ),
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft:
                            Radius.circular(Dimensions.radiusDoubleExtraLarge),
                        topRight:
                            Radius.circular(Dimensions.radiusDoubleExtraLarge)),
                    color: kWhite,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      size20h,
                      customText(
                        text: 'Situation',
                        textStyle: regular18NavyBlue.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      size10h,
                      AppStyles.dividerLine(
                        color: kLightBlue32A3B8,
                        width: SizesDimensions.width(25),
                        height: 2,
                      ),
                      size30h,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.radiusSingleExtraLarge),
                        child: Container(
                          height: SizesDimensions.height(55),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusSingleExtraLarge,
                            ),
                          ),
                          child: ListView.builder(
                            itemCount: robotCtrl.displayItems.length,
                            itemBuilder: (context, index) {
                              return robotCtrl.displayItems[index];
                            },
                          ),
                        ),
                      ),
                      size40h,
                      GestureDetector(
                        onTap: () async {
                          if (robotCtrl.feature3Speak) {
                            robotCtrl.feature3Speak = false;
                            robotCtrl.stopListening();
                          } else {
                            robotCtrl.feature3Speak = true;
                            robotCtrl.startListening();
                          }
                          robotCtrl.update();
                        },
                        // onTap: () async {
                        //   // if (robotCtrl.speechEnabled) {
                        //   //   robotCtrl.feature3Speak = true;
                        //   //   robotCtrl.startListening();
                        //   //   robotCtrl.handleAnswer();
                        //   //   robotCtrl.update();
                        //   // }
                        //
                        //   // Prevent rapid toggling
                        //   if (robotCtrl.feature3Speak) {
                        //     robotCtrl.feature3Speak = false;
                        //     robotCtrl.stopListening();
                        //     robotCtrl.update();
                        //     if (robotCtrl.isCustomer == true) {
                        //       robotCtrl.handleAnswer();
                        //     } else {
                        //       robotCtrl.handleUserQuestion();
                        //     }
                        //
                        //     // showToast(robotCtrl.wordsSpoken);
                        //   } else {
                        //     robotCtrl.feature3Speak = true;
                        //     robotCtrl.startListening();
                        //     robotCtrl.update();
                        //   }
                        //
                        //   robotCtrl.update();
                        // },
                        child: Container(
                          width: 75,
                          height: 75,
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: robotCtrl.feature3Speak == true
                                ? kRedFFB7B8
                                : k003366,
                            boxShadow: robotCtrl.feature3Speak == true
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
                              color: robotCtrl.feature3Speak == true
                                  ? kRedFF9090
                                  : Colors.transparent,
                              width: 7,
                            ),
                            shape:
                                BoxShape.circle, // Makes the container circular
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              '$imgUrl$whiteMicImg',
                              color: robotCtrl.feature3Speak == true
                                  ? kRedFE5657
                                  : kWhite,
                            ),
                          ),
                        ),
                      ),
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
}
