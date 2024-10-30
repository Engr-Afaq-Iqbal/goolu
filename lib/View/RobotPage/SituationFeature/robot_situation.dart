import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/View/RobotPage/SituationFeature/robot_situation_details.dart';

import '../../../Config/app_config.dart';
import '../../../Controller/RobotController/robot_controller.dart';
import '../../../Theme/colors.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';

class RobotSituation extends StatefulWidget {
  const RobotSituation({super.key});

  @override
  State<RobotSituation> createState() => _RobotSituationState();
}

class _RobotSituationState extends State<RobotSituation> {
  RobotController robotCtrl = Get.find<RobotController>();
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(Icons.arrow_back)),
                          size50w,
                          size50w,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customText(
                                text: 'Situation',
                                textStyle: regular18NavyBlue.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                              size20h,
                              AppStyles.dividerLine(
                                color: kDarkYellow,
                                width: SizesDimensions.width(50),
                                height: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      size30h,
                      Container(
                        // height: SizesDimensions.height(72),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(
                              Dimensions.radiusSingleExtraLarge),
                        ),
                        child: Column(
                          children: [
                            size50h,
                            customText(
                              text: 'Pick an answer to practice',
                              textStyle: regular18NavyBlue.copyWith(
                                fontSize: 14,
                                color: primaryBlueGradientDarkColor,
                              ),
                            ),
                            size30h,
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => const RobotSituationDetails(
                                        situationName: 'Ordering a coffee',
                                      ));
                                },
                                child: answersBox(answer: 'Ordering a coffee')),
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => const RobotSituationDetails(
                                        situationName: 'Booking a taxi',
                                      ));
                                },
                                child: answersBox(answer: 'Booking a taxi')),
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => const RobotSituationDetails(
                                        situationName: 'Booking a hotel',
                                      ));
                                },
                                child: answersBox(answer: 'Booking a hotel')),
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => const RobotSituationDetails(
                                        situationName: 'Asking a refund',
                                      ));
                                },
                                child: answersBox(answer: 'Asking a refund')),
                            size50h,
                          ],
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

  Container answersBox({required String answer}) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: 10,
      ),
      padding: const EdgeInsets.only(
        top: 25,
        left: 20,
        right: 20,
        bottom: 25,
      ),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 24.0,
            height: 24.0,
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
          size30w,
          customText(
              text: answer,
              maxLines: 3,
              textStyle: regular14NavyBlue.copyWith(
                color: secDarkBlueNavyColor,
                fontSize: 14,
              )),
        ],
      ),
    );
  }
}
