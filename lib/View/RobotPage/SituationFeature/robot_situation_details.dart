import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/Components/app_custom_button.dart';
import 'package:goolu/View/RobotPage/SituationFeature/robot_conversation_screen.dart';

import '../../../Config/app_config.dart';
import '../../../Controller/RobotController/robot_controller.dart';
import '../../../Theme/colors.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';

class RobotSituationDetails extends StatefulWidget {
  final String? situationName;
  const RobotSituationDetails({super.key, this.situationName});

  @override
  State<RobotSituationDetails> createState() => _RobotSituationDetailsState();
}

class _RobotSituationDetailsState extends State<RobotSituationDetails> {
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.radiusSingleExtraLarge),
                        child: Container(
                          height: SizesDimensions.height(50),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(
                                Dimensions.radiusSingleExtraLarge),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                size50h,
                                Center(
                                  child: customText(
                                    text: '${widget.situationName}',
                                    textStyle: regular18NavyBlue.copyWith(
                                      fontSize: 14,
                                      color: primaryBlueGradientDarkColor,
                                    ),
                                  ),
                                ),
                                size50h,
                                questionWithAnswer(
                                  robotQuestion:
                                      '[Barista] Hij what can I get started for you today?',
                                  userAnswer:
                                      '[User] I\'ll have a large coffee, please.',
                                ),
                                questionWithAnswer(
                                  robotQuestion:
                                      '[Barista] Would you like whole milk, skim milk,',
                                  userAnswer:
                                      '[User] Skim milk is fine, thank you.',
                                ),
                                questionWithAnswer(
                                  robotQuestion:
                                      '[Barista] Would you like your coffee sweetened with sugar, or a non-dairy milk alternative?,',
                                  userAnswer: '[User] Just sugar, please.',
                                ),
                                questionWithAnswer(
                                  robotQuestion:
                                      '[Barista] That\'ll be \$2.50 please.',
                                  userAnswer:
                                      '[User] Here you go. Keep the change.',
                                ),
                                questionWithAnswer(
                                  robotQuestion:
                                      '[Barista] Thank you, have a great day!',
                                  userAnswer: '[User] You too!',
                                ),
                                size50h,
                              ],
                            ),
                          ),
                        ),
                      ),
                      size100h,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppCustomButton(
                            onTap: () {
                              Get.to(() => const RobotConversationScreen());
                            },
                            title: customText(
                              text: 'Start',
                              textStyle: regular16White.copyWith(fontSize: 16),
                            ),
                            horizontalPadding: 50,
                            borderRadius: Dimensions.radiusSingleExtraLarge,
                          ),
                        ],
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

  Column questionWithAnswer({String? robotQuestion, String? userAnswer}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText(
          text: '$robotQuestion',
          maxLines: 5,
          textStyle: bold18NavyBlue.copyWith(
            fontSize: 14,
            color: secDarkBlueNavyColor,
          ),
        ),
        size5h,
        customText(
          text: '$userAnswer',
          maxLines: 5,
          textStyle: regular18NavyBlue.copyWith(
            fontSize: 14,
            color: secDarkBlueNavyColor,
          ),
        ),
        size10h,
      ],
    );
  }
}
