import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Components/app_custom_button.dart';
import 'package:goolu/Controller/AuthController/auth_controller.dart';
import 'package:goolu/View/Auth/sign_in.dart';
import 'package:goolu/View/Drawer/profile_page.dart';

import '../../Config/app_config.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';
import '../../Utils/image_urls.dart';
import '../../Utils/utils.dart';
import '../Subscription/subscription_main.dart';
import 'about_us_page.dart';
import 'cfer_page.dart';
import 'language_page.dart';
import 'notifications_page.dart';

class DrawerDesign extends StatelessWidget {
  const DrawerDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (AuthController authCtrl) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: SizesDimensions.width(5),
                right: SizesDimensions.width(5),
                top: SizesDimensions.height(7),
                bottom: SizesDimensions.height(3)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  '$imgUrl$profileImg',
                  height: 46,
                  width: 46,
                ),
                size20h,
                customText(
                  text: 'John Doe',
                  textStyle: bold14NavyBlue,
                ),
                customText(
                  text: 'johndoe@gmail.com',
                  textStyle: regular12NavyBlue.copyWith(
                      color: secDarkBlueNavyColor.withOpacity(0.7)),
                ),
              ],
            ),
          ),
          AppStyles.dividerLine(
            width: Get.width,
            height: 0.5,
            color: secDarkBlueNavyColor.withOpacity(0.5),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: SizesDimensions.width(5),
                right: SizesDimensions.width(5),
                top: SizesDimensions.height(3),
                bottom: SizesDimensions.height(2)),
            child: Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.to(() => const ProfilePage());
                  },
                  child: iconWithText(
                    icons: userImg,
                    txt: 'Profile',
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.to(() => const CferPage());
                  },
                  child: iconWithText(
                    icons: levelImg,
                    txt: 'CFER',
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.to(() => const AboutUsPage());
                  },
                  child: iconWithText(
                    icons: aboutImg,
                    txt: 'About Us',
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.to(() => const NotificationsPage());
                  },
                  child: iconWithText(
                    icons: bellImg,
                    txt: 'Notifications',
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.to(() => const LanguagePage());
                  },
                  child: iconWithText(
                    icons: languageImg,
                    txt: 'Language',
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.to(() => const SubscriptionMain());
                  },
                  child: iconWithText(
                    icons: subscriptionImg,
                    txt: 'Subscription',
                  ),
                ),
              ],
            ),
          ),
          // DropdownButtonHideUnderline(
          //   child: DropdownButton2(
          //     customButton: SvgPicture.asset('$imgUrl$downArrowImage'),
          //     items: [
          //       ...LanguageMenuItems.firstItems.map(
          //         (item) => DropdownMenuItem<LanguageMenuItem>(
          //           value: item,
          //           child: LanguageMenuItems.buildItem(item),
          //         ),
          //       ),
          //     ],
          //     onChanged: (value) {
          //       LanguageMenuItems.onChanged(context, value!);
          //     },
          //     dropdownStyleData: DropdownStyleData(
          //       width: SizesDimensions.width(30.0),
          //       padding: const EdgeInsets.symmetric(vertical: 6),
          //       decoration: BoxDecoration(
          //         borderRadius:
          //             BorderRadius.circular(Dimensions.radiusSmall),
          //         color: kFFFFFF,
          //       ),
          //       offset: const Offset(0, 8),
          //     ),
          //     menuItemStyleData: const MenuItemStyleData(
          //       padding: EdgeInsets.only(
          //           left: Dimensions.radiusLarge,
          //           right: Dimensions.radiusLarge),
          //     ),
          //   ),
          // ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppCustomButton(
                title: customText(text: 'logout'.tr, textStyle: regular14White),
                onTap: () async {
                  try {
                    Get.offAll(const SignInScreen());
                    await FirebaseAuth.instance.signOut();
                    logger.i('User signed out');
                  } catch (e) {
                    // Handle error during sign-out
                    logger.e('Error signing out: $e');
                  }
                },
              ),
            ],
          ),
          size30h,
        ],
      );
    });
  }

  Padding iconWithText({String? icons, String? txt}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizesDimensions.height(1.2),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            '$imgUrl$icons',
            height: 20,
            width: 20,
          ),
          size30w,
          customText(
            text: '$txt',
            textStyle: regular16NavyBlue,
          ),
        ],
      ),
    );
  }
}
