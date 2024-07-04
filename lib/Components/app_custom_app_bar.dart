import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Config/app_config.dart';
import '../Controller/AuthController/auth_controller.dart';
import '../Model/language_menu_item.dart';
import '../Theme/colors.dart';
import '../Utils/dimensions.dart';
import '../Utils/font_styles.dart';

class AppCustomAppBar extends StatelessWidget {
  final bool? showBackButton;
  const AppCustomAppBar({super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (AuthController authCtrl) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showBackButton == true)
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                children: [
                  SvgPicture.asset('${imgUrl}backArrow.svg'),
                  customText(
                    text: 'previous'.tr,
                    textStyle: regular14DarkGrey,
                  ),
                ],
              ),
            ),
          const Spacer(),
          Row(
            children: [
              customText(
                text: authCtrl.selectedLanguage,
                textStyle: regular14DarkGrey,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  customButton: SvgPicture.asset('${imgUrl}downArrow.svg'),
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
          )
        ],
      );
    });
  }
}
