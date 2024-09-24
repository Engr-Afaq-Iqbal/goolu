import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Config/app_config.dart';
import '../../Controller/CameraController/camera_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';
import '../../Utils/image_urls.dart';
import 'camera_image_recognition.dart';
import 'camera_image_to_text.dart';
import 'camera_speech.dart';

class CameraMain extends StatefulWidget {
  const CameraMain({
    super.key,
  });

  @override
  State<CameraMain> createState() => _CameraMainState();
}

class _CameraMainState extends State<CameraMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppStyles().customAppBar(),
      body:
          GetBuilder<CameraController>(builder: (CameraController cameraCtrl) {
        return Column(
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
                    Center(
                      child: customText(
                        text: 'Premium Features',
                        textStyle: regular18NavyBlue.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    size20h,
                    AppStyles.dividerLine(
                      color: kDarkYellow,
                      width: SizesDimensions.width(50),
                      height: 2,
                    ),
                    size30h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const CameraImageRecognition());
                          },
                          child: box(
                            txt: 'Image Recognition',
                            boxColor: kDarkGreen5b99a5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const CameraImageToText());
                          },
                          child: box(
                            txt: 'Image to\nText',
                            boxColor: kDarkGreen5b99a5,
                          ),
                        ),
                      ],
                    ),
                    size30h,
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const CameraSpeech());
                      },
                      child: box(
                        txt: 'Speech',
                        boxColor: kLightGreen79ccdc,
                        isLock: false,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Container box({Color? boxColor, String? txt, bool isLock = true}) {
    return Container(
      width: SizesDimensions.width(42),
      height: SizesDimensions.height(21),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(
          Dimensions.radiusLarge,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLock == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 0.0),
                  child: SvgPicture.asset(
                    '$imgUrl$lockImg',
                    height: 35,
                  ),
                ),
              ],
            ),
          Center(
            child: customText(
              text: '$txt',
              textStyle: bold20White.copyWith(
                fontSize: 18,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          if (isLock == true) size30h,
        ],
      ),
    );
  }
}
