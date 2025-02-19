import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Components/app_form_field.dart';
import 'package:goolu/Config/app_config.dart';
import 'package:goolu/Controller/MicrophoneController/microphone_controller.dart';
import 'package:goolu/Controller/RobotController/robot_controller.dart';
import 'package:goolu/Theme/colors.dart';
import 'package:goolu/Utils/dimensions.dart';
import 'package:goolu/Utils/utils.dart';
import 'package:goolu/View/RobotPage/AdvancedFeature/advanced_robot_topic.dart';

import '../../../Utils/font_styles.dart';
import '../../../Utils/image_urls.dart';

class RobotGeneral extends StatefulWidget {
  const RobotGeneral({super.key});

  @override
  State<RobotGeneral> createState() => _RobotGeneralState();
}

class _RobotGeneralState extends State<RobotGeneral> {
  RobotController robotCtrl = Get.find<RobotController>();
  MicrophoneController microphoneCtrl = Get.find<MicrophoneController>();
  @override
  void initState() {
    // TODO: implement initState
    robotCtrl.isSend = false;
    robotCtrl.questionsList.clear();
    robotCtrl.answerList.clear();
    robotCtrl.questionCtrl.clear();
    robotCtrl.answerCtrl.clear();
    robotCtrl.isSend = false;
    robotCtrl.questionAnswer = -1;
    robotCtrl.showAnswers = false;
    robotCtrl.initSpeech();
    super.initState();
  }

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
                                robotCtrl.isSend = false;
                                robotCtrl.questionsList.clear();
                                robotCtrl.answerList.clear();
                                robotCtrl.questionCtrl.clear();
                                robotCtrl.answerCtrl.clear();
                                robotCtrl.isSend = false;
                                robotCtrl.questionAnswer = -1;
                                robotCtrl.showAnswers = false;
                                robotCtrl.generateAnswersModel = null;
                                robotCtrl.update();
                                Get.back();
                              },
                              child: const Icon(Icons.arrow_back)),
                          size50w,
                          size50w,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customText(
                                text: 'General',
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
                      size20h,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.radiusSingleExtraLarge),
                        child: Container(
                          height: robotCtrl.showAnswers == true
                              ? SizesDimensions.height(72)
                              : SizesDimensions.height(20),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(
                                Dimensions.radiusSingleExtraLarge),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: SizesDimensions.height(20),
                                  // width: SizesDimensions.width(90),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: kLightBlue32A3B8,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusSingleExtraLarge),
                                  ),
                                  child: Column(
                                    children: [
                                      customText(
                                        text: 'Enter your Question',
                                        textStyle: regular16White,
                                      ),
                                      size30h,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: SizesDimensions.width(62),
                                            child: AppFormField(
                                              // boxWidth: 10,
                                              // width: SizesDimensions.width(75),
                                              padding: EdgeInsets.zero,
                                              borderRadius:
                                                  Dimensions.radiusExtraLarge,
                                              controller:
                                                  robotCtrl.questionCtrl,
                                              // labelText: 'Question',
                                              hintText: 'Text here',
                                              keyboardType: TextInputType.text,
                                              validator: (String? v) {
                                                if (v!.isEmpty) {
                                                  return 'Question Required';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                              if (robotCtrl.questionCtrl.text
                                                  .isNotEmpty) {
                                                robotCtrl.isSend = true;

                                                robotCtrl
                                                    .checkGrammarFunction();

                                                robotCtrl.update();
                                              } else {
                                                showToast(
                                                    'Please enter your question');
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions
                                                              .radiusLarge),
                                                  color: kLightBlue35B0C8,
                                                  border: Border.all(
                                                    color: kWhite,
                                                    width: 1,
                                                  )),
                                              child: SvgPicture.asset(
                                                '$imgUrl$sendArrowImg',
                                                // height: SizesDimensions.height(8),
                                                colorFilter: ColorFilter.mode(
                                                  kWhite,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                if (robotCtrl.showAnswers == true)
                                  Column(
                                    children: [
                                      size20h,
                                      customText(
                                        text: 'Answers',
                                        textStyle: bold18NavyBlue.copyWith(
                                          fontSize: 18,
                                          color: k003366,
                                        ),
                                      ),
                                      size10h,
                                      customText(
                                        text: 'Pick an answer to practice',
                                        textStyle: regular18NavyBlue.copyWith(
                                          fontSize: 14,
                                          color: k003366,
                                        ),
                                      ),
                                      answersBox(
                                        answer: robotCtrl.generateAnswersModel
                                                ?.option1 ??
                                            '',
                                        question: robotCtrl.questionCtrl.text,
                                      ),
                                      answersBox(
                                        answer: robotCtrl.generateAnswersModel
                                                ?.option2 ??
                                            '',
                                        question: robotCtrl.questionCtrl.text,
                                      ),
                                      answersBox(
                                        answer: robotCtrl.generateAnswersModel
                                                ?.option3 ??
                                            '',
                                        question: robotCtrl.questionCtrl.text,
                                      ),
                                      answersBox(
                                        answer: robotCtrl.generateAnswersModel
                                                ?.option4 ??
                                            '',
                                        question: robotCtrl.questionCtrl.text,
                                      ),
                                      answersBox(
                                        answer: robotCtrl.generateAnswersModel
                                                ?.option5 ??
                                            '',
                                        question: robotCtrl.questionCtrl.text,
                                      ),
                                    ],
                                  )
                              ],
                            ),
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

  Container answersBox({required String answer, required String question}) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: 10,
      ),
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
          GestureDetector(
            onTap: () {
              Get.to(
                AdvancedRobotTopic(
                  answer: answer,
                  question: question,
                  route: '/general',
                ),
              );
            },
            child: Container(
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
          ),
          SizedBox(
            width: SizesDimensions.width(50),
            child: customText(
                text: answer,
                maxLines: 3,
                textStyle:
                    regular14NavyBlue.copyWith(color: secDarkBlueNavyColor)),
          ),
          GestureDetector(
            onTap: () {
              microphoneCtrl.speakEnglishAccent(answer);
            },
            child: SvgPicture.asset(
              '$imgUrl$speakerYellowImg',
            ),
          ),
        ],
      ),
    );
  }
}
