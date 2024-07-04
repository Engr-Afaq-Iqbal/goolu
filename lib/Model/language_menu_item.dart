import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Controller/AuthController/auth_controller.dart';
import '../Utils/font_styles.dart';

class LanguageMenuItem {
  const LanguageMenuItem({
    required this.text,
  });

  final String text;
}

abstract class LanguageMenuItems {
  static const List<LanguageMenuItem> firstItems = [
    english,
    arabic,
  ];

  static const english = LanguageMenuItem(
    text: 'English',
  );
  static const arabic = LanguageMenuItem(
    text: 'العربية',
  );

  static Widget buildItem(LanguageMenuItem item) {
    return Row(
      children: [
        Expanded(
            child: customText(text: item.text, textStyle: regular16NavyBlue)),
      ],
    );
  }

  static void onChanged(BuildContext context, LanguageMenuItem item) {
    switch (item) {
      case LanguageMenuItems.english:
        Get.find<AuthController>().selectLanguage = 'English';
        Get.updateLocale(const Locale('en', 'US'));
        Get.find<AuthController>().update();
        break;
      case LanguageMenuItems.arabic:
        Get.find<AuthController>().selectLanguage = 'العربية';
        Get.updateLocale(const Locale('ar', 'AR'));
        Get.find<AuthController>().update();
        break;
    }
  }
}
