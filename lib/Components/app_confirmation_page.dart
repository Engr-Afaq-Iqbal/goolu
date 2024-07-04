import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Config/app_config.dart';
import '../Theme/colors.dart';
import '../Utils/dimensions.dart';
import '../Utils/font_styles.dart';
import '../View/Auth/sign_in.dart';
import 'app_custom_app_bar.dart';
import 'app_custom_button.dart';

class AppConfirmationPage extends StatelessWidget {
  final String? route;
  final String? title;
  final String? txt;
  final String? btnTxt;
  const AppConfirmationPage(
      {super.key, this.title, this.txt, this.btnTxt, this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kFFFFFF,
        body: Stack(
          children: [
            // bottomLogo(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizesDimensions.width(3.0),
              ),
              child: Column(
                children: [
                  size60h,
                  const AppCustomAppBar(
                    showBackButton: false,
                  ),
                  size50h,
                  Image.asset(
                    '${gooluLogoUrl}goolu.png',
                    width: SizesDimensions.width(45),
                  ),
                  size150h,
                  SvgPicture.asset('${imgUrl}tick.svg'),
                  customText(
                    text: '$title',
                    textStyle: bold16NavyBlue,
                    maxLines: 2,
                  ),
                  size10h,
                  customText(
                    text: '$txt',
                    textStyle: regular14NavyBlue,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  AppStyles.dividerLine(width: Get.width),
                  size20h,
                  AppCustomButton(
                    title: customText(
                      text: '$btnTxt',
                      textStyle: bold14White,
                    ),
                    onTap: () {
                      if (route == 'setNewPassword') {
                        Get.offAll(() => const SignInScreen());
                      } else if (route == 'newAccount') {
                        Get.offAll(() => const SignInScreen());
                        // Get.offAll(() => const AppBottomNavigationBar());
                      }
                    },
                    borderRadius: 4,
                  ),
                  size20h,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // forgetPasswordHandler(context) async {
  //   FocusScope.of(context).unfocus();
  //   // showProgress();
  //   // authCtrl.postLogin();
  // }
}
