import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/CameraController/camera_controller.dart';

import '../Utils/font_styles.dart';

class LanguageTextToTranslation {
  const LanguageTextToTranslation({
    required this.text,
    required this.languageCode,
  });

  final String text;
  final String languageCode; // Add language code for TTS
}

abstract class LanguageTextToTranslations {
  static const List<LanguageTextToTranslation> firstItems = [
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

  static const arabic = LanguageTextToTranslation(
    text: 'العربية',
    languageCode: 'ar-SA',
  );
  static const urdu = LanguageTextToTranslation(
    text: 'Urdu',
    languageCode: 'ur-PK',
  );
  static const chinese = LanguageTextToTranslation(
    text: 'Chinese',
    languageCode: 'zh-CN',
  );
  static const phillipino = LanguageTextToTranslation(
    text: 'Phillipino',
    languageCode: 'fil-PH',
  );
  static const bengali = LanguageTextToTranslation(
    text: 'Bengali',
    languageCode: 'bn-BD',
  );
  static const spanish = LanguageTextToTranslation(
    text: 'Spanish',
    languageCode: 'es-ES',
  );
  static const german = LanguageTextToTranslation(
    text: 'German',
    languageCode: 'de-DE',
  );
  static const french = LanguageTextToTranslation(
    text: 'French',
    languageCode: 'fr-FR',
  );
  static const farsi = LanguageTextToTranslation(
    text: 'Farsi',
    languageCode: 'fa-IR',
  );
  static const english = LanguageTextToTranslation(
    text: 'English',
    languageCode: 'en-US',
  );

  static Widget buildItem(LanguageTextToTranslation item) {
    return Row(
      children: [
        Expanded(
            child: customText(text: item.text, textStyle: regular16NavyBlue)),
      ],
    );
  }

  static void onChanged(BuildContext context, LanguageTextToTranslation item) {
    final CameraController cameraController = Get.find<CameraController>();
    cameraController.selectedLanguage = item.text; // Set selected language name
    cameraController.selectedLanguageCode =
        item.languageCode; // Set language code for TTS
    cameraController.update(); // Notify listeners
  }

  // static void onChanged(BuildContext context, LanguageTextToTranslation item) {
  //   final CameraController cameraController = Get.find<CameraController>();
  //   switch (item) {
  //     case LanguageTextToTranslations.arabic:
  //       cameraController.selectedLanguage = 'Arabic';
  //       break;
  //     case LanguageTextToTranslations.urdu:
  //       cameraController.selectedLanguage = 'Urdu';
  //       break;
  //     case LanguageTextToTranslations.chinese:
  //       cameraController.selectedLanguage = 'Chinese';
  //       break;
  //     case LanguageTextToTranslations.phillipino:
  //       cameraController.selectedLanguage = 'Phillipino';
  //       break;
  //     case LanguageTextToTranslations.bengali:
  //       cameraController.selectedLanguage = 'Bengali';
  //       break;
  //     case LanguageTextToTranslations.spanish:
  //       cameraController.selectedLanguage = 'Spanish';
  //       break;
  //     case LanguageTextToTranslations.german:
  //       cameraController.selectedLanguage = 'German';
  //       break;
  //     case LanguageTextToTranslations.french:
  //       cameraController.selectedLanguage = 'French';
  //       break;
  //     case LanguageTextToTranslations.farsi:
  //       cameraController.selectedLanguage = 'Farsi';
  //       break;
  //     case LanguageTextToTranslations.english:
  //       cameraController.selectedLanguage = 'English';
  //       break;
  //     default:
  //       break;
  //   }
  //   cameraController.update();
  // }
}
