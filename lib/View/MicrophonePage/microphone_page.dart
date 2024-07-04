import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/MicrophoneController/microphone_controller.dart';
import 'package:goolu/Utils/utils.dart';

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
      logger.i("Speech completed");
    });
    microphoneController.flutterTts.setErrorHandler((msg) {
      logger.e("Error: $msg");
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
            size20h,
            microphoneCtrl.isRecording
                ? customText(text: 'Recording...', textStyle: bold16NavyBlue)
                : customText(
                    text: 'Press button to start recording',
                    textStyle: bold16NavyBlue),
            size20h,
            Center(
              child: Container(
                height: SizesDimensions.height(30),
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
                    ElevatedButton(
                      onPressed: microphoneCtrl.isRecording
                          ? microphoneCtrl.stopRecording
                          : microphoneCtrl.startRecording,
                      child: Text(microphoneCtrl.isRecording
                          ? 'Stop Recording'
                          : 'Start Recording'),
                    ),
                    size20h,
                    Row(
                      children: [
                        customText(
                            text: 'Note - book (n)', textStyle: bold16White),
                        size20w,
                        // GestureDetector(
                        //   onTap: microphoneCtrl.pickAudio,
                        //   child: Container(
                        //     width: 30.0,
                        //     height: 30.0,
                        //     padding: const EdgeInsets.all(5),
                        //     decoration: BoxDecoration(
                        //       color: kYellowffde59,
                        //       shape: BoxShape.circle,
                        //     ),
                        //     child: SvgPicture.asset(
                        //       '$imgUrl$playImage',
                        //       colorFilter: ColorFilter.mode(
                        //         primaryBlueColor,
                        //         BlendMode.srcIn,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    size10h,
                    customText(
                        text: '(with form, sound button, definition)',
                        textStyle: regular12White,
                        maxLines: 3,
                        textAlign: TextAlign.center),
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
