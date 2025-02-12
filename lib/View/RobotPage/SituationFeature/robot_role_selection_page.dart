import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/View/RobotPage/SituationFeature/robot_conversation_screen.dart';
import 'package:goolu/View/RobotPage/SituationFeature/widgets/bot_question_widget.dart';

import '../../../Components/app_custom_button.dart';
import '../../../Config/app_config.dart';
import '../../../Controller/RobotController/robot_controller.dart';
import '../../../Theme/colors.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';

class RobotRoleSelectionPage extends StatelessWidget {
  final String? title1;
  final String? title2;
  const RobotRoleSelectionPage({
    super.key,
    this.title1,
    this.title2,
  });
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
                          size60w,
                          size60w,
                          size60w,
                          size60w,
                          size30w,
                          Column(
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
                            ],
                          ),
                        ],
                      ),
                      size100h,
                      size100h,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppCustomButton(
                            onTap: () {
                              robotCtrl.displayItems.clear();
                              Get.to(() => const RobotConversationScreen());
                            },
                            title: customText(
                              text:
                                  '${Get.find<RobotController>().situationModel?.titleBot}',
                              textStyle: regular16White.copyWith(fontSize: 16),
                            ),
                            horizontalPadding: 25,
                            borderRadius: Dimensions.radiusSingleExtraLarge,
                          ),
                          AppCustomButton(
                            onTap: () {
                              robotCtrl.displayItems.clear();
                              robotCtrl.displayItems.add(BotQuestionWidget(
                                question: robotCtrl
                                    .situationModel!
                                    .data![robotCtrl.currentQuestionIndex]
                                    .question,
                              ));
                              robotCtrl.update();
                              Get.to(() => const RobotConversationScreen());
                            },
                            title: customText(
                              text:
                                  '${Get.find<RobotController>().situationModel?.titleUser}',
                              textStyle: regular16White.copyWith(fontSize: 16),
                            ),
                            horizontalPadding: 25,
                            borderRadius: Dimensions.radiusSingleExtraLarge,
                          ),
                        ],
                      ),
                      // size100h,
                      // size100h,
                      // size100h,
                      // size100h,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     AppCustomButton(
                      //       onTap: () {
                      //         Get.to(() => const RobotConversationScreen());
                      //       },
                      //       title: customText(
                      //         text: 'Start',
                      //         textStyle: regular16White.copyWith(fontSize: 16),
                      //       ),
                      //       horizontalPadding: 50,
                      //       borderRadius: Dimensions.radiusSingleExtraLarge,
                      //     ),
                      //   ],
                      // ),
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
