import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/RobotController/robot_controller.dart';
import 'package:goolu/Utils/dimensions.dart';
import 'package:goolu/Utils/font_styles.dart';
import 'package:goolu/View/RobotPage/TopicFeature/widgets/robot_topic_widget.dart';

import '../../../Components/app_form_field.dart';
import '../../../Config/app_config.dart';
import '../../../Theme/colors.dart';
import '../../../Utils/image_urls.dart';
import '../../../Utils/utils.dart';

class RobotTopic extends StatefulWidget {
  const RobotTopic({super.key});

  @override
  State<RobotTopic> createState() => _RobotTopicState();
}

class _RobotTopicState extends State<RobotTopic> {
  RobotController robotCtrl = Get.find<RobotController>();
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
    robotCtrl.topicCtrl.clear();
    robotCtrl.initSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              robotCtrl.topicCtrl.clear();
                              robotCtrl.update();
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back)),
                        size50w,
                        size50w,
                        size50w,
                        size50w,
                        size50w,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            customText(
                              text: 'Topic',
                              textStyle: regular18NavyBlue.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            size20h,
                            AppStyles.dividerLine(
                              color: kDarkYellow,
                              width: SizesDimensions.width(30),
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
                                      text: 'Topic',
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
                                            controller: robotCtrl.topicCtrl,
                                            // labelText: 'Question',
                                            hintText: 'Text here',
                                            keyboardType: TextInputType.text,
                                            validator: (String? v) {
                                              if (v!.isEmpty) {
                                                return 'Topic Required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            if (robotCtrl
                                                .topicCtrl.text.isNotEmpty) {
                                              robotCtrl.isSend = true;

                                              robotCtrl
                                                  .generateQuestionAndAnswersFunction();
                                              robotCtrl.update();
                                            } else {
                                              showToast(
                                                  'Please enter your topic');
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radiusLarge),
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
                                      text: 'Questions / Answers',
                                      textStyle: bold18NavyBlue.copyWith(
                                        fontSize: 16,
                                        color: k003366,
                                      ),
                                    ),
                                    size10h,
                                    RobotTopicWidget(
                                      answer:
                                          '${robotCtrl.questionAnswerModel?.answer11}',
                                      questions:
                                          '${robotCtrl.questionAnswerModel?.question1}',
                                    ),
                                    RobotTopicWidget(
                                      answer:
                                          '${robotCtrl.questionAnswerModel?.answer21}',
                                      questions:
                                          '${robotCtrl.questionAnswerModel?.question2}',
                                    ),
                                    RobotTopicWidget(
                                      answer:
                                          '${robotCtrl.questionAnswerModel?.answer31}',
                                      questions:
                                          '${robotCtrl.questionAnswerModel?.question3}',
                                    ),
                                    RobotTopicWidget(
                                      answer:
                                          '${robotCtrl.questionAnswerModel?.answer41}',
                                      questions:
                                          '${robotCtrl.questionAnswerModel?.question4}',
                                    ),
                                    RobotTopicWidget(
                                      answer:
                                          '${robotCtrl.questionAnswerModel?.answer51}',
                                      questions:
                                          '${robotCtrl.questionAnswerModel?.question5}',
                                    ),
                                    RobotTopicWidget(
                                      answer:
                                          '${robotCtrl.questionAnswerModel?.answer61}',
                                      questions:
                                          '${robotCtrl.questionAnswerModel?.question6}',
                                    ),
                                    RobotTopicWidget(
                                      answer:
                                          '${robotCtrl.questionAnswerModel?.answer71}',
                                      questions:
                                          '${robotCtrl.questionAnswerModel?.question7}',
                                    ),
                                    RobotTopicWidget(
                                      answer:
                                          '${robotCtrl.questionAnswerModel?.answer81}',
                                      questions:
                                          '${robotCtrl.questionAnswerModel?.question8}',
                                    ),
                                    RobotTopicWidget(
                                      answer:
                                          '${robotCtrl.questionAnswerModel?.answer91}',
                                      questions:
                                          '${robotCtrl.questionAnswerModel?.question9}',
                                    ),
                                    RobotTopicWidget(
                                      answer:
                                          '${robotCtrl.questionAnswerModel?.answer101}',
                                      questions:
                                          '${robotCtrl.questionAnswerModel?.question10}',
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

            // if (robotCtrl.questionAnswerModel != null)
            // Expanded(
            //   child: SizedBox(
            //     height: SizesDimensions.height(40),
            //     child: ListView.builder(
            //       itemCount: 10,
            //       itemBuilder: (context, index) {
            //         return RobotFeature3Box(
            //           index: index,
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        );
      }),
    );
  }
}
