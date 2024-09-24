import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Components/app_custom_button.dart';

import '../Config/app_config.dart';
import '../Theme/colors.dart';
import '../Utils/dimensions.dart';
import '../Utils/font_styles.dart';
import '../Utils/image_urls.dart';

class AppDocumentUploadDialog extends StatelessWidget {
  final String? heading;
  final String? subHeading;
  final String? btnTxt;
  final Function()? onTapGallery;
  final Function()? onTapPdf;

  const AppDocumentUploadDialog(
      {super.key,
      this.heading,
      this.btnTxt,
      this.subHeading,
      this.onTapGallery,
      this.onTapPdf});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizesDimensions.height(30),
      width: Get.width,
      padding: EdgeInsets.symmetric(
        vertical: SizesDimensions.height(3),
        horizontal: SizesDimensions.width(3),
      ),
      child: Column(
        children: [
          customText(
            text: 'Choose',
            textStyle: regular18NavyBlue,
          ),
          size20h,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onTapGallery,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      '$imgUrl$galleryImage',
                      height: 60,
                      width: 60,
                      colorFilter:
                          ColorFilter.mode(primaryBlueColor, BlendMode.srcIn),
                    ),
                    size10h,
                    customText(
                      text: 'Gallery',
                      textStyle: regular16NavyBlue,
                    ),
                  ],
                ),
              ),
              size50w,
              GestureDetector(
                onTap: onTapPdf,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      '$imgUrl$cameraImage',
                      height: 60,
                      width: 60,
                      colorFilter:
                          ColorFilter.mode(primaryBlueColor, BlendMode.srcIn),
                    ),
                    size10h,
                    customText(
                      text: 'Camera',
                      textStyle: regular16NavyBlue,
                    ),
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppCustomButton(
                onTap: () {
                  Get.close(1);
                },
                bgColor: kRedFF624D,
                title: Center(
                  child: customText(
                    text: 'Cancel',
                    textStyle: bold14White,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
