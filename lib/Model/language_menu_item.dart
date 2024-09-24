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
    urdu,
    chinese,
    phillipino,
    bengali,
    spanish,
    german,
    french,
    farsi,
  ];

  static const english = LanguageMenuItem(
    text: 'English',
  );
  static const arabic = LanguageMenuItem(
    text: 'العربية',
  );
  static const urdu = LanguageMenuItem(
    text: 'Urdu',
  );
  static const chinese = LanguageMenuItem(
    text: 'Chinese',
  );
  static const phillipino = LanguageMenuItem(
    text: 'Phillipino',
  );
  static const bengali = LanguageMenuItem(
    text: 'Bengali',
  );
  static const spanish = LanguageMenuItem(
    text: 'Spanish ',
  );
  static const german = LanguageMenuItem(
    text: 'German',
  );
  static const french = LanguageMenuItem(
    text: 'French',
  );
  static const farsi = LanguageMenuItem(
    text: 'Farsi ',
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
    final AuthController authController = Get.find<AuthController>();
    switch (item) {
      case LanguageMenuItems.english:
        authController.selectLanguage = 'English';
        Get.updateLocale(const Locale('en', 'US'));
        break;
      case LanguageMenuItems.arabic:
        authController.selectLanguage = 'العربية';
        Get.updateLocale(const Locale('ar', 'AR'));
        break;
      case LanguageMenuItems.urdu:
        authController.selectLanguage = 'Urdu';
        Get.updateLocale(const Locale('ur', 'PK'));
        break;
      case LanguageMenuItems.chinese:
        authController.selectLanguage = 'Chinese';
        Get.updateLocale(const Locale('zh', 'CN'));
        break;
      case LanguageMenuItems.phillipino:
        authController.selectLanguage = 'Phillipino';
        Get.updateLocale(const Locale('tl', 'PH'));
        break;
      case LanguageMenuItems.bengali:
        authController.selectLanguage = 'Bengali';
        Get.updateLocale(const Locale('bn', 'BD'));
        break;
      case LanguageMenuItems.spanish:
        authController.selectLanguage = 'Spanish';
        Get.updateLocale(const Locale('es', 'ES'));
        break;
      case LanguageMenuItems.german:
        authController.selectLanguage = 'German';
        Get.updateLocale(const Locale('de', 'DE'));
        break;
      case LanguageMenuItems.french:
        authController.selectLanguage = 'French';
        Get.updateLocale(const Locale('fr', 'FR'));
        break;
      case LanguageMenuItems.farsi:
        authController.selectLanguage = 'Farsi';
        Get.updateLocale(const Locale('fa', 'IR'));
        break;
      default:
        break;
    }
    authController.update();
  }
}
