import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../../Config/app_config.dart';
import '../../Controller/CameraController/camera_speech_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';
import '../../Utils/image_urls.dart';
import '../../Utils/utils.dart';

class CameraSpeech extends StatefulWidget {
  final bool isCollectionPositive;
  const CameraSpeech({
    super.key,
    this.isCollectionPositive = true,
  });

  @override
  State<CameraSpeech> createState() => _CameraSpeechState();
}

class _CameraSpeechState extends State<CameraSpeech>
    with SingleTickerProviderStateMixin {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;

  // Future<void> _speak(String text) async {
  //   await _flutterTts.speak(text);
  // }

  CameraSpeechController cameraSpeechController =
      Get.find<CameraSpeechController>();

  // final RecorderController _recorderController = RecorderController();
  // String _textToSpeak = "Hello, this is a text-to-speech conversion demo.";
  late AnimationController _animationController;
  @override
  void initState() {
    // fetchUserData();
    cameraSpeechController.wordsSpoken.clear();
    cameraSpeechController.isResult = false;
    cameraSpeechController.initSpeech();
    cameraSpeechController.fetchAndDisplayData(
        isCollectionPositive: widget.isCollectionPositive);
    _flutterTts.setStartHandler(() {
      setState(() => _isSpeaking = true);
    });

    _flutterTts.setCompletionHandler(() {
      setState(() => _isSpeaking = false);
    });

    _flutterTts.setErrorHandler((error) {
      setState(() => _isSpeaking = false);
    });

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    // Configure TTS handlers
    _flutterTts.setStartHandler(() {
      setState(() => _isSpeaking = true);
      _animationController.repeat(reverse: true);
    });

    _flutterTts.setCompletionHandler(() {
      setState(() => _isSpeaking = false);
      _animationController.stop();
    });

    _flutterTts.setErrorHandler((error) {
      setState(() => _isSpeaking = false);
      _animationController.stop();
    });
    super.initState();
  }

  Future<void> _speakText() async {
    if (_isSpeaking) {
      await _flutterTts.stop();
    } else {
      await _flutterTts.speak(cameraSpeechController.wordsSpoken.text);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppStyles().customAppBar(),
      body: GetBuilder<CameraSpeechController>(
          builder: (CameraSpeechController cameraCtrl) {
        return Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                padding: EdgeInsets.only(
                  top: SizesDimensions.height(3),
                  // horizontal: SizesDimensions.width(5),
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizesDimensions.width(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                cameraCtrl.firebaseImageAnswer = null;
                                cameraCtrl.firebaseImageUrl = null;
                                cameraCtrl.isResult = false;
                                cameraCtrl.isRecordPressed = false;
                                Get.back();
                              },
                              child: const Icon(Icons.arrow_back)),
                          size50w,
                          size50w,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customText(
                                text: 'Describe an Image',
                                textStyle: regular18NavyBlue.copyWith(
                                  fontSize: 22,
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
                    ),
                    // AppCustomButton(
                    //   title: customText(text: 'Uplaod data'),
                    //   onTap: () {
                    //     cameraCtrl.uploadSampleData();
                    //   },
                    // ),
                    size20h,
                    if (cameraCtrl.firebaseImageUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.radiusDoubleExtraLarge),
                        child: CachedNetworkImage(
                          width: SizesDimensions.width(90),
                          height: SizesDimensions.height(25.0),
                          imageUrl: '${cameraCtrl.firebaseImageUrl}',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => progressIndicator(),
                          errorWidget: (context, url, error) =>
                              progressIndicator(),
                        ),
                      ),
                    size30h,
                    customText(
                      text:
                          'Describe what you see and try to give\nyour opinion',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      textStyle: regular18NavyBlue.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    size40h,
                    if (cameraCtrl.firebaseImageAnswer == null)
                      progressIndicator()
                    else
                      Expanded(
                        child: Container(
                          // height: SizesDimensions.height(35),
                          width: SizesDimensions.width(100),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                    Dimensions.radiusDoubleExtraLarge),
                                topRight: Radius.circular(
                                    Dimensions.radiusDoubleExtraLarge)),
                            color: kDarkYellow,
                          ),
                          child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // _audioFile == null
                                  //     ? const Text('No audio selected')
                                  //     : Text('Audio selected: ${_audioFile!.path}'),
                                  //
                                  size40h,
                                  customText(
                                      text:
                                          'Listen and practice a model answer',
                                      textStyle: bold18NavyBlue.copyWith(
                                        fontSize: 16,
                                      ),
                                      maxLines: 10),
                                  size30h,
                                  customText(
                                    text: '${cameraCtrl.firebaseImageAnswer}',
                                    textStyle: regular18NavyBlue,
                                    textAlign: TextAlign.center,
                                    maxLines: 50,
                                  ),
                                  size30h,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  SizesDimensions.height(1),
                                              horizontal:
                                                  SizesDimensions.width(5)),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: const Color(0xFFFDE583)),
                                          child: Row(children: [
                                            GestureDetector(
                                              onTap: () async {
                                                _speakText();
                                                // if (cameraCtrl
                                                //     .wordsSpoken.text.isEmpty) {
                                                //   showToast('Record First');
                                                // } else {
                                                //   // await Get.find<
                                                //   //         MicrophoneController>()
                                                //   //     .speak(cameraCtrl
                                                //   //         .wordsSpoken.text);
                                                //   _speak(cameraCtrl
                                                //       .wordsSpoken.text);
                                                // }
                                              },
                                              child: Container(
                                                  width:
                                                      SizesDimensions.width(10),
                                                  height:
                                                      SizesDimensions.height(5),
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Color(
                                                              0xFFE8C865)),
                                                  child: Icon(
                                                    Icons.play_arrow,
                                                    size: 30,
                                                    color: kWhite,
                                                  )),
                                            ),
                                            size40w,
                                            _isSpeaking
                                                ? SizedBox(
                                                    width: 80,
                                                    height: 25,
                                                    child: AnimatedBuilder(
                                                      animation:
                                                          _animationController,
                                                      builder:
                                                          (context, child) {
                                                        return Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children:
                                                              List.generate(10,
                                                                  (index) {
                                                            // Calculate the height dynamically for each bar
                                                            double height = 10 +
                                                                (_animationController
                                                                        .value *
                                                                    40) -
                                                                (index * 3);
                                                            height = height.clamp(
                                                                2.0,
                                                                double
                                                                    .infinity); // Ensure minimum height of 2.0

                                                            return Container(
                                                              width:
                                                                  2, // Fixed width for each bar
                                                              height: height,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .black, // Bar color
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2), // Rounded edges for better design
                                                              ),
                                                            );
                                                          }),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : SvgPicture.asset(
                                                    '$imgUrl$waveformImg'),
                                            size60w,
                                            const Icon(Icons.volume_up)
                                          ])),
                                    ],
                                  ),
                                  size40h,
                                  customText(
                                    text: 'Record',
                                    textStyle: bold18NavyBlue,
                                    maxLines: 1,
                                  ),
                                  size20h,
                                  GestureDetector(
                                      onTap: (cameraCtrl.isRecordPressed ==
                                              false)
                                          ? () {
                                              cameraCtrl.isRecordPressed = true;
                                              cameraCtrl.startListening();
                                              cameraCtrl.update();
                                            }
                                          : () {
                                              cameraCtrl.stopListening();
                                              cameraCtrl
                                                  .matchSpokenAndAnswerText();
                                            },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        width: SizesDimensions.width(20),
                                        height: SizesDimensions.height(8),
                                        decoration: BoxDecoration(
                                            color: kRedFF624D,
                                            shape: BoxShape.circle),
                                        child: SvgPicture.asset(
                                            (cameraCtrl.isRecordPressed ==
                                                    false)
                                                ? '$imgUrl$whiteMicSpeechImg'
                                                : '$imgUrl$pauseButtonImg'),
                                      )),
                                  size40h,
                                ],
                              )),
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
