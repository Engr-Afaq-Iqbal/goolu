import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/MicrophoneController/microphone_controller.dart';

import '../Utils/font_styles.dart';

class LanguageMenuItemForApi {
  const LanguageMenuItemForApi({
    required this.text,
  });

  final String text;
}

abstract class LanguageMenuItemsForApi {
  static const List<LanguageMenuItemForApi> firstItems = [
    arabic,
    urdu,
    chinese,
    phillipino,
    bengali,
    spanish,
    german,
    french,
    farsi,
    english,
  ];

  static const arabic = LanguageMenuItemForApi(
    text: 'العربية',
  );
  static const urdu = LanguageMenuItemForApi(
    text: 'Urdu',
  );
  static const chinese = LanguageMenuItemForApi(
    text: 'Chinese',
  );
  static const phillipino = LanguageMenuItemForApi(
    text: 'Phillipino',
  );
  static const bengali = LanguageMenuItemForApi(
    text: 'Bengali',
  );
  static const spanish = LanguageMenuItemForApi(
    text: 'Spanish ',
  );
  static const german = LanguageMenuItemForApi(
    text: 'German',
  );
  static const french = LanguageMenuItemForApi(
    text: 'French',
  );
  static const farsi = LanguageMenuItemForApi(
    text: 'Farsi ',
  );
  static const english = LanguageMenuItemForApi(
    text: 'English ',
  );

  static Widget buildItem(LanguageMenuItemForApi item) {
    return Row(
      children: [
        Expanded(
            child: customText(text: item.text, textStyle: regular16NavyBlue)),
      ],
    );
  }

  static void onChanged(BuildContext context, LanguageMenuItemForApi item) {
    final MicrophoneController microPhoneCtrl =
        Get.find<MicrophoneController>();
    switch (item) {
      case LanguageMenuItemsForApi.arabic:
        microPhoneCtrl.selectedLanguage = 'Arabic';
        break;
      case LanguageMenuItemsForApi.urdu:
        microPhoneCtrl.selectedLanguage = 'Urdu';
        break;
      case LanguageMenuItemsForApi.chinese:
        microPhoneCtrl.selectedLanguage = 'Chinese';
        break;
      case LanguageMenuItemsForApi.phillipino:
        microPhoneCtrl.selectedLanguage = 'Phillipino';
        break;
      case LanguageMenuItemsForApi.bengali:
        microPhoneCtrl.selectedLanguage = 'Bengali';
        break;
      case LanguageMenuItemsForApi.spanish:
        microPhoneCtrl.selectedLanguage = 'Spanish';
        break;
      case LanguageMenuItemsForApi.german:
        microPhoneCtrl.selectedLanguage = 'German';
        break;
      case LanguageMenuItemsForApi.french:
        microPhoneCtrl.selectedLanguage = 'French';
        break;
      case LanguageMenuItemsForApi.farsi:
        microPhoneCtrl.selectedLanguage = 'Farsi';
        break;
      case LanguageMenuItemsForApi.english:
        microPhoneCtrl.selectedLanguage = 'English';
        break;
      default:
        break;
    }
    microPhoneCtrl.update();
  }
}
