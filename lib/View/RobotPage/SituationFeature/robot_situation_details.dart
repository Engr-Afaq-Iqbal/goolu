import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Components/app_custom_button.dart';
import 'package:goolu/Utils/utils.dart';
import 'package:goolu/View/RobotPage/SituationFeature/robot_role_selection_page.dart';

import '../../../Config/app_config.dart';
import '../../../Controller/RobotController/robot_controller.dart';
import '../../../Theme/colors.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';
import '../../../Utils/image_urls.dart';

class RobotSituationDetails extends StatefulWidget {
  final String? situationName;
  final String? title1;
  final String? title2;
  const RobotSituationDetails({
    super.key,
    this.situationName,
    this.title1,
    this.title2,
  });

  @override
  State<RobotSituationDetails> createState() => _RobotSituationDetailsState();
}

class _RobotSituationDetailsState extends State<RobotSituationDetails> {
  RobotController robotCtrl = Get.find<RobotController>();

  @override
  void initState() {
    fetchTheData();
    // TODO: implement initState
    robotCtrl.initSpeech();
    super.initState();
  }

  fetchTheData() async {
    robotCtrl.situationModel = null;
    await robotCtrl.fetchSituation(situation: '${widget.situationName}');
  }

  @override
  void dispose() {
    robotCtrl.resetData();
    super.dispose();
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
                                    text:
                                        '${widget.situationName?.toUpperCase()}',
                                    textStyle: regular18NavyBlue.copyWith(
                                      fontSize: 14,
                                      color: kWhite,
                                    ),
                                  ),
                                ),
                                size50h,
                                if (robotCtrl.situationModel != null)
                                  Row(
                                    children: [
                                      customText(
                                        text: 'Listen the Audio',
                                        maxLines: 2,
                                        textStyle: bold18NavyBlue.copyWith(
                                          fontSize: 16,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      size30w,
                                      Obx(() {
                                        return GestureDetector(
                                          onTap: () {
                                            robotCtrl.isSpeaking.value
                                                ? robotCtrl.stopSpeaking()
                                                : robotCtrl.speak(
                                                    '${robotCtrl.situationModel?.dialogue}');
                                          },
                                          child: SvgPicture.asset(
                                            '$imgUrl${robotCtrl.isSpeaking.value ? pauseImg : speakerYellowImg}',
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                size20h,
                                if (robotCtrl.situationModel == null)
                                  progressIndicator()
                                else
                                  customText(
                                    text:
                                        '${robotCtrl.situationModel?.dialogue}',
                                    maxLines: 100,
                                    textStyle: bold18NavyBlue.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: secDarkBlueNavyColor,
                                    ),
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
                              // Get.to(() => const RobotConversationScreen());
                              Get.to(() => RobotRoleSelectionPage(
                                    title1: widget.title1,
                                    title2: widget.title2,
                                  ));
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
