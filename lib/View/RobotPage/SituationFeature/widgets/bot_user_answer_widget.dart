import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../Config/app_config.dart';
import '../../../../Controller/MicrophoneController/microphone_controller.dart';
import '../../../../Theme/colors.dart';
import '../../../../Utils/dimensions.dart';
import '../../../../Utils/font_styles.dart';
import '../../../../Utils/image_urls.dart';

class BotUserAnswerWidget extends StatelessWidget {
  final String? answer;
  const BotUserAnswerWidget({super.key, this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        width: Get.width,
        margin: const EdgeInsets.only(left: 30, top: 10, bottom: 5),
        decoration: BoxDecoration(
            color: kDarkYellow,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radiusExtraLarge),
                bottomLeft: Radius.circular(Dimensions.radiusExtraLarge),
                topRight: Radius.circular(Dimensions.radiusExtraLarge))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: SizesDimensions.width(60),
              child: customText(
                  text: '$answer',
                  maxLines: 5,
                  textStyle: regular14NavyBlue.copyWith(
                    fontSize: 14,
                    color: kWhite,
                  )),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                final microphoneCtrl = Get.find<MicrophoneController>();

                if (microphoneCtrl.isSpeaking) {
                  // Stop speaking if currently speaking
                  await microphoneCtrl.stopSpeaking();
                  microphoneCtrl.isSpeaking = false;
                } else {
                  // Start speaking if not speaking
                  await microphoneCtrl.speakEnglishAccent(answer ?? '');
                  microphoneCtrl.isSpeaking = true;
                }

                microphoneCtrl.update(); // Notify UI
              },
              child: SvgPicture.asset(
                '$imgUrl$speakerYellowImg',
                color: kWhite,
              ),
            )
          ],
        ),
      ),
    );
  }
}
