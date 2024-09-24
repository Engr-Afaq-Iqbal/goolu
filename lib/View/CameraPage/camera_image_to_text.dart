import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Components/app_custom_button.dart';
import 'package:goolu/Controller/MicrophoneController/microphone_controller.dart';
import 'package:goolu/Utils/font_styles.dart';

import '../../Components/app_document_upload_dialog.dart';
import '../../Config/app_config.dart';
import '../../Controller/CameraController/camera_controller.dart';
import '../../Controller/dialog_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/image_urls.dart';
import '../../Utils/utils.dart';

class CameraImageToText extends StatelessWidget {
  const CameraImageToText({super.key});

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
                              text: 'Image to Text',
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

                    size30h,
                    customText(
                      text: 'Upload your image',
                      textStyle: bold18NavyBlue.copyWith(
                        color: kDarkYellow,
                        fontSize: 18,
                      ),
                    ),
                    size30h,
                    if (cameraCtrl.file2 == null)
                      GestureDetector(
                        onTap: () {
                          Get.find<DialogController>().showDialog(
                            AlertDialog(
                                clipBehavior: Clip.hardEdge,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 0),
                                content: AppDocumentUploadDialog(
                                  onTapGallery: () async {
                                    bool isPdf = await cameraCtrl
                                        .uploadImageFromGallery2();
                                    if (isPdf == true) {
                                      stopProgress();
                                    }
                                  },
                                  onTapPdf: () async {
                                    bool isPdf = await cameraCtrl
                                        .uploadImageFromCamera2();
                                    if (isPdf == true) {
                                      stopProgress();
                                    }
                                  },
                                )),
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
                    // if (cameraCtrl.file2 != null)
                    //   Center(
                    //     child: ClipRRect(
                    //       borderRadius:
                    //           BorderRadius.circular(Dimensions.radiusDefault),
                    //       child: Container(
                    //         width: SizesDimensions.width(80.0),
                    //         height: SizesDimensions.height(25.0),
                    //         // margin: EdgeInsets.symmetric(
                    //         //     horizontal: SizesDimensions.width(0.5)),
                    //         // padding: EdgeInsets.symmetric(
                    //         //     horizontal: SizesDimensions.width(2)),
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(
                    //                 Dimensions.radiusExtraLarge)),
                    //         child: Stack(
                    //           children: [
                    //             Image.file(
                    //               cameraCtrl.file2!,
                    //               fit: BoxFit.fill,
                    //               width: SizesDimensions.width(80.0),
                    //               height: SizesDimensions.height(25.0),
                    //             ),
                    //             Positioned(
                    //               right: 10,
                    //               top: 10,
                    //               child: GestureDetector(
                    //                 behavior: HitTestBehavior.translucent,
                    //                 onTap: () {
                    //                   cameraCtrl.file2 = null;
                    //                   cameraCtrl.update();
                    //                 },
                    //                 child: Container(
                    //                   width: SizesDimensions.width(6),
                    //                   height: SizesDimensions.height(3),
                    //                   decoration: BoxDecoration(
                    //                     color: kWhite,
                    //                     shape: BoxShape.circle,
                    //                   ),
                    //                   child: Icon(
                    //                     Icons.close_rounded,
                    //                     color: kRedFF624D,
                    //                     size: 20,
                    //                   ),
                    //                 ),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    size30h,
                    if (cameraCtrl.file2 != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppCustomButton(
                            onTap: cameraCtrl.file2 != null
                                ? () {
                                    cameraCtrl.sendImageFeature2();
                                  }
                                : null,
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
                    if (cameraCtrl.cameraPageFeature2Model != null)
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
                                    width: SizesDimensions.width(30),
                                    child: customText(
                                        text:
                                            '${cameraCtrl.cameraPageFeature2Model?.detectedText}',
                                        textStyle: bold20White,
                                        maxLines: 10),
                                  ),
                                  // size20w,
                                  GestureDetector(
                                    onTap: () async {
                                      final text = cameraCtrl
                                              .cameraPageFeature2Model
                                              ?.detectedText
                                              .toString() ??
                                          'noTextAvailable'.tr;
                                      await Get.find<MicrophoneController>()
                                          .speak(text);
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
                                width: SizesDimensions.width(60),
                                child: customText(
                                  text:
                                      '${cameraCtrl.imageDetectionModel?.definition}',
                                  textStyle: regular14NavyBlue,
                                  maxLines: 10,
                                ),
                              ),
                              size20h,
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // size30h,
            // // if (cameraCtrl.file2 == null)
            // //   GestureDetector(
            // //     onTap: () {
            // //       Get.find<DialogController>().showDialog(
            // //         AlertDialog(
            // //             clipBehavior: Clip.hardEdge,
            // //             contentPadding: const EdgeInsets.symmetric(
            // //                 vertical: 15, horizontal: 0),
            // //             content: AppDocumentUploadDialog(
            // //               onTapGallery: () async {
            // //                 bool isPdf =
            // //                     await cameraCtrl.uploadImageFromGallery2();
            // //                 if (isPdf == true) {
            // //                   stopProgress();
            // //                 }
            // //               },
            // //               onTapPdf: () async {
            // //                 bool isPdf =
            // //                     await cameraCtrl.uploadImageFromCamera2();
            // //                 if (isPdf == true) {
            // //                   stopProgress();
            // //                 }
            // //               },
            // //             )),
            // //       );
            // //     },
            // //     child: Center(
            // //       child: DottedBorder(
            // //         strokeWidth: 0.5,
            // //         strokeCap: StrokeCap.butt,
            // //         borderType: BorderType.RRect,
            // //         radius: const Radius.circular(Dimensions.radiusDefault),
            // //         padding: const EdgeInsets.all(0),
            // //         dashPattern: const [5, 6],
            // //         child: SizedBox(
            // //           width: SizesDimensions.width(80.0),
            // //           height: SizesDimensions.height(25.0),
            // //           child: Column(
            // //             mainAxisAlignment: MainAxisAlignment.center,
            // //             crossAxisAlignment: CrossAxisAlignment.center,
            // //             children: [
            // //               Icon(
            // //                 Icons.upload,
            // //                 color: secDarkBlueNavyColor,
            // //                 size: 40,
            // //               ),
            // //               size20h,
            // //               customText(
            // //                 text: 'selectImagesFromGalleryOrCamera'.tr,
            // //                 textStyle: bold14NavyBlue,
            // //                 textAlign: TextAlign.center,
            // //                 maxLines: 3,
            // //               ),
            // //             ],
            // //           ),
            // //         ),
            // //       ),
            // //     ),
            // //   ),
            // if (cameraCtrl.file2 != null)
            //   Center(
            //     child: ClipRRect(
            //       borderRadius:
            //           BorderRadius.circular(Dimensions.radiusDefault),
            //       child: Container(
            //         width: SizesDimensions.width(80.0),
            //         height: SizesDimensions.height(25.0),
            //         // margin: EdgeInsets.symmetric(
            //         //     horizontal: SizesDimensions.width(0.5)),
            //         // padding: EdgeInsets.symmetric(
            //         //     horizontal: SizesDimensions.width(2)),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(
            //                 Dimensions.radiusExtraLarge)),
            //         child: Stack(
            //           children: [
            //             Image.file(
            //               cameraCtrl.file2!,
            //               fit: BoxFit.fill,
            //               width: SizesDimensions.width(80.0),
            //               height: SizesDimensions.height(25.0),
            //             ),
            //             Positioned(
            //               right: 10,
            //               top: 10,
            //               child: GestureDetector(
            //                 behavior: HitTestBehavior.translucent,
            //                 onTap: () {
            //                   cameraCtrl.file2 = null;
            //                   cameraCtrl.update();
            //                 },
            //                 child: Container(
            //                   width: SizesDimensions.width(6),
            //                   height: SizesDimensions.height(3),
            //                   decoration: BoxDecoration(
            //                     color: kWhite,
            //                     shape: BoxShape.circle,
            //                   ),
            //                   child: Icon(
            //                     Icons.close_rounded,
            //                     color: kRedFF624D,
            //                     size: 20,
            //                   ),
            //                 ),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // size30h,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     AppCustomButton(
            //       title: customText(
            //         text: 'sendRequest'.tr,
            //         textStyle: bold14White,
            //       ),
            //       onTap: cameraCtrl.file2 != null
            //           ? () {
            //               cameraCtrl.sendImageFeature2();
            //             }
            //           : null,
            //       borderRadius: 4,
            //     ),
            //   ],
            // ),
            // size30h,
            // if (cameraCtrl.cameraPageFeature2Model != null)
            //   Center(
            //     child: Container(
            //       // height: SizesDimensions.height(30),
            //       width: SizesDimensions.width(80),
            //       padding: const EdgeInsets.all(20),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color: primaryBlueColor,
            //       ),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           // _audioFile == null
            //           //     ? const Text('No audio selected')
            //           //     : Text('Audio selected: ${_audioFile!.path}'),
            //           //
            //           size20h,
            //           Row(
            //             children: [
            //               SizedBox(
            //                 width: SizesDimensions.width(40),
            //                 child: customText(
            //                     text:
            //                         '${cameraCtrl.cameraPageFeature2Model?.detectedText}',
            //                     textStyle: bold16White,
            //                     maxLines: 10),
            //               ),
            //               size20w,
            //               GestureDetector(
            //                 onTap: () async {
            //                   final text = cameraCtrl
            //                           .cameraPageFeature2Model?.detectedText
            //                           .toString() ??
            //                       'noTextAvailable'.tr;
            //                   await Get.find<MicrophoneController>()
            //                       .speak(text);
            //                 },
            //                 child: Container(
            //                   width: 30.0,
            //                   height: 30.0,
            //                   padding: const EdgeInsets.all(5),
            //                   decoration: BoxDecoration(
            //                     color: kYellowffde59,
            //                     shape: BoxShape.circle,
            //                   ),
            //                   child: SvgPicture.asset(
            //                     '$imgUrl$playImage',
            //                     colorFilter: ColorFilter.mode(
            //                       primaryBlueColor,
            //                       BlendMode.srcIn,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //           size10h,
            //           AppStyles.dividerLine(color: kWhite),
            //           size20h,
            //         ],
            //       ),
            //     ),
            //   ),
            // Center(
            //   child: Container(
            //     height: SizesDimensions.height(25),
            //     width: SizesDimensions.width(80),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
            //       border: Border.all(
            //         width: 1,
            //         color: kBCC8FF,
            //       ),
            //     ),
            //     child: Center(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           customText(
            //             text: 'Upload Document',
            //             textStyle: bold16NavyBlue,
            //           ),
            //           size10w,
            //           Icon(
            //             Icons.upload,
            //             color: secDarkBlueNavyColor,
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // )
          ],
        );
      }),
    );
  }
}
