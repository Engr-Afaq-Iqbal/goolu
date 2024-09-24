import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/app_custom_button.dart';
import '../../Controller/SideDrawerController/side_drawer_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';

class SubscriptionPlansInfo extends StatelessWidget {
  const SubscriptionPlansInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                              text: 'Yearly SAR 540',
                              textStyle: bold20NavyBlue.copyWith(fontSize: 22),
                            ),
                            size10h,
                            customText(
                              text: 'SAR 45',
                              textStyle: bold20NavyBlue.copyWith(fontSize: 30),
                            ),
                            customText(
                              text: '/month',
                              textStyle: regular16NavyBlue,
                            ),
                          ],
                        ),

                        // size60h,
                      ],
                    ),
                    size30h,
                    iconWithText(
                        txt: 'Practice describing real life scenarios'),
                    iconWithText(txt: 'Voice Translation tool'),
                    iconWithText(
                        txt: 'Practice general questions with model answers'),
                    iconWithText(txt: 'Practice specific topic conversations'),
                    iconWithText(txt: 'Practice scenario based dialouges'),
                    iconWithText(txt: 'Make 500 requests per feature'),
                    iconWithText(
                        txt:
                            'Learn new vocabulary from anywhere with image recognition feature'),
                    iconWithText(txt: 'Translate texts from images'),
                    size50h,
                    AppCustomButton(
                      title:
                          customText(text: 'Subscribe', textStyle: bold16White),
                      onTap: () {
                        Get.to(() => const SubscriptionPlansInfo());
                      },
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

  Padding iconWithText({String? txt}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.check, // Tick icon
            color: primaryBlueColor, // Icon color
            size: 24.0, // Icon size
          ),
          size30w,
          SizedBox(
              width: SizesDimensions.width(80),
              child: customText(
                  text: '$txt', textStyle: bold16NavyBlue, maxLines: 3)),
        ],
      ),
    );
  }
}
