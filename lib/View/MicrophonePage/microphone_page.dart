import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/MicrophoneController/microphone_controller.dart';

import '../../Config/app_config.dart';
import '../../Controller/AuthController/auth_controller.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          '$gooluLogoUrl$gooluImage',
          height: 40,
        ),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(4.0), // Height of the bottom line
          child: Container(
            color: kYellowffde59, // Color of the bottom line
            height: 5.0, // Thickness of the bottom line
          ),
        ),
        leading: Builder(
          builder: (context) => // Ensure Scaffold is in context
              IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Get.find<AuthController>()
                        .scaffoldKey
                        .currentState
                        ?.openDrawer();
                  }),
        ),
      ),
      body: GetBuilder<MicrophoneController>(
          builder: (MicrophoneController microphoneCtrl) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            size40h,
            microphoneCtrl.isRecording
                ? customText(text: 'Recording...', textStyle: bold16NavyBlue)
                : customText(
                    text: 'Press button to start recording',
                    textStyle: bold16NavyBlue),
            size20h,
            GestureDetector(
              onTap: microphoneCtrl.isRecording
                  ? microphoneCtrl.stopRecording
                  : microphoneCtrl.startRecording,
              child: Center(
                child: SvgPicture.asset(
                  '$imgUrl$roundMicImage',
                  height: SizesDimensions.height(12),
                  width: SizesDimensions.width(12),
                  colorFilter: ColorFilter.mode(
                    microphoneCtrl.isRecording
                        ? primaryBlueColor
                        : secDarkBlueNavyColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            size100h,
            if (microphoneController.speechToSpeechModel != null)
              Center(
                child: Container(
                  // height: SizesDimensions.height(30),
                  width: SizesDimensions.width(70),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primaryBlueColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // _audioFile == null
                      //     ? const Text('No audio selected')
                      //     : Text('Audio selected: ${_audioFile!.path}'),
                      //
                      size20h,
                      Row(
                        children: [
                          SizedBox(
                            width: SizesDimensions.width(40),
                            child: customText(
                                text:
                                    '${microphoneController.speechToSpeechModel?.translatedText}',
                                textStyle: bold16White,
                                maxLines: 10),
                          ),
                          size20w,
                          GestureDetector(
                            onTap: () async {
                              final text = microphoneController
                                      .speechToSpeechModel?.translatedText ??
                                  'No text available';
                              await microphoneCtrl.speak(text);
                            },
                            child: Container(
                              width: 30.0,
                              height: 30.0,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: kYellowffde59,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                '$imgUrl$playImage',
                                colorFilter: ColorFilter.mode(
                                  primaryBlueColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      size20h,
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
