import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/SideDrawerController/side_drawer_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        size30h,
                        customText(
                          text: 'About Us',
                          textStyle: bold18NavyBlue,
                        ),
                        size10h,
                        customText(
                          text:
                              'Welcome to :goolu, the ultimate application to practice your English speaking skills! We\'re delighted to guide you on your journey to fluency.',
                          textStyle: regular18NavyBlue,
                          maxLines: 5,
                        ),
                        size30h,
                        customText(
                          text: 'Our Mission',
                          textStyle: bold18NavyBlue,
                        ),
                        size10h,
                        customText(
                          text:
                              'Our mission is simple: to help you practice speaking English without limitations. We believe speaking fluently is the common goal in learning any language and practice makes perfect! The features of this app makes speaking accessible, engaging, and effective for learners of all levels. Even if you are still learning the grammar, we believe everyone deserves to practice. We understand that speaking a new language can be daunting, especially in the real world so we bring the language to you and you can focus on building that confidence!  We\'re here to break barriers and transform speaking English into an exciting opportunity for growth in the comfort of your device.',
                          textStyle: regular18NavyBlue,
                          maxLines: 10,
                        ),
                      ],
                    ),
                  )),
            )
          ],
        );
      }),
    );
  }
}
