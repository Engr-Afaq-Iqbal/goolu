import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/SideDrawerController/side_drawer_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          // leading: SvgPicture.asset(
          //   '$gooluLogoUrl$dotGooluLogo',
          //   height: 30,
          //   width: 30,
          // ),
          // title: Row(
          //   children: [SvgPicture.asset('$gooluLogoUrl$dotGooluLogo')],
          // ),
          ),
      body: GetBuilder<SideDrawerController>(
          builder: (SideDrawerController sideDrawerCtrl) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: customText(
                        text: 'Language',
                        textStyle: bold18NavyBlue,
                      ),
                    ),
                    size10h,
                    customText(
                      text: 'Suggested',
                      textStyle: bold16NavyBlue,
                    ),
                    size10h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: 'English (US)',
                          textStyle: regular16NavyBlue.copyWith(
                              color: Theme.of(context).iconTheme.color),
                        ),
                        Radio(
                          groupValue: sideDrawerCtrl.languageLevel,
                          onChanged: (dynamic value) {
                            sideDrawerCtrl.languageLevel = value;

                            sideDrawerCtrl.update();
                          },
                          activeColor: primaryColor,
                          value: 0,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: 'English (UK)',
                          textStyle: regular16NavyBlue.copyWith(
                              color: Theme.of(context).iconTheme.color),
                        ),
                        Radio(
                          groupValue: sideDrawerCtrl.languageLevel,
                          onChanged: (dynamic value) {
                            sideDrawerCtrl.languageLevel = value;

                            sideDrawerCtrl.update();
                          },
                          activeColor: primaryColor,
                          value: 1,
                        ),
                      ],
                    ),
                    size10h,
                    customText(
                      text: 'Others',
                      textStyle: bold16NavyBlue,
                    ),
                    size10h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: 'Hindi',
                          textStyle: regular16NavyBlue.copyWith(
                              color: Theme.of(context).iconTheme.color),
                        ),
                        Radio(
                          groupValue: sideDrawerCtrl.languageLevel,
                          onChanged: (dynamic value) {
                            sideDrawerCtrl.languageLevel = value;

                            sideDrawerCtrl.update();
                          },
                          activeColor: primaryColor,
                          value: 2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: 'Spanish',
                          textStyle: regular16NavyBlue.copyWith(
                              color: Theme.of(context).iconTheme.color),
                        ),
                        Radio(
                          groupValue: sideDrawerCtrl.languageLevel,
                          onChanged: (dynamic value) {
                            sideDrawerCtrl.languageLevel = value;

                            sideDrawerCtrl.update();
                          },
                          activeColor: primaryColor,
                          value: 3,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: 'French',
                          textStyle: regular16NavyBlue.copyWith(
                              color: Theme.of(context).iconTheme.color),
                        ),
                        Radio(
                          groupValue: sideDrawerCtrl.languageLevel,
                          onChanged: (dynamic value) {
                            sideDrawerCtrl.languageLevel = value;

                            sideDrawerCtrl.update();
                          },
                          activeColor: primaryColor,
                          value: 4,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: 'Arabic',
                          textStyle: regular16NavyBlue.copyWith(
                              color: Theme.of(context).iconTheme.color),
                        ),
                        Radio(
                          groupValue: sideDrawerCtrl.languageLevel,
                          onChanged: (dynamic value) {
                            sideDrawerCtrl.languageLevel = value;

                            sideDrawerCtrl.update();
                          },
                          activeColor: primaryColor,
                          value: 5,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: 'Russian',
                          textStyle: regular16NavyBlue.copyWith(
                              color: Theme.of(context).iconTheme.color),
                        ),
                        Radio(
                          groupValue: sideDrawerCtrl.languageLevel,
                          onChanged: (dynamic value) {
                            sideDrawerCtrl.languageLevel = value;

                            sideDrawerCtrl.update();
                          },
                          activeColor: primaryColor,
                          value: 6,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: 'Indonesia',
                          textStyle: regular16NavyBlue.copyWith(
                              color: Theme.of(context).iconTheme.color),
                        ),
                        Radio(
                          groupValue: sideDrawerCtrl.languageLevel,
                          onChanged: (dynamic value) {
                            sideDrawerCtrl.languageLevel = value;

                            sideDrawerCtrl.update();
                          },
                          activeColor: primaryColor,
                          value: 7,
                        ),
                      ],
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
}
