import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:goolu/Components/app_custom_button.dart';
import 'package:goolu/Utils/font_styles.dart';

import '../../Config/app_config.dart';
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
  @override
  void initState() {
    super.initState();
    flutterTts.setCompletionHandler(() {
      debugPrint("Speech completed");
    });
    flutterTts.setErrorHandler((msg) {
      debugPrint("Error: $msg");
    });
  }

  Future<void> _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak("note book");
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
      body: Column(
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
                    topLeft: Radius.circular(Dimensions.radiusDoubleExtraLarge),
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
                          color: primaryBlueColor,
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
                                                    text: 'Note-book (n)',
                                                    textStyle:
                                                        regular14White.copyWith(
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
                                              width: SizesDimensions.width(45),
                                              child: customText(
                                                  text:
                                                      'withFormSoundButtonDefinition'
                                                          .tr,
                                                  textStyle: regular12White
                                                      .copyWith(fontSize: 12),
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start),
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
                              Container(
                                height: 200,
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
                                      children:
                                          List.generate(words.length, (index) {
                                        return GestureDetector(
                                          onTap: () =>
                                              toggleWordSelection(index),
                                          child: wordBox(
                                            word: words[index],
                                            isSelected: isSelected[index],
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
                                          onTap: null,
                                          horizontalPadding: 25,
                                          borderRadius:
                                              Dimensions.radiusSingleExtraLarge,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
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
                            tickWithText(title: 'Sentence Building'),
                            tickWithText(title: 'Situation Practice'),
                            tickWithText(
                              title: 'Image Description',
                              isGrey: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  size20h,
                ],
              ),
            ),
          ),
          // box(txt: 'need'),
        ],
      ),
    );
  }

  ///New logic
  // List of words
  List<String> words = ['I', 'am', 'ready', 'to', 'write'];

  // Track selected words in the correct order
  List<String> selectedWordList = [];

  // Track whether the word is selected or not
  List<bool> isSelected = List.generate(5, (index) => false);

  // Update the selected word when tapping on the container
  void toggleWordSelection(int index) {
    setState(() {
      if (isSelected[index]) {
        // If the word is already selected, remove it from the list
        selectedWordList.remove(words[index]);
        isSelected[index] = false;
      } else {
        // If the word is not selected, add it to the end of the list
        selectedWordList.add(words[index]);
        isSelected[index] = true;
      }
    });
  }

  // Function to build the selected word row with divider lines
  // Function to build the selected word row

  // Function to build the selected word row with dividers always showing
  Widget selectedWord() {
    return Wrap(
      spacing: 10,
      children: List.generate(
        words.length,
        (index) {
          return Column(
            children: [
              customText(
                  text: selectedWordList.length > index
                      ? selectedWordList[index]
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

  // if (position != null)
  // Padding(
  // padding: const EdgeInsets.only(left: 5),
  // child: Text(
  // '($position)', // Show the position number
  // style: TextStyle(
  // fontSize: 12,
  // color: Colors.red, // Adjust color/style of position number
  // ),
  // ),
  // ),

  ///Ends

  // wordBox({
  //   String? word,
  //   bool isSelected = true,
  // }) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(
  //       horizontal: 12,
  //       vertical: 5,
  //     ),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(
  //           Dimensions.radiusExtraLarge,
  //         ),
  //         boxShadow: isSelected == true
  //             ? [
  //                 BoxShadow(
  //                   color: kLightYellow.withOpacity(1),
  //                   spreadRadius: 1,
  //                   blurRadius: 2,
  //                   offset: const Offset(0, 1),
  //                 ),
  //               ]
  //             : [],
  //         color: kWhite,
  //         border: Border.all(
  //           color: isSelected == true ? kLightYellow : kWhite,
  //         )),
  //     child: customText(
  //       text: '$word',
  //       textStyle: regular12NavyBlue.copyWith(
  //         fontSize: 12,
  //       ),
  //     ),
  //   );
  // }

  Container box({String? txt}) {
    return Container(
      // height: SizesDimensions.height(20),
      // width: SizesDimensions.width(50),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: primaryBlueColor,
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

  // List<String> selectedWordList = ['', '', '', '', ''];
  // Row selectedWord() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       Column(
  //         children: [
  //           customText(
  //             text: selectedWordList[0] ?? '',
  //             textStyle: regular14NavyBlue.copyWith(
  //               fontSize: 12,
  //             ),
  //           ),
  //           AppStyles.dividerLine(
  //             width: 40,
  //             // height: 5,
  //             color: secDarkBlueNavyColor,
  //           ),
  //         ],
  //       ),
  //       Column(
  //         children: [
  //           customText(
  //             text: selectedWordList[1] ?? '',
  //             textStyle: regular14NavyBlue.copyWith(
  //               fontSize: 12,
  //             ),
  //           ),
  //           AppStyles.dividerLine(
  //             width: 40,
  //             // height: 5,
  //             color: secDarkBlueNavyColor,
  //           ),
  //         ],
  //       ),
  //       Column(
  //         children: [
  //           customText(
  //             text: selectedWordList[2] ?? '',
  //             textStyle: regular14NavyBlue.copyWith(
  //               fontSize: 12,
  //             ),
  //           ),
  //           AppStyles.dividerLine(
  //             width: 40,
  //             // height: 5,
  //             color: secDarkBlueNavyColor,
  //           ),
  //         ],
  //       ),
  //       Column(
  //         children: [
  //           customText(
  //             text: selectedWordList[3] ?? '',
  //             textStyle: regular14NavyBlue.copyWith(
  //               fontSize: 12,
  //             ),
  //           ),
  //           AppStyles.dividerLine(
  //             width: 40,
  //             // height: 5,
  //             color: secDarkBlueNavyColor,
  //           ),
  //         ],
  //       ),
  //       Column(
  //         children: [
  //           customText(
  //             text: selectedWordList[4] ?? '',
  //             textStyle: regular14NavyBlue.copyWith(
  //               fontSize: 12,
  //             ),
  //           ),
  //           AppStyles.dividerLine(
  //             width: 40,
  //             // height: 5,
  //             color: secDarkBlueNavyColor,
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
