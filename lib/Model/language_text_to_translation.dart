import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/CameraController/camera_controller.dart';

import '../Utils/font_styles.dart';

class LanguageTextToTranslation {
  const LanguageTextToTranslation({
    required this.text,
  });

  final String text;
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
  );
  static const urdu = LanguageTextToTranslation(
    text: 'Urdu',
  );
  static const chinese = LanguageTextToTranslation(
    text: 'Chinese',
  );
  static const phillipino = LanguageTextToTranslation(
    text: 'Phillipino',
  );
  static const bengali = LanguageTextToTranslation(
    text: 'Bengali',
  );
  static const spanish = LanguageTextToTranslation(
    text: 'Spanish ',
  );
  static const german = LanguageTextToTranslation(
    text: 'German',
  );
  static const french = LanguageTextToTranslation(
    text: 'French',
  );
  static const farsi = LanguageTextToTranslation(
    text: 'Farsi ',
  );
  static const english = LanguageTextToTranslation(
    text: 'English ',
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
    switch (item) {
      case LanguageTextToTranslations.arabic:
        cameraController.selectedLanguage = 'Arabic';
        break;
      case LanguageTextToTranslations.urdu:
        cameraController.selectedLanguage = 'Urdu';
        break;
      case LanguageTextToTranslations.chinese:
        cameraController.selectedLanguage = 'Chinese';
        break;
      case LanguageTextToTranslations.phillipino:
        cameraController.selectedLanguage = 'Phillipino';
        break;
      case LanguageTextToTranslations.bengali:
        cameraController.selectedLanguage = 'Bengali';
        break;
      case LanguageTextToTranslations.spanish:
        cameraController.selectedLanguage = 'Spanish';
        break;
      case LanguageTextToTranslations.german:
        cameraController.selectedLanguage = 'German';
        break;
      case LanguageTextToTranslations.french:
        cameraController.selectedLanguage = 'French';
        break;
      case LanguageTextToTranslations.farsi:
        cameraController.selectedLanguage = 'Farsi';
        break;
      case LanguageTextToTranslations.english:
        cameraController.selectedLanguage = 'English';
        break;
      default:
        break;
    }
    cameraController.update();
  }
}
