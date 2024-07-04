import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'Languages/arabic.dart';
import 'Languages/english.dart';

class Translation extends Translations {
  @override
  // TODO: implement keys
  //Map<String, Map<String, String>> get keys => throw UnimplementedError();
  Map<String, Map<String, String>> get keys => {
        'en_US': english(),
        'ar_AR': arabic(),
      };
}
