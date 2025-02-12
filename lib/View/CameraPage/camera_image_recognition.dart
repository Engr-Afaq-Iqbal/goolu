import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Utils/font_styles.dart';

import '../../Components/app_custom_button.dart';
import '../../Components/app_document_upload_dialog.dart';
import '../../Config/app_config.dart';
import '../../Controller/CameraController/camera_controller.dart';
import '../../Controller/MicrophoneController/microphone_controller.dart';
import '../../Controller/dialog_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/image_urls.dart';
import '../../Utils/utils.dart';

class CameraImageRecognition extends StatelessWidget {
  const CameraImageRecognition({super.key});

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              cameraCtrl.file = null;
                              cameraCtrl.imageDetectionModel = null;
                              Get.find<MicrophoneController>().stopSpeaking();
                              cameraCtrl.update();
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back)),
                        size50w,
                        size50w,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            customText(
                              text: 'Image Recognition',
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
                    size50h,
                    customText(
                      text: 'Upload your image',
                      textStyle: bold18NavyBlue.copyWith(
                        color: kDarkYellow,
                        fontSize: 18,
                      ),
                    ),
                    size30h,
                    if (cameraCtrl.file == null)
                      GestureDetector(
                        onTap: () {
                          Get.find<DialogController>().showDialog(
                            AlertDialog(
                              clipBehavior: Clip.hardEdge,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 0),
                              content: AppDocumentUploadDialog(
                                onTapGallery: () async {
                                  bool isPdf =
                                      await cameraCtrl.uploadImageFromGallery();
                                  if (isPdf == true) {
                                    stopProgress();
                                  }
                                },
                                onTapPdf: () async {
                                  bool isPdf =
                                      await cameraCtrl.uploadImageFromCamera();
                                  if (isPdf == true) {
                                    stopProgress();
                                  }
                                },
                              ),
                            ),
                          );
                        },
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
                                  size20h,
                                  SvgPicture.asset(
                                    '$imgUrl$uploadArrowImg',
                                    height: 75,
                                  ),
                                  size30h,
                                  customText(
                                    text:
                                        'Upload image from gallery\nor\nCapture from camera',
                                    textStyle: regular14NavyBlue.copyWith(
                                        color: Colors.grey.withOpacity(0.8)),
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (cameraCtrl.file != null)
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              Dimensions.radiusDoubleExtraLarge),
                          child: Container(
                            width: SizesDimensions.width(80.0),
                            height: SizesDimensions.height(25.0),
                            // margin: EdgeInsets.symmetric(
                            //     horizontal: SizesDimensions.width(0.5)),
                            // padding: EdgeInsets.symmetric(
                            //     horizontal: SizesDimensions.width(2)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radiusExtraLarge,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Image.file(
                                  cameraCtrl.file!,
                                  fit: BoxFit.contain,
                                  width: SizesDimensions.width(80.0),
                                  height: SizesDimensions.height(25.0),
                                ),
                                Positioned(
                                  right: 20,
                                  top: 15,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      cameraCtrl.file = null;

                                      cameraCtrl.file = null;
                                      cameraCtrl.imageDetectionModel = null;
                                      Get.find<MicrophoneController>()
                                          .stopSpeaking();
                                      cameraCtrl.update();
                                    },
                                    child: Container(
                                      width: SizesDimensions.width(8),
                                      height: SizesDimensions.height(4),
                                      decoration: BoxDecoration(
                                        color: kWhite,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: kRedFF624D,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    size30h,
                    if (cameraCtrl.imageDetectionModel == null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppCustomButton(
                            onTap: cameraCtrl.file != null
                                ? () {
                                    cameraCtrl.sendImageFeature1();
                                  }
                                : null,
                            horizontalPadding: 25,
                            verticalPadding: 20,
                            title: Center(
                              child: customText(
                                text: 'Upload',
                                textStyle: bold14White,
                              ),
                            ),
                          ),
                        ],
                      ),
                    size30h,
                    if (cameraCtrl.imageDetectionModel != null)
                      Center(
                        child: Container(
                          // height: SizesDimensions.height(30),
                          width: SizesDimensions.width(90),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radiusDoubleExtraLarge),
                            color: kDarkYellow,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // _audioFile == null
                              //     ? const Text('No audio selected')
                              //     : Text('Audio selected: ${_audioFile!.path}'),
                              //
                              size20h,
                              Row(
                                children: [
                                  SizedBox(
                                    width: SizesDimensions.width(50),
                                    child: customText(
                                        text:
                                            '${cameraCtrl.imageDetectionModel?.word}',
                                        textStyle: bold20White,
                                        maxLines: 10),
                                  ),
                                  // size20w,
                                  GestureDetector(
                                    onTap: () async {
                                      final text = cameraCtrl
                                              .imageDetectionModel?.word ??
                                          'noTextAvailable'.tr;
                                      await Get.find<MicrophoneController>()
                                          .speak(text.replaceAll('-', ''));
                                    },
                                    child: SvgPicture.asset(
                                      '$imgUrl$soundImg',
                                      height: 25,
                                      width: 25,
                                      colorFilter: ColorFilter.mode(
                                        kWhite,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              size30h,
                              SizedBox(
                                height: SizesDimensions.height(20),
                                // width: SizesDimensions.width(30),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      customText(
                                        text:
                                            '${cameraCtrl.imageDetectionModel?.definition}',
                                        textStyle: regular16NavyBlue.copyWith(
                                          fontSize: 14,
                                        ),
                                        maxLines: 30,
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
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
