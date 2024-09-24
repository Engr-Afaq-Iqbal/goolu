import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/RobotController/robot_controller.dart';

import '../Theme/colors.dart';
import '../Utils/dimensions.dart';
import '../Utils/font_styles.dart';

class AppRadioButtonWithTitleQuest extends StatefulWidget {
  final String? title;
  final String? radio1txt;
  final String? radio2txt;
  final String? radio3txt;
  final String? radio4txt;
  final String? radio5txt;
  final int index;
  const AppRadioButtonWithTitleQuest({
    super.key,
    this.title,
    this.radio1txt,
    this.radio2txt,
    this.radio3txt,
    this.radio4txt,
    this.radio5txt,
    this.index = 0,
  });

  @override
  State<AppRadioButtonWithTitleQuest> createState() =>
      _AppRadioButtonWithTitleQuestState();
}

class _AppRadioButtonWithTitleQuestState
    extends State<AppRadioButtonWithTitleQuest> {
  // int questionAnswer = -1;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RobotController>(builder: (RobotController robotCtrl) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            text: '${widget.title}',
            textStyle: regular14NavyBlue,
            maxLines: 10,
          ),
          SizedBox(
            width: Get.width,
            child: Row(
              children: [
                Radio(
                  groupValue: robotCtrl.questionAnswer,
                  onChanged: (dynamic value) {
                    setState(() {
                      robotCtrl.questionAnswer = value;
                      // if (widget.index == 0) {
                      //   signUpCtrl.questionsTwoSelectedData[widget.index]
                      //       .value = 'less_than_5_million';
                      // } else if (widget.index == 1) {
                      //   signUpCtrl.questionsTwoSelectedData[widget.index]
                      //       .value = 'real_estate';
                      // } else if (widget.index == 2) {
                      //   signUpCtrl.questionsTwoSelectedData[widget.index]
                      //       .value = 'objective_protection';
                      // } else {
                      //   signUpCtrl.questionsOneSelectedData[widget.index]
                      //       .value = value.toString();
                      // }

                      robotCtrl.update();
                    });
                  },
                  activeColor: primaryBlueColor,
                  value: 0,
                ),
                SizedBox(
                  width: SizesDimensions.width(80),
                  child: customText(
                    text: widget.radio1txt ?? 'yes'.tr,
                    textStyle: regular14NavyBlue,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: Get.width,
            child: Row(
              children: [
                Radio(
                  groupValue: robotCtrl.questionAnswer,
                  onChanged: (dynamic value) {
                    setState(() {
                      robotCtrl.questionAnswer = value;
                      // if (widget.index == 0) {
                      //   signUpCtrl.questionsTwoSelectedData[widget.index]
                      //       .value = 'more_than_5_million';
                      // } else if (widget.index == 1) {
                      //   signUpCtrl.questionsTwoSelectedData[widget.index]
                      //       .value = 'private_equity';
                      // } else if (widget.index == 2) {
                      //   signUpCtrl.questionsTwoSelectedData[widget.index]
                      //       .value = 'objective_balanced';
                      // } else {
                      //   signUpCtrl.questionsOneSelectedData[widget.index]
                      //       .value = value.toString();
                      // }
                      robotCtrl.update();
                    });
                  },
                  activeColor: primaryBlueColor,
                  value: 1,
                ),
                SizedBox(
                  width: SizesDimensions.width(80),
                  child: customText(
                    text: widget.radio2txt ?? 'no'.tr,
                    textStyle: regular14NavyBlue,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
          if (widget.radio3txt != null)
            SizedBox(
              width: Get.width,
              child: Row(
                children: [
                  Radio(
                    groupValue: robotCtrl.questionAnswer,
                    onChanged: (dynamic value) {
                      setState(() {
                        robotCtrl.questionAnswer = value;
                        // if (widget.index == 5) {
                        //   signUpCtrl.questionsOneSelectedData[widget.index]
                        //       .value = 'high';
                        // } else if (widget.index == 1) {
                        //   signUpCtrl.questionsTwoSelectedData[widget.index]
                        //       .value = 'capital_market';
                        // } else if (widget.index == 2) {
                        //   signUpCtrl.questionsTwoSelectedData[widget.index]
                        //       .value = 'objective_growth';
                        // } else {
                        //   signUpCtrl.questionsOneSelectedData[widget.index]
                        //       .value = value.toString();
                        // }
                        robotCtrl.update();
                      });
                    },
                    activeColor: primaryBlueColor,
                    value: 2,
                  ),
                  SizedBox(
                    width: SizesDimensions.width(80.0),
                    child: customText(
                      text: '${widget.radio3txt}',
                      textStyle: regular14NavyBlue,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ),
          if (widget.radio4txt != null)
            SizedBox(
              width: Get.width,
              child: Row(
                children: [
                  Radio(
                    groupValue: robotCtrl.questionAnswer,
                    onChanged: (dynamic value) {
                      setState(() {
                        robotCtrl.questionAnswer = value;
                        // if (widget.index == 1) {
                        //   signUpCtrl.questionsTwoSelectedData[widget.index]
                        //       .value = 'other';
                        // } else if (widget.index == 2) {
                        //   signUpCtrl.questionsTwoSelectedData[widget.index]
                        //       .value = 'objective_income';
                        // } else {
                        //   signUpCtrl.questionsOneSelectedData[widget.index]
                        //       .value = value.toString();
                        // }
                        robotCtrl.update();
                      });
                    },
                    activeColor: primaryBlueColor,
                    value: 3,
                  ),
                  SizedBox(
                    width: SizesDimensions.width(80),
                    child: customText(
                      text: '${widget.radio4txt}',
                      textStyle: regular14NavyBlue,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ),
          if (widget.radio5txt != null)
            SizedBox(
              width: Get.width,
              child: Row(
                children: [
                  Radio(
                    groupValue: robotCtrl.questionAnswer,
                    onChanged: (dynamic value) {
                      setState(() {
                        robotCtrl.questionAnswer = value;
                        // if (widget.index == 1) {
                        //   signUpCtrl.questionsTwoSelectedData[widget.index]
                        //       .value = 'other';
                        // } else if (widget.index == 2) {
                        //   signUpCtrl.questionsTwoSelectedData[widget.index]
                        //       .value = 'objective_income';
                        // } else {
                        //   signUpCtrl.questionsOneSelectedData[widget.index]
                        //       .value = value.toString();
                        // }
                        robotCtrl.update();
                      });
                    },
                    activeColor: primaryBlueColor,
                    value: 4,
                  ),
                  SizedBox(
                    width: SizesDimensions.width(80),
                    child: customText(
                      text: '${widget.radio5txt}',
                      textStyle: regular14NavyBlue,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            )
        ],
      );
    });
  }
}
