import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/Components/app_custom_button.dart';
import 'package:goolu/Config/app_config.dart';

import '../Theme/colors.dart';
import '../Utils/dimensions.dart';
import '../Utils/font_styles.dart';

class AppDialogWithTwoButtons extends StatelessWidget {
  final String? heading;
  final String? btnTxt;
  final String? button1Txt;
  final String? button2Txt;
  final Function()? onTapButton1;
  final Function()? onTapButton2;

  const AppDialogWithTwoButtons(
      {super.key,
      this.heading,
      this.btnTxt,
      this.onTapButton1,
      this.button1Txt,
      this.button2Txt,
      this.onTapButton2});

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
            text: '$heading',
            textStyle: regular18NavyBlue,
          ),
          size20h,
          AppStyles.dividerLine(),
          size40h,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppCustomButton(
                onTap: onTapButton1,
                bgColor: kLightBlue32A3B8,
                title: Center(
                  child: customText(
                    text: '$button1Txt',
                    textStyle: bold14White,
                  ),
                ),
              ),
              size50w,
              AppCustomButton(
                onTap: onTapButton2,
                bgColor: kLightBlue32A3B8,
                title: Center(
                  child: customText(
                    text: '$button2Txt',
                    textStyle: bold14White,
                  ),
                ),
              ),
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
