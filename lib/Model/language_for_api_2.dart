import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/MicrophoneController/microphone_controller.dart';

import '../Utils/font_styles.dart';

//
// class LanguageMenuItemForApi2 {
//   const LanguageMenuItemForApi2({
//     required this.text,
//   });
//
//   final String text;
// }
//
// abstract class LanguageMenuItemsForApi2 {
//   static const List<LanguageMenuItemForApi2> firstItems = [
//     arabic,
//     urdu,
//     chinese,
//     phillipino,
//     bengali,
//     spanish,
//     german,
//     french,
//     farsi,
//     english,
//   ];
//
//   static const arabic = LanguageMenuItemForApi2(
//     text: 'العربية',
//   );
//   static const urdu = LanguageMenuItemForApi2(
//     text: 'Urdu',
//   );
//   static const chinese = LanguageMenuItemForApi2(
//     text: 'Chinese',
//   );
//   static const phillipino = LanguageMenuItemForApi2(
//     text: 'Phillipino',
//   );
//   static const bengali = LanguageMenuItemForApi2(
//     text: 'Bengali',
//   );
//   static const spanish = LanguageMenuItemForApi2(
//     text: 'Spanish ',
//   );
//   static const german = LanguageMenuItemForApi2(
//     text: 'German',
//   );
//   static const french = LanguageMenuItemForApi2(
//     text: 'French',
//   );
//   static const farsi = LanguageMenuItemForApi2(
//     text: 'Farsi ',
//   );
//   static const english = LanguageMenuItemForApi2(
//     text: 'English ',
//   );
//
//   static Widget buildItem(LanguageMenuItemForApi2 item) {
//     return Row(
//       children: [
//         Expanded(
//             child: customText(text: item.text, textStyle: regular16NavyBlue)),
//       ],
//     );
//   }
//
//   static void onChanged(BuildContext context, LanguageMenuItemForApi2 item) {
//     final MicrophoneController microPhoneCtrl =
//         Get.find<MicrophoneController>();
//     switch (item) {
//       case LanguageMenuItemsForApi2.arabic:
//         microPhoneCtrl.selectedLanguage2 = 'Arabic';
//         break;
//       case LanguageMenuItemsForApi2.urdu:
//         microPhoneCtrl.selectedLanguage2 = 'Urdu';
//         break;
//       case LanguageMenuItemsForApi2.chinese:
//         microPhoneCtrl.selectedLanguage2 = 'Chinese';
//         break;
//       case LanguageMenuItemsForApi2.phillipino:
//         microPhoneCtrl.selectedLanguage2 = 'Phillipino';
//         break;
//       case LanguageMenuItemsForApi2.bengali:
//         microPhoneCtrl.selectedLanguage2 = 'Bengali';
//         break;
//       case LanguageMenuItemsForApi2.spanish:
//         microPhoneCtrl.selectedLanguage2 = 'Spanish';
//         break;
//       case LanguageMenuItemsForApi2.german:
//         microPhoneCtrl.selectedLanguage2 = 'German';
//         break;
//       case LanguageMenuItemsForApi2.french:
//         microPhoneCtrl.selectedLanguage2 = 'French';
//         break;
//       case LanguageMenuItemsForApi2.farsi:
//         microPhoneCtrl.selectedLanguage2 = 'Farsi';
//         break;
//       case LanguageMenuItemsForApi2.english:
//         microPhoneCtrl.selectedLanguage2 = 'English';
//         break;
//       default:
//         break;
//     }
//     microPhoneCtrl.update();
//   }
// }
class LanguageMenuItemForApi2 {
  const LanguageMenuItemForApi2({
    required this.text,
    required this.languageCode,
  });

  final String text;
  final String languageCode; // Add language code for TTS
}

abstract class LanguageMenuItemsForApi2 {
  static const List<LanguageMenuItemForApi2> firstItems = [
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

  static const arabic = LanguageMenuItemForApi2(
    text: 'العربية',
    languageCode: 'ar-SA',
  );
  static const urdu = LanguageMenuItemForApi2(
    text: 'Urdu',
    languageCode: 'ur-PK',
  );
  static const chinese = LanguageMenuItemForApi2(
    text: 'Chinese',
    languageCode: 'zh-CN',
  );
  static const phillipino = LanguageMenuItemForApi2(
    text: 'Phillipino',
    languageCode: 'fil-PH',
  );
  static const bengali = LanguageMenuItemForApi2(
    text: 'Bengali',
    languageCode: 'bn-BD',
  );
  static const spanish = LanguageMenuItemForApi2(
    text: 'Spanish',
    languageCode: 'es-ES',
  );
  static const german = LanguageMenuItemForApi2(
    text: 'German',
    languageCode: 'de-DE',
  );
  static const french = LanguageMenuItemForApi2(
    text: 'French',
    languageCode: 'fr-FR',
  );
  static const farsi = LanguageMenuItemForApi2(
    text: 'Farsi',
    languageCode: 'fa-IR',
  );
  static const english = LanguageMenuItemForApi2(
    text: 'English',
    languageCode: 'en-US',
  );

  static Widget buildItem(LanguageMenuItemForApi2 item) {
    return Row(
      children: [
        Expanded(
            child: customText(text: item.text, textStyle: regular16NavyBlue)),
      ],
    );
  }

  static void onChanged(BuildContext context, LanguageMenuItemForApi2 item) {
    final MicrophoneController microPhoneCtrl =
        Get.find<MicrophoneController>();
    microPhoneCtrl.selectedLanguage2 = item.text; // Set selected language name
    microPhoneCtrl.selectedLanguageCode =
        item.languageCode; // Set language code for TTS
    microPhoneCtrl.update(); // Notify listeners
  }
}
