import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/Components/app_custom_button.dart';
import 'package:goolu/Theme/colors.dart';
import 'package:goolu/Utils/font_styles.dart';
import 'package:goolu/Utils/image_urls.dart';
import 'package:goolu/View/Auth/sign_in.dart';
import 'package:goolu/View/Auth/sign_up.dart';

import '../../Config/app_config.dart';
import '../../Utils/dimensions.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            size100h,
            Image.asset(
              '$imgUrl$booksImg',
              // colorFilter:
              // ColorFilter.mode(primaryBlueColor, BlendMode.srcIn),
            ),
            Image.asset(
              '$gooluLogoUrl$gooluNewLogo',

              // colorFilter:
              // ColorFilter.mode(primaryBlueColor, BlendMode.srcIn),
            ),
            size50h,
            customText(
              text: 'Welcome to\nGOOLU',
              textAlign: TextAlign.center,
              textStyle: bold20NavyBlue.copyWith(
                fontSize: 22,
                color: kDarkGreen365D64,
              ),
              maxLines: 2,
            ),
            size30h,
            customText(
                text:
                    'Explore interactive lessons and track your progress as you master new skills.',
                textAlign: TextAlign.center,
                textStyle: regular18NavyBlue,
                maxLines: 3),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppCustomButton(
                  horizontalPadding: 55,
                  verticalPadding: 10,
                  borderRadius: Dimensions.radiusExtraLarge,
                  title: customText(text: 'Login', textStyle: bold16White),
                  onTap: () {
                    Get.to(() => const SignInScreen());
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const SignUpPage());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 55, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusExtraLarge),
                        border: Border.all(
                          color: primaryBlueColor,
                        )),
                    child: customText(
                        text: 'Register',
                        textStyle: regular16PrimaryBlue.copyWith(
                            color: secDarkBlueNavyColor)),
                  ),
                )
              ],
            ),
            size50h,
          ],
        ),
      ),
    );
  }
}
