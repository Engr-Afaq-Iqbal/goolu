import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/MicrophoneController/microphone_controller.dart';
import 'package:goolu/Model/language_for_api.dart';

import '../../Config/app_config.dart';
import '../../Model/language_for_api_2.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';
import '../../Utils/image_urls.dart';

class MicrophonePage extends StatefulWidget {
  const MicrophonePage({super.key});

  @override
  State<MicrophonePage> createState() => _MicrophonePageState();
}

class _MicrophonePageState extends State<MicrophonePage> {
  MicrophoneController microphoneController = Get.find<MicrophoneController>();

  @override
  void initState() {
    super.initState();
    microphoneController.recorder = FlutterSoundRecorder();
    microphoneController.initializeRecorder();
    microphoneController.flutterTts.setCompletionHandler(() {
      debugPrint("Speech completed");
    });
    microphoneController.flutterTts.setErrorHandler((msg) {
      debugPrint("Error: $msg");
    });
  }

  @override
  void dispose() {
    microphoneController.recorder!.closeRecorder();
    microphoneController.flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppStyles().customAppBar(),
      body: GetBuilder<MicrophoneController>(
          builder: (MicrophoneController microphoneCtrl) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    size20h,
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: kWhite,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(
                              Dimensions.radiusDoubleExtraLarge)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              customButton: customText(
                                text: microphoneCtrl.selectedLanguage,
                                textStyle: regular18NavyBlue.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              items: [
                                ...LanguageMenuItemsForApi.firstItems.map(
                                  (item) =>
                                      DropdownMenuItem<LanguageMenuItemForApi>(
                                    value: item,
                                    child:
                                        LanguageMenuItemsForApi.buildItem(item),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                LanguageMenuItemsForApi.onChanged(
                                    context, value!);
                              },
                              dropdownStyleData: DropdownStyleData(
                                width: SizesDimensions.width(30.0),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radiusSmall),
                                  color: kFFFFFF,
                                ),
                                offset: const Offset(0, 8),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.only(
                                    left: Dimensions.radiusLarge,
                                    right: Dimensions.radiusLarge),
                              ),
                            ),
                          ),
                          SvgPicture.asset('$imgUrl$doubleArrowImg'),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              customButton: customText(
                                text: microphoneCtrl.selectedLanguage2,
                                textStyle: regular18NavyBlue.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              items: [
                                ...LanguageMenuItemsForApi2.firstItems.map(
                                  (item) =>
                                      DropdownMenuItem<LanguageMenuItemForApi2>(
                                    value: item,
                                    child: LanguageMenuItemsForApi2.buildItem(
                                        item),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                LanguageMenuItemsForApi2.onChanged(
                                    context, value!);
                              },
                              dropdownStyleData: DropdownStyleData(
                                width: SizesDimensions.width(30.0),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radiusSmall),
                                  color: kFFFFFF,
                                ),
                                offset: const Offset(0, 8),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.only(
                                    left: Dimensions.radiusLarge,
                                    right: Dimensions.radiusLarge),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    size30h,
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: kWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusLarge),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              customText(
                                text: microphoneCtrl.selectedLanguage,
                                textStyle: regular18NavyBlue.copyWith(
                                  fontSize: 18,
                                  color: primaryBlueGradientDarkColor,
                                ),
                              ),
                              size20w,
                              SvgPicture.asset(
                                '$imgUrl$speakerImg',
                                colorFilter: ColorFilter.mode(
                                  primaryBlueGradientDarkColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                          size20h,
                          customText(
                            text: 'Type or speak',
                            textStyle: regular14DarkGrey.copyWith(
                              color: kC8C8C8,
                              fontSize: 16,
                            ),
                          ),
                          size50h,
                          GestureDetector(
                            onTap: microphoneCtrl.isRecording
                                ? microphoneCtrl.stopRecording
                                : microphoneCtrl.startRecording,
                            child: SvgPicture.asset(
                              '$imgUrl$roundMicImage',
                              height: SizesDimensions.height(6),
                              width: SizesDimensions.width(6),
                              colorFilter: ColorFilter.mode(
                                primaryBlueGradientDarkColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    size30h,
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: kWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusLarge),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              customText(
                                text: microphoneController
                                        .speechToSpeechModel?.translatedText ??
                                    microphoneCtrl.selectedLanguage2,
                                textStyle: regular18NavyBlue.copyWith(
                                  fontSize: 18,
                                  color: primaryBlueGradientDarkColor,
                                ),
                                maxLines: 10,
                              ),
                              size20w,
                              GestureDetector(
                                onTap: () async {
                                  final text = microphoneController
                                          .speechToSpeechModel
                                          ?.translatedText ??
                                      'noTextAvailable'.tr;
                                  await microphoneCtrl.speak(text);
                                },
                                child: SvgPicture.asset(
                                  '$imgUrl$speakerImg',
                                  colorFilter: ColorFilter.mode(
                                    primaryBlueGradientDarkColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          size20h,
                          customText(
                            text: 'What are you doing?',
                            textStyle: regular14DarkGrey.copyWith(
                              color: kC8C8C8,
                              fontSize: 16,
                            ),
                          ),
                          size50h,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset('$imgUrl$copyImg'),
                              size50w,
                              SvgPicture.asset('$imgUrl$shareImg'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
