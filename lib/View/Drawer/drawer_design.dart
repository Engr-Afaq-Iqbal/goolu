import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/AuthController/auth_controller.dart';

import '../../Config/app_config.dart';
import '../../Model/language_menu_item.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';
import '../../Utils/image_urls.dart';

class DrawerDesign extends StatelessWidget {
  const DrawerDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (AuthController authCtrl) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizesDimensions.width(7),
            vertical: SizesDimensions.height(7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('$imgUrl$languageImage'),
                    size20w,
                    customText(
                      text: authCtrl.selectedLanguage,
                      textStyle: regular14DarkGrey,
                    ),
                  ],
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    customButton: SvgPicture.asset('$imgUrl$downArrowImage'),
                    items: [
                      ...LanguageMenuItems.firstItems.map(
                        (item) => DropdownMenuItem<LanguageMenuItem>(
                          value: item,
                          child: LanguageMenuItems.buildItem(item),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      LanguageMenuItems.onChanged(context, value!);
                    },
                    dropdownStyleData: DropdownStyleData(
                      width: SizesDimensions.width(30.0),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall),
                        color: kFFFFFF,
                      ),
                      offset: const Offset(0, 8),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.only(
                          left: Dimensions.radiusLarge,
                          right: Dimensions.radiusLarge),
                    ),
                  ),
                ),
              ],
            ),
            size20h,
            AppStyles.dividerLine(),
            size20h,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      '$imgUrl$levelImage',
                      height: 25,
                    ),
                    size20w,
                    customText(
                      text: 'Level',
                      textStyle: regular14DarkGrey,
                    ),
                  ],
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    customButton: SvgPicture.asset('$imgUrl$downArrowImage'),
                    items: [
                      ...LanguageMenuItems.firstItems.map(
                        (item) => DropdownMenuItem<LanguageMenuItem>(
                          value: item,
                          child: LanguageMenuItems.buildItem(item),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      LanguageMenuItems.onChanged(context, value!);
                    },
                    dropdownStyleData: DropdownStyleData(
                      width: SizesDimensions.width(30.0),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall),
                        color: kFFFFFF,
                      ),
                      offset: const Offset(0, 8),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.only(
                          left: Dimensions.radiusLarge,
                          right: Dimensions.radiusLarge),
                    ),
                  ),
                ),
              ],
            ),
            size20h,
            AppStyles.dividerLine(),
            size20h,
          ],
        ),
      );
    });
  }
}
