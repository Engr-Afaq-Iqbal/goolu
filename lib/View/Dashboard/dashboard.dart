import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:goolu/Components/app_custom_button.dart';
import 'package:goolu/Utils/font_styles.dart';
import 'package:goolu/Utils/utils.dart';

import '../../Config/app_config.dart';
import '../../Controller/DashboardController/dashboard_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/image_urls.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FlutterTts flutterTts = FlutterTts();
  DashboardController dashboardController = Get.find<DashboardController>();
  @override
  void initState() {
    super.initState();
    flutterTts.setCompletionHandler(() {
      debugPrint("Speech completed");
    });
    flutterTts.setErrorHandler((msg) {
      debugPrint("Error: $msg");
    });

    uploadData();

    dashboardController.fetchDailyTasks();
  }

  uploadData() async {
    // await dashboardController.uploadWordsToFirestore();
    await dashboardController.fetchDailyWord();
  }

  Future<void> _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(
      '${dashboardController.word}',
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppStyles().customAppBar(),
      resizeToAvoidBottomInset: false,
      body: GetBuilder<DashboardController>(
          builder: (DashboardController dashboardCtrl) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                padding: EdgeInsets.only(
                  top: SizesDimensions.height(1.5),
                  left: SizesDimensions.width(5),
                  right: SizesDimensions.width(5),
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft:
                          Radius.circular(Dimensions.radiusDoubleExtraLarge),
                      topRight:
                          Radius.circular(Dimensions.radiusDoubleExtraLarge)),
                  color: kLightYellow.withOpacity(0.3),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radiusDoubleExtraLarge,
                        ),
                        child: Container(
                          height: SizesDimensions.height(63),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(
                                Dimensions.radiusDoubleExtraLarge),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  // height: SizesDimensions.height(20),
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
                                        Dimensions.radiusDoubleExtraLarge),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      customText(
                                          text: 'wordOfTheDay'.tr,
                                          textStyle: bold16White.copyWith(
                                            fontSize: 18,
                                          )),
                                      size20h,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  customText(
                                                      text:
                                                          '${dashboardCtrl.word}',
                                                      textStyle: regular14White
                                                          .copyWith(
                                                        fontSize: 18,
                                                      )),
                                                  size30w,
                                                  GestureDetector(
                                                    onTap: _speak,
                                                    child: SvgPicture.asset(
                                                      '$imgUrl$speakerYellowImg',
                                                      color: kWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              size10h,
                                              SizedBox(
                                                width: 180,
                                                child: customText(
                                                    text:
                                                        '${dashboardCtrl.definition}',
                                                    maxLines: 5,
                                                    textStyle:
                                                        regular14White.copyWith(
                                                      fontSize: 10,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SvgPicture.asset(
                                              '$imgUrl$dashBoardStudyImg'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // if (robotCtrl.showAnswers == true)
                                Column(
                                  children: [
                                    size20h,
                                    customText(
                                      text: 'Sentence Building',
                                      textStyle: bold18NavyBlue.copyWith(
                                        fontSize: 18,
                                        color: k003366,
                                      ),
                                    ),
                                    size10h,
                                    SizedBox(
                                      width: SizesDimensions.width(85),
                                      child: customText(
                                        text:
                                            'Rearrange the words into the blanks to build the sentence.',
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        textStyle: regular12NavyBlue.copyWith(
                                          fontSize: 12,
                                          color: k003366,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (dashboardCtrl.showResult == 0)
                                  Container(
                                    height: 220,
                                    margin: const EdgeInsets.all(20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                      color: kD6ECF0,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0,
                                          blurRadius: 1,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusDoubleExtraLarge),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Display the selected words in a row with lines beneath
                                        selectedWord(),
                                        size10h,
                                        // Word selection containers
                                        Wrap(
                                          spacing: 15,
                                          runSpacing: 5,
                                          children: List.generate(
                                              dashboardCtrl.words.length,
                                              (index) {
                                            return GestureDetector(
                                              onTap: () => dashboardCtrl
                                                  .toggleWordSelection(index),
                                              child: wordBox(
                                                word:
                                                    dashboardCtrl.words[index],
                                                isSelected: dashboardCtrl
                                                    .isSelected[index],
                                              ),
                                            );
                                          }),
                                        ),
                                        size10h,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AppCustomButton(
                                              title: customText(
                                                  text: 'Check',
                                                  textStyle: bold16White),
                                              onTap: dashboardCtrl
                                                          .selectedWordList
                                                          .length !=
                                                      dashboardCtrl.words.length
                                                  ? null
                                                  : () {
                                                      dashboardCtrl
                                                          .checkLists();
                                                      showProgress();
                                                      logger.i(dashboardCtrl
                                                          .selectedWordList);
                                                      logger.i(
                                                          dashboardCtrl.words);
                                                    },
                                              horizontalPadding: 25,
                                              borderRadius: Dimensions
                                                  .radiusSingleExtraLarge,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                if (dashboardCtrl.showResult == 1)
                                  Container(
                                    height: 200,
                                    width: SizesDimensions.width(100),
                                    margin: const EdgeInsets.all(20),
                                    // padding: const EdgeInsets.symmetric(
                                    //     horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                      color: kD6ECF0,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0,
                                          blurRadius: 1,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusDoubleExtraLarge),
                                    ),
                                    child: Stack(
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Positioned(
                                          left: 10,
                                          bottom: 0,
                                          right: 10,
                                          top: 0,
                                          child: SvgPicture.asset(
                                              '$imgUrl$celebrationImg'),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 30,
                                          child: SvgPicture.asset(
                                              '$imgUrl$personCelebrationImg'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              customText(
                                                text: 'Well done',
                                                textStyle:
                                                    bold16NavyBlue.copyWith(
                                                  fontSize: 16,
                                                  color: kLightBlue32A3B8,
                                                ),
                                              ),
                                              customText(
                                                text: 'You arranged it right',
                                                textStyle:
                                                    regular16NavyBlue.copyWith(
                                                  fontSize: 14,
                                                  color: kLightBlue32A3B8,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                if (dashboardCtrl.showResult == 2)
                                  Container(
                                    height: 200,
                                    width: SizesDimensions.width(100),
                                    margin: const EdgeInsets.all(20),
                                    // padding: const EdgeInsets.symmetric(
                                    //     horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                      color: kD6ECF0,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0,
                                          blurRadius: 1,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusDoubleExtraLarge),
                                    ),
                                    child: Stack(
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: SvgPicture.asset(
                                              '$imgUrl$failedImg'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              customText(
                                                text: 'Don’t lose hope',
                                                textStyle:
                                                    bold16NavyBlue.copyWith(
                                                  fontSize: 16,
                                                  color: kLightBlue32A3B8,
                                                ),
                                              ),
                                              size10h,
                                              GestureDetector(
                                                onTap: () {
                                                  dashboardCtrl.showResult = 0;
                                                  dashboardCtrl
                                                      .resetSelection();
                                                  dashboardCtrl.update();
                                                },
                                                child: Row(
                                                  children: [
                                                    customText(
                                                      text: 'Try Again',
                                                      textStyle:
                                                          regular16NavyBlue
                                                              .copyWith(
                                                        fontSize: 14,
                                                        color: kRedFF5757,
                                                      ),
                                                    ),
                                                    size20w,
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                          color: kRedFF5757,
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .radiusSmall)),
                                                      child: SvgPicture.asset(
                                                          '$imgUrl$repeatImg'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              size40h,
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 16, child: SvgPicture.asset('$imgUrl$ladyImg')),
                    Positioned(
                      left: 120,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                text: 'Daily Tasks',
                                textStyle: bold14NavyBlue.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              size10h,
                              tickWithText(
                                title: 'Sentence Building',
                                isGrey: !dashboardCtrl.isSentenceBuilding,
                              ),
                              tickWithText(
                                title: 'Situation Practice',
                                isGrey: !dashboardCtrl.isSituationPractice,
                              ),
                              tickWithText(
                                title: 'Image Description',
                                isGrey: !dashboardCtrl.isImageDescription,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // size20h,
                  ],
                ),
              ),
            ),
            // box(txt: 'need'),
          ],
        );
      }),
    );
  }

  Widget selectedWord() {
    return Wrap(
      spacing: 10,
      children: List.generate(
        dashboardController.words.length,
        (index) {
          return Column(
            children: [
              customText(
                  text: dashboardController.selectedWordList.length > index
                      ? dashboardController.selectedWordList[index]
                      : '',
                  textStyle: regular12NavyBlue.copyWith(
                    color: secDarkBlueNavyColor,
                    fontSize: 12,
                  )),
              AppStyles.dividerLine(
                width: 40,
                // height: 5,
                color: secDarkBlueNavyColor,
              ),
            ],
          );
        },
      ),
    );
  }

  // WordBox widget to display each word in the container
  Widget wordBox({String? word, bool isSelected = false, int? position}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.yellow.withOpacity(0.7),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ]
            : [],
        color: Colors.white,
        border: Border.all(
          color: isSelected ? Colors.yellow : Colors.white,
        ),
      ),
      child: customText(
          text: word ?? '',
          textStyle: regular12NavyBlue.copyWith(
              fontSize: 12,
              color: isSelected ? secDarkBlueNavyColor : secDarkGreyIconColor)),
    );
  }

  Container box({String? txt}) {
    return Container(
      // height: SizesDimensions.height(20),
      // width: SizesDimensions.width(50),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: primaryColor,
      ),
      child: Center(
        child: customText(
            text: '$txt',
            textStyle: regular14White,
            maxLines: 3,
            textAlign: TextAlign.center),
      ),
    );
  }

  Row tickWithText({String? title, bool isGrey = false}) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: isGrey == true
                ? k7F7F7F.withOpacity(0.3)
                : kDarkYellow, // Background color
            shape: BoxShape.circle, // Makes the container circular
          ),
          child: Center(
            child: Icon(
              Icons.check,
              color: kWhite,
              size: 9,
            ),
          ),
        ),
        size10w,
        customText(
          text: '$title',
          textStyle: regular14NavyBlue.copyWith(fontSize: 12),
        )
      ],
    );
  }
}
