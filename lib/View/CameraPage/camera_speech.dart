import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Config/app_config.dart';
import '../../Controller/CameraController/camera_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';
import '../../Utils/image_urls.dart';

class CameraSpeech extends StatelessWidget {
  const CameraSpeech({super.key});

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
                                Get.back();
                              },
                              child: const Icon(Icons.arrow_back)),
                          size50w,
                          size50w,
                          size50w,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customText(
                                text: 'Speech',
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
                    size50h,
                    if (cameraCtrl.file2 == null)
                      GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: DottedBorder(
                            strokeWidth: 0.5,
                            strokeCap: StrokeCap.butt,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(
                                Dimensions.radiusDoubleExtraLarge),
                            padding: const EdgeInsets.all(0),
                            dashPattern: const [5, 6],
                            child: Container(
                              width: SizesDimensions.width(90),
                              height: SizesDimensions.height(30.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radiusDoubleExtraLarge)),
                              // Set background color to white
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('$imgUrl$imageFootball'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    size30h,
                    customText(
                      text:
                          'Describe what you see and try to give\nyour opinion',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      textStyle: bold18NavyBlue.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    size30h,
                    Expanded(
                      child: Container(
                        // height: SizesDimensions.height(35),
                        width: SizesDimensions.width(100),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(
                                  Dimensions.radiusDoubleExtraLarge),
                              topRight: Radius.circular(
                                  Dimensions.radiusDoubleExtraLarge)),
                          color: kDarkYellow,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // _audioFile == null
                            //     ? const Text('No audio selected')
                            //     : Text('Audio selected: ${_audioFile!.path}'),
                            //
                            size20h,
                            customText(
                                text:
                                    'Listen and practice a model answer ${cameraCtrl.cameraPageFeature2Model?.detectedText ?? ''}',
                                textStyle: bold18NavyBlue,
                                maxLines: 10),
                            size30h,
                            customText(
                              text:
                                  'Athletes playing basketball and trying to throw ball in basket. ${cameraCtrl.imageDetectionModel?.definition ?? ''}',
                              textStyle: regular18NavyBlue,
                              textAlign: TextAlign.center,
                              maxLines: 50,
                            ),
                          ],
                        ),
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
