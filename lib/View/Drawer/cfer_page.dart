import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/SideDrawerController/side_drawer_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';

class CferPage extends StatelessWidget {
  const CferPage({super.key});

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
                  children: [
                    Center(
                      child: customText(
                        text: 'Edit profile',
                        textStyle: bold18NavyBlue,
                      ),
                    ),
                    Center(
                      child: customText(
                        text: 'Discover your language skills with ease.',
                        textStyle: regular16NavyBlue,
                      ),
                    ),
                    size60h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: 'A1 (Beginner)',
                          textStyle: regular16NavyBlue.copyWith(
                              color: Theme.of(context).iconTheme.color),
                        ),
                        Radio(
                          groupValue: sideDrawerCtrl.cferLevel,
                          onChanged: (dynamic value) {
                            sideDrawerCtrl.cferLevel = value;

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
                          text: 'A2 (Elementary)',
                          textStyle: regular16NavyBlue.copyWith(
                              color: Theme.of(context).iconTheme.color),
                        ),
                        Radio(
                          groupValue: sideDrawerCtrl.cferLevel,
                          onChanged: (dynamic value) {
                            sideDrawerCtrl.cferLevel = value;

                            sideDrawerCtrl.update();
                          },
                          activeColor: primaryColor,
                          value: 1,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: 'B1 (Intermediate)',
                          textStyle: regular16NavyBlue.copyWith(
                              color: Theme.of(context).iconTheme.color),
                        ),
                        Radio(
                          groupValue: sideDrawerCtrl.cferLevel,
                          onChanged: (dynamic value) {
                            sideDrawerCtrl.cferLevel = value;

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
                          text: 'B2 (Upper Intermediate)',
                          textStyle: regular16NavyBlue.copyWith(
                              color: Theme.of(context).iconTheme.color),
                        ),
                        Radio(
                          groupValue: sideDrawerCtrl.cferLevel,
                          onChanged: (dynamic value) {
                            sideDrawerCtrl.cferLevel = value;

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
                          text: 'C1 (Advanced)',
                          textStyle: regular16NavyBlue.copyWith(
                              color: Theme.of(context).iconTheme.color),
                        ),
                        Radio(
                          groupValue: sideDrawerCtrl.cferLevel,
                          onChanged: (dynamic value) {
                            sideDrawerCtrl.cferLevel = value;

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
                          text: 'C2 (Proficient)',
                          textStyle: regular16NavyBlue.copyWith(
                              color: Theme.of(context).iconTheme.color),
                        ),
                        Radio(
                          groupValue: sideDrawerCtrl.cferLevel,
                          onChanged: (dynamic value) {
                            sideDrawerCtrl.cferLevel = value;

                            sideDrawerCtrl.update();
                          },
                          activeColor: primaryColor,
                          value: 5,
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
