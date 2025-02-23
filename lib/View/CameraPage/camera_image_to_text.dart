import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
import '../../Model/language_text_to_translation.dart';
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
                  vertical: SizesDimensions.height(2),
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
                              cameraCtrl.file2 = null;
                              cameraCtrl.cameraPageFeature2Model = null;
                              Get.find<MicrophoneController>().stopSpeaking();
                              cameraCtrl.update();
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
                              text: 'Text Recognition',
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

                    size20h,
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
                    if (cameraCtrl.file2 != null)
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              Dimensions.radiusDoubleExtraLarge),
                          child: Container(
                            width: SizesDimensions.width(80.0),
                            height: SizesDimensions.height(20.0),
                            // margin: EdgeInsets.symmetric(
                            //     horizontal: SizesDimensions.width(0.5)),
                            // padding: EdgeInsets.symmetric(
                            //     horizontal: SizesDimensions.width(2)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusExtraLarge)),
                            child: Stack(
                              children: [
                                Image.file(
                                  cameraCtrl.file2!,
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
                                      cameraCtrl.file2 = null;
                                      cameraCtrl.cameraPageFeature2Model = null;
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
                    size20h,
                    // if (cameraCtrl.file2 != null)
                    if (cameraCtrl.cameraPageFeature2Model == null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppCustomButton(
                            onTap: cameraCtrl.file2 != null
                                ? () {
                                    cameraCtrl.sendImageFeature2();
                                  }
                                : null,
                            horizontalPadding: 25,
                            verticalPadding: 15,
                            title: Center(
                              child: customText(
                                text: 'Upload',
                                textStyle: bold16White,
                              ),
                            ),
                          ),
                        ],
                      ),

                    size10h,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusLarge),
                        color: primaryColor,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          customButton: customText(
                            text: cameraCtrl.selectedLanguage,
                            textStyle: regular18NavyBlue.copyWith(
                              fontSize: 16,
                              color: kWhite,
                            ),
                          ),
                          items: [
                            ...LanguageTextToTranslations.firstItems.map(
                              (item) =>
                                  DropdownMenuItem<LanguageTextToTranslation>(
                                value: item,
                                child:
                                    LanguageTextToTranslations.buildItem(item),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            LanguageTextToTranslations.onChanged(
                                context, value!);
                            showProgress();
                            cameraCtrl.fetchTranslation(
                                text: cameraCtrl
                                    .cameraPageFeature2Model?.detectedText);
                          },
                          dropdownStyleData: DropdownStyleData(
                            width: SizesDimensions.width(30.0),
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radiusSmall),
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
                    ),
                    size5h,
                    if (cameraCtrl.cameraPageFeature2Model == null) size30h,
                    if (cameraCtrl.cameraPageFeature2Model != null)
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              Dimensions.radiusDoubleExtraLarge),
                          child: Container(
                            height: SizesDimensions.height(38),
                            width: SizesDimensions.width(90),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusDoubleExtraLarge),
                              color: kDarkYellow,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  size20h,
                                  Row(
                                    children: [
                                      customText(
                                        text: 'Text in image:',
                                        textStyle: bold20White.copyWith(
                                          fontSize: 20,
                                        ),
                                        maxLines: 2,
                                      ),
                                      size40w,
                                      GestureDetector(
                                        onTap: () async {
                                          final text = cameraCtrl
                                                  .cameraPageFeature2Model
                                                  ?.detectedText
                                                  .toString() ??
                                              'noTextAvailable'.tr;
                                          await cameraCtrl.speakEnglish(text);
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
                                  size20h,
                                  customText(
                                    text:
                                        '${cameraCtrl.cameraPageFeature2Model?.detectedText}',
                                    textStyle: regular16NavyBlue.copyWith(
                                      fontSize: 14,
                                    ),
                                    maxLines: 50,
                                  ),
                                  Row(
                                    children: [
                                      customText(
                                        text: 'Translated Text',
                                        textStyle: bold20White.copyWith(
                                          fontSize: 20,
                                        ),
                                        maxLines: 2,
                                      ),
                                      size40w,
                                      GestureDetector(
                                        onTap: () async {
                                          final text = cameraCtrl
                                                  .textToTranslationModel
                                                  ?.result ??
                                              'noTextAvailable'.tr;
                                          await cameraCtrl.speak(text);
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
                                  size10h,
                                  customText(
                                    text:
                                        '${cameraCtrl.textToTranslationModel?.result}',
                                    textStyle: regular16NavyBlue.copyWith(
                                      fontSize: 14,
                                    ),
                                    maxLines: 50,
                                  ),
                                  size20h,
                                ],
                              ),
                            ),
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
