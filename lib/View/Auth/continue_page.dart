import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/Components/app_custom_button.dart';
import 'package:goolu/Utils/dimensions.dart';
import 'package:goolu/Utils/image_urls.dart';
import 'package:goolu/View/Auth/welcome_page.dart';

import '../../Components/custom_painter_class.dart';
import '../../Config/app_config.dart';
import '../../Theme/colors.dart';
import '../../Utils/font_styles.dart';

class ContinuePage extends StatefulWidget {
  const ContinuePage({super.key});

  @override
  State<ContinuePage> createState() => _ContinuePageState();
}

class _ContinuePageState extends State<ContinuePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: kWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomPaint(
                    painter: CustomStyleArrow(),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: customText(
                            text: 'welcomeToGoolYouSayIt'.tr,
                            textStyle: bold16White,
                            maxLines: 3,
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Image.asset(
              '$gooluLogoUrl$gooluNewLogo',
              width: SizesDimensions.width(90),
            ),
            size150h,
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizesDimensions.width(20)),
              child: AppCustomButton(
                padding: const EdgeInsets.symmetric(vertical: 15),
                title: customText(
                  text: 'continue'.tr,
                  textStyle: bold20White,
                ),
                onTap: () async {
                  Get.offAll(() => const WelcomePage());
                },
                // onTap: () {
                //   Get.to(() => const SignInScreen(),
                //       transition: Transition.downToUp,
                //       duration: const Duration(seconds: 1));
                // },
                borderRadius: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
