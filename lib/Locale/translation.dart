import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'Languages/arabic.dart';
import 'Languages/bengali.dart';
import 'Languages/chinese.dart';
import 'Languages/english.dart';
import 'Languages/farsi.dart';
import 'Languages/filipino.dart';
import 'Languages/french.dart';
import 'Languages/german.dart';
import 'Languages/spanish.dart';
import 'Languages/urdu.dart';

class Translation extends Translations {
  @override
  // TODO: implement keys
  //Map<String, Map<String, String>> get keys => throw UnimplementedError();
  Map<String, Map<String, String>> get keys => {
        'en_US': english(),
        'ar_AR': arabic(),
        'ur_PK': urdu(),
        'zh_CN': chinese(),
        'fil_PH': filipino(),
        'bn_BD': bengali(),
        'es_ES': spanish(),
        'de_DE': german(),
        'fr_FR': french(),
        'fa_IR': farsi(),
      };
}
